import '../models/standing_model.dart';

/// Offline cached representation of a team's tournament standing.
/// Clean, null-safe local caching model with instant persistence support.
///
/// NOTE: If you wish to use Isar code generation in the future, uncomment:
/// // part 'cached_standing_schema.g.dart';
/// and run: `dart run build_runner build`
class CachedStanding {
  int id;
  String standingId;
  String tournamentId;
  int rank;
  String teamId;
  String teamName;
  String teamLogoUrl;
  int matchesPlayed;
  int wwcdCount;
  int placementPoints;
  int killPoints;
  int totalPoints;
  DateTime cachedAt;

  CachedStanding({
    this.id = 0,
    this.standingId = '',
    this.tournamentId = '',
    this.rank = 0,
    this.teamId = '',
    this.teamName = '',
    this.teamLogoUrl = '',
    this.matchesPlayed = 0,
    this.wwcdCount = 0,
    this.placementPoints = 0,
    this.killPoints = 0,
    this.totalPoints = 0,
    DateTime? cachedAt,
  }) : cachedAt = cachedAt ?? DateTime.now();

  static CachedStanding fromModel(StandingModel model) {
    return CachedStanding(
      standingId: model.id,
      tournamentId: model.tournamentId,
      rank: model.rank,
      teamId: model.teamId,
      teamName: model.teamName,
      teamLogoUrl: model.teamLogoUrl,
      matchesPlayed: model.matchesPlayed,
      wwcdCount: model.wwcdCount,
      placementPoints: model.placementPoints,
      killPoints: model.killPoints,
      totalPoints: model.totalPoints,
      cachedAt: DateTime.now(),
    );
  }

  StandingModel toModel() {
    return StandingModel(
      id: standingId,
      tournamentId: tournamentId,
      rank: rank,
      teamId: teamId,
      teamName: teamName,
      teamLogoUrl: teamLogoUrl,
      matchesPlayed: matchesPlayed,
      wwcdCount: wwcdCount,
      placementPoints: placementPoints,
      killPoints: killPoints,
      totalPoints: totalPoints,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'standingId': standingId,
    'tournamentId': tournamentId,
    'rank': rank,
    'teamId': teamId,
    'teamName': teamName,
    'teamLogoUrl': teamLogoUrl,
    'matchesPlayed': matchesPlayed,
    'wwcdCount': wwcdCount,
    'placementPoints': placementPoints,
    'killPoints': killPoints,
    'totalPoints': totalPoints,
    'cachedAt': cachedAt.toIso8601String(),
  };

  factory CachedStanding.fromJson(Map<String, dynamic> json) => CachedStanding(
    id: json['id'] ?? 0,
    standingId: json['standingId'] ?? '',
    tournamentId: json['tournamentId'] ?? '',
    rank: json['rank'] ?? 0,
    teamId: json['teamId'] ?? '',
    teamName: json['teamName'] ?? '',
    teamLogoUrl: json['teamLogoUrl'] ?? '',
    matchesPlayed: json['matchesPlayed'] ?? 0,
    wwcdCount: json['wwcdCount'] ?? 0,
    placementPoints: json['placementPoints'] ?? 0,
    killPoints: json['killPoints'] ?? 0,
    totalPoints: json['totalPoints'] ?? 0,
    cachedAt: DateTime.tryParse(json['cachedAt'] ?? '') ?? DateTime.now(),
  );
}
