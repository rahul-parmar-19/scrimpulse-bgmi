import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';
import '../../../data/repositories/esports_repository.dart';
import '../../../data/repositories/mock_data_generator.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final EsportsRepository _repository;
  StreamSubscription? _standingsSubscription;
  StreamSubscription? _tournamentSubscription;

  LeaderboardBloc({required EsportsRepository repository})
      : _repository = repository,
        super(LeaderboardState(
          status: LeaderboardStatus.loaded,
          tournament: MockDataGenerator.getTournament(),
          standings: MockDataGenerator.getStandings(),
        )) {
    on<StartLeaderboardStreamEvent>(_onStartStream);
    on<UpdateStandingsEvent>(_onUpdateStandings);
    on<UpdateTournamentEvent>(_onUpdateTournament);
    on<RefreshLeaderboardEvent>(_onRefresh);
  }

  void _onStartStream(
    StartLeaderboardStreamEvent event,
    Emitter<LeaderboardState> emit,
  ) {
    if (state.standings.isEmpty) {
      emit(state.copyWith(status: LeaderboardStatus.loading));
    }

    _standingsSubscription?.cancel();
    _tournamentSubscription?.cancel();

    _tournamentSubscription = _repository
        .getActiveTournamentStream(event.tournamentId)
        .listen((tournament) {
      add(UpdateTournamentEvent(tournament));
    });

    _standingsSubscription = _repository
        .getStandingsStream(event.tournamentId)
        .listen((standings) {
      add(UpdateStandingsEvent(standings));
    });
  }

  void _onUpdateStandings(
    UpdateStandingsEvent event,
    Emitter<LeaderboardState> emit,
  ) {
    emit(state.copyWith(
      status: LeaderboardStatus.loaded,
      standings: event.standings,
    ));
  }

  void _onUpdateTournament(
    UpdateTournamentEvent event,
    Emitter<LeaderboardState> emit,
  ) {
    emit(state.copyWith(
      tournament: event.tournament,
    ));
  }

  void _onRefresh(
    RefreshLeaderboardEvent event,
    Emitter<LeaderboardState> emit,
  ) {
    add(StartLeaderboardStreamEvent(event.tournamentId));
  }

  @override
  Future<void> close() {
    _standingsSubscription?.cancel();
    _tournamentSubscription?.cancel();
    return super.close();
  }
}

