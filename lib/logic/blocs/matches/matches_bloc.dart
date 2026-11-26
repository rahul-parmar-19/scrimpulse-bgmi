import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'matches_event.dart';
import 'matches_state.dart';
import '../../../data/models/match_model.dart';
import '../../../data/repositories/esports_repository.dart';
import '../../../data/repositories/mock_data_generator.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final EsportsRepository _repository;
  StreamSubscription? _matchesSubscription;

  MatchesBloc({required EsportsRepository repository})
      : _repository = repository,
        super(MatchesState(
          status: MatchesStatus.loaded,
          allMatches: MockDataGenerator.getMatches(),
          filteredMatches: MockDataGenerator.getMatches(),
        )) {
    on<StartMatchesStreamEvent>(_onStartStream);
    on<UpdateMatchesListEvent>(_onUpdateMatches);
    on<FilterByMapEvent>(_onFilterByMap);
  }

  void _onStartStream(
    StartMatchesStreamEvent event,
    Emitter<MatchesState> emit,
  ) {
    if (state.allMatches.isEmpty) {
      emit(state.copyWith(status: MatchesStatus.loading));
    }

    _matchesSubscription?.cancel();
    _matchesSubscription = _repository
        .getMatchesStream(event.tournamentId)
        .listen((matches) {
      add(UpdateMatchesListEvent(matches));
    });
  }

  void _onUpdateMatches(
    UpdateMatchesListEvent event,
    Emitter<MatchesState> emit,
  ) {
    final filtered = _applyFilter(event.matches, state.selectedMap);
    emit(state.copyWith(
      status: MatchesStatus.loaded,
      allMatches: event.matches,
      filteredMatches: filtered,
    ));
  }

  void _onFilterByMap(
    FilterByMapEvent event,
    Emitter<MatchesState> emit,
  ) {
    final filtered = _applyFilter(state.allMatches, event.selectedMap);
    emit(state.copyWith(
      selectedMap: event.selectedMap,
      filteredMatches: filtered,
    ));
  }

  List<MatchModel> _applyFilter(List<MatchModel> list, String mapFilter) {
    if (mapFilter == 'ALL') return list;
    return list
        .where((m) => m.mapName.toLowerCase() == mapFilter.toLowerCase())
        .toList();
  }

  @override
  Future<void> close() {
    _matchesSubscription?.cancel();
    return super.close();
  }
}

