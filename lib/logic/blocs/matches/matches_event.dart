import 'package:equatable/equatable.dart';
import '../../../data/models/match_model.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object?> get props => [];
}

class StartMatchesStreamEvent extends MatchesEvent {
  final String tournamentId;
  const StartMatchesStreamEvent(this.tournamentId);

  @override
  List<Object?> get props => [tournamentId];
}

class FilterByMapEvent extends MatchesEvent {
  final String selectedMap; // "ALL", "Erangel", "Miramar", "Sanhok", "Rondo"
  const FilterByMapEvent(this.selectedMap);

  @override
  List<Object?> get props => [selectedMap];
}

class UpdateMatchesListEvent extends MatchesEvent {
  final List<MatchModel> matches;
  const UpdateMatchesListEvent(this.matches);

  @override
  List<Object?> get props => [matches];
}

