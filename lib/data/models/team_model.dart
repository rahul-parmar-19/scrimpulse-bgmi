import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final String playerName;
  final String role; // "IGL", "Assaulter", "Support", "Sniper"
  final String imageUrl;
  final int totalKills;
  final double kdRatio;

  const PlayerModel({
    required this.playerName,
    required this.role,
    this.imageUrl = '',
    this.totalKills = 0,
    this.kdRatio = 0.0,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      playerName: map['player_name'] ?? 'Player',
      role: map['role'] ?? 'Assaulter',
      imageUrl: map['image_url'] ?? '',
      totalKills: (map['total_kills'] as num?)?.toInt() ?? 0,
      kdRatio: (map['kd_ratio'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'player_name': playerName,
      'role': role,
      'image_url': imageUrl,
      'total_kills': totalKills,
      'kd_ratio': kdRatio,
    };
  }

  @override
  List<Object?> get props => [playerName, role, imageUrl, totalKills, kdRatio];
}

class TeamModel extends Equatable {
  final String teamId;
  final String teamName;
  final String tag;
  final String logoUrl;
  final List<PlayerModel> roster;

  const TeamModel({
    required this.teamId,
    required this.teamName,
    this.tag = '',
    required this.logoUrl,
    required this.roster,
  });

  factory TeamModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final rawRoster = data['roster'] as List<dynamic>? ?? [];
    final rosterList = rawRoster
        .map((e) => PlayerModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return TeamModel(
      teamId: doc.id,
      teamName: data['team_name'] ?? 'Unknown Team',
      tag: data['tag'] ?? '',
      logoUrl: data['logo_url'] ?? '',
      roster: rosterList,
    );
  }

  factory TeamModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final rawRoster = map['roster'] as List<dynamic>? ?? [];
    final rosterList = rawRoster
        .map((e) => PlayerModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return TeamModel(
      teamId: id ?? map['team_id'] ?? '',
      teamName: map['team_name'] ?? 'Unknown Team',
      tag: map['tag'] ?? '',
      logoUrl: map['logo_url'] ?? '',
      roster: rosterList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_name': teamName,
      'tag': tag,
      'logo_url': logoUrl,
      'roster': roster.map((p) => p.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [teamId, teamName, tag, logoUrl, roster];
}

