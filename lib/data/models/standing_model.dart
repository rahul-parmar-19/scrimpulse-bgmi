import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StandingModel extends Equatable {
  final String id;
  final String tournamentId;
  final int rank;
  final String teamId;
  final String teamName;
  final String teamLogoUrl;
  final int matchesPlayed;
  final int wwcdCount;
  final int placementPoints;
  final int killPoints;
  final int totalPoints;

  const StandingModel({
    required this.id,
    required this.tournamentId,
    required this.rank,
    required this.teamId,
    required this.teamName,
    required this.teamLogoUrl,
    required this.matchesPlayed,
    required this.wwcdCount,
    required this.placementPoints,
    required this.killPoints,
    required this.totalPoints,
  });

  StandingModel copyWith({
    String? id,
    String? tournamentId,
    int? rank,
    String? teamId,
    String? teamName,
    String? teamLogoUrl,
    int? matchesPlayed,
    int? wwcdCount,
    int? placementPoints,
    int? killPoints,
    int? totalPoints,
  }) {
    return StandingModel(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      rank: rank ?? this.rank,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamLogoUrl: teamLogoUrl ?? this.teamLogoUrl,
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      wwcdCount: wwcdCount ?? this.wwcdCount,
      placementPoints: placementPoints ?? this.placementPoints,
      killPoints: killPoints ?? this.killPoints,
      totalPoints: totalPoints ?? (placementPoints != null || killPoints != null 
          ? (placementPoints ?? this.placementPoints) + (killPoints ?? this.killPoints)
          : this.totalPoints),
    );
  }

  factory StandingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final placement = (data['placement_points'] as num?)?.toInt() ?? 0;
    final kills = (data['kill_points'] as num?)?.toInt() ?? 0;
    final total = (data['total_points'] as num?)?.toInt() ?? (placement + kills);

    return StandingModel(
      id: doc.id,
      tournamentId: data['tournament_id'] ?? '',
      rank: (data['rank'] as num?)?.toInt() ?? 0,
      teamId: data['team_id'] ?? '',
      teamName: data['team_name'] ?? 'Unknown Team',
      teamLogoUrl: data['team_logo_url'] ?? '',
      matchesPlayed: (data['matches_played'] as num?)?.toInt() ?? 0,
      wwcdCount: (data['wwcd_count'] as num?)?.toInt() ?? 0,
      placementPoints: placement,
      killPoints: kills,
      totalPoints: total,
    );
  }

  factory StandingModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final placement = (map['placement_points'] as num?)?.toInt() ?? 0;
    final kills = (map['kill_points'] as num?)?.toInt() ?? 0;
    final total = (map['total_points'] as num?)?.toInt() ?? (placement + kills);

    return StandingModel(
      id: id ?? map['id'] ?? '',
      tournamentId: map['tournament_id'] ?? '',
      rank: (map['rank'] as num?)?.toInt() ?? 0,
      teamId: map['team_id'] ?? '',
      teamName: map['team_name'] ?? 'Unknown Team',
      teamLogoUrl: map['team_logo_url'] ?? '',
      matchesPlayed: (map['matches_played'] as num?)?.toInt() ?? 0,
      wwcdCount: (map['wwcd_count'] as num?)?.toInt() ?? 0,
      placementPoints: placement,
      killPoints: kills,
      totalPoints: total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tournament_id': tournamentId,
      'rank': rank,
      'team_id': teamId,
      'team_name': teamName,
      'team_logo_url': teamLogoUrl,
      'matches_played': matchesPlayed,
      'wwcd_count': wwcdCount,
      'placement_points': placementPoints,
      'kill_points': killPoints,
      'total_points': totalPoints,
    };
  }

  @override
  List<Object?> get props => [
        id,
        tournamentId,
        rank,
        teamId,
        teamName,
        teamLogoUrl,
        matchesPlayed,
        wwcdCount,
        placementPoints,
        killPoints,
        totalPoints,
      ];
}

