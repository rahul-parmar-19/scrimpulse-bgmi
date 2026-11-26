import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MatchModel extends Equatable {
  final String matchId;
  final String tournamentId;
  final int matchNumber;
  final String mapName; // "Erangel", "Miramar", "Sanhok", "Rondo"
  final String groupInfo;
  final DateTime startTime;
  final bool isLive;
  final String winnerTeam;

  const MatchModel({
    required this.matchId,
    required this.tournamentId,
    required this.matchNumber,
    required this.mapName,
    required this.groupInfo,
    required this.startTime,
    required this.isLive,
    this.winnerTeam = '',
  });

  factory MatchModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    DateTime parsedDate;
    final rawStartTime = data['start_time'];
    if (rawStartTime is Timestamp) {
      parsedDate = rawStartTime.toDate();
    } else if (rawStartTime is String) {
      parsedDate = DateTime.tryParse(rawStartTime) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return MatchModel(
      matchId: doc.id,
      tournamentId: data['tournament_id'] ?? '',
      matchNumber: data['match_number'] is int ? data['match_number'] : int.tryParse('${data['match_number']}') ?? 1,
      mapName: data['map_name'] ?? 'Erangel',
      groupInfo: data['group_info'] ?? 'Group Stage',
      startTime: parsedDate,
      isLive: data['is_live'] ?? false,
      winnerTeam: data['winner_team'] ?? '',
    );
  }

  factory MatchModel.fromMap(Map<String, dynamic> map, {String? id}) {
    DateTime parsedDate;
    final rawStartTime = map['start_time'];
    if (rawStartTime is Timestamp) {
      parsedDate = rawStartTime.toDate();
    } else if (rawStartTime is String) {
      parsedDate = DateTime.tryParse(rawStartTime) ?? DateTime.now();
    } else if (rawStartTime is DateTime) {
      parsedDate = rawStartTime;
    } else {
      parsedDate = DateTime.now();
    }

    return MatchModel(
      matchId: id ?? map['match_id'] ?? '',
      tournamentId: map['tournament_id'] ?? '',
      matchNumber: map['match_number'] is int ? map['match_number'] : int.tryParse('${map['match_number']}') ?? 1,
      mapName: map['map_name'] ?? 'Erangel',
      groupInfo: map['group_info'] ?? 'Group Stage',
      startTime: parsedDate,
      isLive: map['is_live'] ?? false,
      winnerTeam: map['winner_team'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tournament_id': tournamentId,
      'match_number': matchNumber,
      'map_name': mapName,
      'group_info': groupInfo,
      'start_time': Timestamp.fromDate(startTime),
      'is_live': isLive,
      'winner_team': winnerTeam,
    };
  }

  @override
  List<Object?> get props => [
        matchId,
        tournamentId,
        matchNumber,
        mapName,
        groupInfo,
        startTime,
        isLive,
        winnerTeam,
      ];
}

