import 'package:equatable/equatable.dart';
import '../../../data/models/standing_model.dart';
import '../../../data/models/tournament_model.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

class StartLeaderboardStreamEvent extends LeaderboardEvent {
  final String tournamentId;
  const StartLeaderboardStreamEvent(this.tournamentId);

  @override
  List<Object?> get props => [tournamentId];
}

class UpdateStandingsEvent extends LeaderboardEvent {
  final List<StandingModel> standings;
  const UpdateStandingsEvent(this.standings);

  @override
  List<Object?> get props => [standings];
}

class UpdateTournamentEvent extends LeaderboardEvent {
  final TournamentModel tournament;
  const UpdateTournamentEvent(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class RefreshLeaderboardEvent extends LeaderboardEvent {
  final String tournamentId;
  const RefreshLeaderboardEvent(this.tournamentId);

  @override
  List<Object?> get props => [tournamentId];
}

