import 'package:equatable/equatable.dart';
import '../../../data/models/standing_model.dart';
import '../../../data/models/tournament_model.dart';

enum LeaderboardStatus { initial, loading, loaded, error }

class LeaderboardState extends Equatable {
  final LeaderboardStatus status;
  final TournamentModel? tournament;
  final List<StandingModel> standings;
  final String? errorMessage;
  final bool isOfflineData;

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.tournament,
    this.standings = const [],
    this.errorMessage,
    this.isOfflineData = false,
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    TournamentModel? tournament,
    List<StandingModel>? standings,
    String? errorMessage,
    bool? isOfflineData,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      tournament: tournament ?? this.tournament,
      standings: standings ?? this.standings,
      errorMessage: errorMessage ?? this.errorMessage,
      isOfflineData: isOfflineData ?? this.isOfflineData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tournament,
        standings,
        errorMessage,
        isOfflineData,
      ];
}

