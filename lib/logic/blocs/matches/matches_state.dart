import 'package:equatable/equatable.dart';
import '../../../data/models/match_model.dart';

enum MatchesStatus { initial, loading, loaded, error }

class MatchesState extends Equatable {
  final MatchesStatus status;
  final List<MatchModel> allMatches;
  final List<MatchModel> filteredMatches;
  final String selectedMap;
  final String? errorMessage;

  const MatchesState({
    this.status = MatchesStatus.initial,
    this.allMatches = const [],
    this.filteredMatches = const [],
    this.selectedMap = 'ALL',
    this.errorMessage,
  });

  MatchesState copyWith({
    MatchesStatus? status,
    List<MatchModel>? allMatches,
    List<MatchModel>? filteredMatches,
    String? selectedMap,
    String? errorMessage,
  }) {
    return MatchesState(
      status: status ?? this.status,
      allMatches: allMatches ?? this.allMatches,
      filteredMatches: filteredMatches ?? this.filteredMatches,
      selectedMap: selectedMap ?? this.selectedMap,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allMatches,
        filteredMatches,
        selectedMap,
        errorMessage,
      ];
}

