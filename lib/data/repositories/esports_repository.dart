import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/match_model.dart';
import '../models/standing_model.dart';
import '../models/team_model.dart';
import '../models/tournament_model.dart';
import '../../core/services/isar_service.dart';
import '../../core/services/live_feed_service.dart';
import '../../core/utils/scoring_calculator.dart';
import 'mock_data_generator.dart';

class EsportsRepository {
  FirebaseFirestore? get _firestore {
    try {
      return FirebaseFirestore.instance;
    } catch (_) {
      return null;
    }
  }

  final IsarService _isarService = IsarService();

  // Firestore Collection Names
  static const String colTournaments = 'tournaments';
  static const String colMatches = 'matches';
  static const String colStandings = 'standings';
  static const String colTeams = 'teams';

  /// Real-time stream of the active tournament
  Stream<TournamentModel> getActiveTournamentStream(String tournamentId) {
    try {
      final firestore = _firestore;
      if (firestore == null) {
        return Stream.value(MockDataGenerator.getTournament());
      }
      return firestore
          .collection(colTournaments)
          .doc(tournamentId)
          .snapshots()
          .map((doc) {
        if (!doc.exists) {
          return MockDataGenerator.getTournament();
        }
        return TournamentModel.fromFirestore(doc);
      }).handleError((error) {
        debugPrint('[Repository] Tournament stream error: $error');
        return MockDataGenerator.getTournament();
      });
    } catch (e) {
      debugPrint('[Repository] Fallback to mock tournament: $e');
      return Stream.value(MockDataGenerator.getTournament());
    }
  }

  /// Real-time stream of Tournament Standings with 10-point ranking calculator
  Stream<List<StandingModel>> getStandingsStream(String tournamentId) {
    try {
      final firestore = _firestore;
      if (firestore == null) {
        return Stream.fromFuture(_fetchOfflineStandings(tournamentId));
      }
      return firestore
          .collection(colStandings)
          .where('tournament_id', isEqualTo: tournamentId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) {
          // If Firestore is empty, seed or return mock data
          final mockList = MockDataGenerator.getStandings();
          _isarService.cacheStandings(tournamentId, mockList);
          return ScoringCalculator.sortAndComputeRanks(mockList);
        }

        final list = snapshot.docs
            .map((doc) => StandingModel.fromFirestore(doc))
            .toList();

        // Dynamically compute and sort with tie-breakers
        final rankedList = ScoringCalculator.sortAndComputeRanks(list);

        // Cache in background for offline support
        _isarService.cacheStandings(tournamentId, rankedList);

        return rankedList;
      }).handleError((error) {
        debugPrint('[Repository] Standings stream error: $error. Fetching offline cache.');
        return _fetchOfflineStandings(tournamentId);
      });
    } catch (e) {
      debugPrint('[Repository] Firestore unavailable, serving local cache: $e');
      return Stream.fromFuture(_fetchOfflineStandings(tournamentId));
    }
  }

  /// Fallback offline retrieval
  Future<List<StandingModel>> _fetchOfflineStandings(String tournamentId) async {
    final cached = await _isarService.getCachedStandings(tournamentId);
    if (cached.isNotEmpty) {
      return ScoringCalculator.sortAndComputeRanks(cached);
    }
    return ScoringCalculator.sortAndComputeRanks(MockDataGenerator.getStandings());
  }

  /// Real-time stream of Tournament Matches
  Stream<List<MatchModel>> getMatchesStream(String tournamentId) {
    try {
      final firestore = _firestore;
      if (firestore == null) {
        return Stream.fromFuture(_fetchOfflineMatches(tournamentId));
      }
      return firestore
          .collection(colMatches)
          .where('tournament_id', isEqualTo: tournamentId)
          .orderBy('match_number', descending: false)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) {
          final mockMatches = MockDataGenerator.getMatches();
          _isarService.cacheMatches(tournamentId, mockMatches);
          return mockMatches;
        }

        final list = snapshot.docs
            .map((doc) => MatchModel.fromFirestore(doc))
            .toList();

        _isarService.cacheMatches(tournamentId, list);
        return list;
      }).handleError((error) {
        debugPrint('[Repository] Matches stream error: $error');
        return _fetchOfflineMatches(tournamentId);
      });
    } catch (e) {
      return Stream.fromFuture(_fetchOfflineMatches(tournamentId));
    }
  }

  Future<List<MatchModel>> _fetchOfflineMatches(String tournamentId) async {
    final cached = await _isarService.getCachedMatches(tournamentId);
    if (cached.isNotEmpty) {
      return cached;
    }
    return MockDataGenerator.getMatches();
  }

  /// Real-time stream of all participating Teams and Rosters
  Stream<List<TeamModel>> getTeamsStream() {
    try {
      final firestore = _firestore;
      if (firestore == null) {
        return Stream.value(MockDataGenerator.getTeams());
      }
      return firestore.collection(colTeams).snapshots().map((snapshot) {
        if (snapshot.docs.isEmpty) {
          return MockDataGenerator.getTeams();
        }
        return snapshot.docs
            .map((doc) => TeamModel.fromFirestore(doc))
            .toList();
      }).handleError((error) {
        debugPrint('[Repository] Teams stream error: $error');
        return MockDataGenerator.getTeams();
      });
    } catch (e) {
      return Stream.value(MockDataGenerator.getTeams());
    }
  }

  /// Seed initial tournament data into Firestore (convenience helper)
  /// Seed initial tournament data into Firestore using atomic batch sync
  Future<void> seedInitialTournamentData() async {
    try {
      final success = await LiveFeedService().syncToFirestore();
      if (success) {
        debugPrint('[Repository] Firestore batch sync completed successfully via LiveFeedService.');
        return;
      }

      final firestore = _firestore;
      if (firestore == null) {
        debugPrint('[Repository] Firestore not initialized, cannot seed.');
        return;
      }
      final tournament = MockDataGenerator.getTournament();
      await firestore
          .collection(colTournaments)
          .doc(tournament.id)
          .set(tournament.toMap(), SetOptions(merge: true));

      for (var standing in MockDataGenerator.getStandings()) {
        await firestore
            .collection(colStandings)
            .doc(standing.id)
            .set(standing.toMap(), SetOptions(merge: true));
      }

      for (var match in MockDataGenerator.getMatches()) {
        await firestore
            .collection(colMatches)
            .doc(match.matchId)
            .set(match.toMap(), SetOptions(merge: true));
      }

      for (var team in MockDataGenerator.getTeams()) {
        await firestore
            .collection(colTeams)
            .doc(team.teamId)
            .set(team.toMap(), SetOptions(merge: true));
      }
      debugPrint('[Repository] Firestore seed completed successfully.');
    } catch (e) {
      debugPrint('[Repository] Could not seed Firestore: $e');
    }
  }
}

