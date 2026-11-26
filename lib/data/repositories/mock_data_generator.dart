import '../models/match_model.dart';
import '../models/standing_model.dart';
import '../models/team_model.dart';
import '../models/tournament_model.dart';

class MockDataGenerator {
  static const String tournamentId = 'bmps_2025_grand_finals';

  static TournamentModel getTournament() {
    return const TournamentModel(
      id: tournamentId,
      name: 'BMPS 2025: GRAND FINALS - DAY 3',
      status: 'LIVE',
      liveStreamUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      liveStreamUrl: 'https://www.youtube.com/@kraftonindiaesports/live',
      totalPrize: '₹4,00,00,000 INR',
      bannerUrl:
          'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=1200&auto=format&fit=crop',
    );
  }

  static List<StandingModel> getStandings() {
    return [
      const StandingModel(
        id: 'std_1',
        tournamentId: tournamentId,
        rank: 1,
        teamId: 'team_xspark',
        teamName: 'Team XSpark',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 4,
        placementPoints: 68,
        killPoints: 94,
        totalPoints: 162,
      ),
      const StandingModel(
        id: 'std_2',
        tournamentId: tournamentId,
        rank: 2,
        teamId: 'team_godl',
        teamName: 'GodLike Esports',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 3,
        placementPoints: 58,
        killPoints: 89,
        totalPoints: 147,
      ),
      const StandingModel(
        id: 'std_3',
        tournamentId: tournamentId,
        rank: 3,
        teamId: 'team_soul',
        teamName: 'iQOO SouL',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 2,
        placementPoints: 52,
        killPoints: 84,
        totalPoints: 136,
      ),
      const StandingModel(
        id: 'std_4',
        tournamentId: tournamentId,
        rank: 4,
        teamId: 'team_8bit',
        teamName: 'iQOO 8Bit',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1563089145-599997674d42?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 2,
        placementPoints: 46,
        killPoints: 75,
        totalPoints: 121,
      ),
      const StandingModel(
        id: 'std_5',
        tournamentId: tournamentId,
        rank: 5,
        teamId: 'team_og',
        teamName: 'Orangutan Esports',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 1,
        placementPoints: 42,
        killPoints: 71,
        totalPoints: 113,
      ),
      const StandingModel(
        id: 'std_6',
        tournamentId: tournamentId,
        rank: 6,
        teamId: 'team_ge',
        teamName: 'Global Esports',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1579546929662-711aa81148cf?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 1,
        placementPoints: 36,
        killPoints: 66,
        totalPoints: 102,
      ),
      const StandingModel(
        id: 'std_7',
        tournamentId: tournamentId,
        rank: 7,
        teamId: 'team_versatile',
        teamName: 'Team Versatile',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 1,
        placementPoints: 34,
        killPoints: 61,
        totalPoints: 95,
      ),
      const StandingModel(
        id: 'std_8',
        tournamentId: tournamentId,
        rank: 8,
        teamId: 'team_tt',
        teamName: 'Team Tamilas',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 1,
        placementPoints: 30,
        killPoints: 56,
        totalPoints: 86,
      ),
      const StandingModel(
        id: 'std_9',
        tournamentId: tournamentId,
        rank: 9,
        teamId: 'team_rkn',
        teamName: 'Reckoning Esports',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1542751110-97427bbecf20?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 0,
        placementPoints: 26,
        killPoints: 52,
        totalPoints: 78,
      ),
      const StandingModel(
        id: 'std_10',
        tournamentId: tournamentId,
        rank: 10,
        teamId: 'team_medal',
        teamName: 'Medal Esports',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1534423861386-85a16f5d1345?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 0,
        placementPoints: 22,
        killPoints: 47,
        totalPoints: 69,
      ),
      const StandingModel(
        id: 'std_11',
        tournamentId: tournamentId,
        rank: 11,
        teamId: 'team_ent',
        teamName: 'Entity Gaming',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 0,
        placementPoints: 18,
        killPoints: 42,
        totalPoints: 60,
      ),
      const StandingModel(
        id: 'std_12',
        tournamentId: tournamentId,
        rank: 12,
        teamId: 'team_carnival',
        teamName: 'Carnival Gaming',
        teamLogoUrl:
            'https://images.unsplash.com/photo-1563089145-599997674d42?w=100&auto=format&fit=crop&q=60',
        matchesPlayed: 15,
        wwcdCount: 0,
        placementPoints: 14,
        killPoints: 38,
        totalPoints: 52,
      ),
    ];
  }

  static List<MatchModel> getMatches() {
    final now = DateTime.now();
    return [
      MatchModel(
        matchId: 'match_13',
        tournamentId: tournamentId,
        matchNumber: 13,
        mapName: 'Erangel',
        groupInfo: 'Grand Finals - Match 13',
        startTime: now.subtract(const Duration(minutes: 15)),
        isLive: true,
        winnerTeam: 'IN PROGRESS',
      ),
      MatchModel(
        matchId: 'match_14',
        tournamentId: tournamentId,
        matchNumber: 14,
        mapName: 'Miramar',
        groupInfo: 'Grand Finals - Match 14',
        startTime: now.add(const Duration(minutes: 30)),
        isLive: false,
      ),
      MatchModel(
        matchId: 'match_15',
        tournamentId: tournamentId,
        matchNumber: 15,
        mapName: 'Sanhok',
        groupInfo: 'Grand Finals - Match 15',
        startTime: now.add(const Duration(hours: 1, minutes: 15)),
        isLive: false,
      ),
      MatchModel(
        matchId: 'match_16',
        tournamentId: tournamentId,
        matchNumber: 16,
        mapName: 'Rondo',
        groupInfo: 'Grand Finals - Match 16',
        startTime: now.add(const Duration(hours: 2)),
        isLive: false,
      ),
      MatchModel(
        matchId: 'match_17',
        tournamentId: tournamentId,
        matchNumber: 17,
        mapName: 'Miramar',
        groupInfo: 'Grand Finals - Match 17',
        startTime: now.add(const Duration(hours: 2, minutes: 45)),
        isLive: false,
      ),
      MatchModel(
        matchId: 'match_18',
        tournamentId: tournamentId,
        matchNumber: 18,
        mapName: 'Erangel',
        groupInfo: 'Grand Finals - Championship Decider',
        startTime: now.add(const Duration(hours: 3, minutes: 30)),
        isLive: false,
      ),
    ];
  }

  static List<TeamModel> getTeams() {
    return [
      const TeamModel(
        teamId: 'team_xspark',
        teamName: 'Team XSpark',
        tag: 'Tx',
        logoUrl:
            'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Punkk', role: 'IGL', totalKills: 26, kdRatio: 1.86),
          PlayerModel(
              playerName: 'Spraygod',
              role: 'Assaulter',
              totalKills: 34,
              kdRatio: 2.43),
          PlayerModel(
              playerName: 'Sarang',
              role: 'Assaulter',
              totalKills: 24,
              kdRatio: 1.71),
          PlayerModel(
              playerName: 'Legit',
              role: 'Fragger',
              totalKills: 20,
              kdRatio: 1.43),
        ],
      ),
      const TeamModel(
        teamId: 'team_godl',
        teamName: 'GodLike Esports',
        tag: 'GodL',
        logoUrl:
            'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Jonathan',
              role: 'Star Fragger',
              totalKills: 36,
              kdRatio: 2.57),
          PlayerModel(
              playerName: 'Admino',
              role: 'Assaulter',
              totalKills: 27,
              kdRatio: 1.93),
          PlayerModel(
              playerName: 'Simp',
              role: 'IGL / Assaulter',
              totalKills: 22,
              kdRatio: 1.57),
          PlayerModel(
              playerName: 'ZGOD',
              role: 'Support',
              totalKills: 14,
              kdRatio: 1.00),
        ],
      ),
      const TeamModel(
        teamId: 'team_soul',
        teamName: 'iQOO SouL',
        tag: 'SouL',
        logoUrl:
            'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Manya', role: 'IGL', totalKills: 23, kdRatio: 1.64),
          PlayerModel(
              playerName: 'Spower',
              role: 'Assaulter',
              totalKills: 31,
              kdRatio: 2.21),
          PlayerModel(
              playerName: 'Nakul',
              role: 'Assaulter',
              totalKills: 20,
              kdRatio: 1.43),
          PlayerModel(
              playerName: 'Rony',
              role: 'Support',
              totalKills: 16,
              kdRatio: 1.14),
        ],
      ),
      const TeamModel(
        teamId: 'team_8bit',
        teamName: 'iQOO 8Bit',
        tag: '8Bit',
        logoUrl:
            'https://images.unsplash.com/photo-1563089145-599997674d42?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Saumraj',
              role: 'IGL',
              totalKills: 24,
              kdRatio: 1.71),
          PlayerModel(
              playerName: 'Juicy',
              role: 'Assaulter',
              totalKills: 26,
              kdRatio: 1.86),
          PlayerModel(
              playerName: 'Mac',
              role: 'Assaulter',
              totalKills: 21,
              kdRatio: 1.50),
          PlayerModel(
              playerName: 'Mighty',
              role: 'Support',
              totalKills: 12,
              kdRatio: 0.86),
        ],
      ),
      const TeamModel(
        teamId: 'team_og',
        teamName: 'Orangutan Esports',
        tag: 'OG',
        logoUrl:
            'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Aaru', role: 'IGL', totalKills: 20, kdRatio: 1.43),
          PlayerModel(
              playerName: 'AKop',
              role: 'Assaulter',
              totalKills: 29,
              kdRatio: 2.07),
          PlayerModel(
              playerName: 'WizzGOD',
              role: 'Assaulter',
              totalKills: 25,
              kdRatio: 1.79),
          PlayerModel(
              playerName: 'Attanki',
              role: 'Support',
              totalKills: 15,
              kdRatio: 1.07),
        ],
      ),
      const TeamModel(
        teamId: 'team_ge',
        teamName: 'Global Esports',
        tag: 'GE',
        logoUrl:
            'https://images.unsplash.com/photo-1579546929662-711aa81148cf?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Mavi', role: 'IGL', totalKills: 18, kdRatio: 1.29),
          PlayerModel(
              playerName: 'Ninjajod',
              role: 'Assaulter',
              totalKills: 30,
              kdRatio: 2.14),
          PlayerModel(
              playerName: 'Beast',
              role: 'Assaulter',
              totalKills: 21,
              kdRatio: 1.50),
          PlayerModel(
              playerName: 'Slug',
              role: 'Support',
              totalKills: 13,
              kdRatio: 0.93),
        ],
      ),
      const TeamModel(
        teamId: 'team_versatile',
        teamName: 'Team Versatile',
        tag: 'TV',
        logoUrl:
            'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Scout',
              role: 'IGL / Assaulter',
              totalKills: 22,
              kdRatio: 1.57),
          PlayerModel(
              playerName: 'NinjaBoi',
              role: 'Assaulter',
              totalKills: 25,
              kdRatio: 1.79),
          PlayerModel(
              playerName: 'Immortal',
              role: 'Assaulter',
              totalKills: 19,
              kdRatio: 1.36),
          PlayerModel(
              playerName: 'Godvexy',
              role: 'Support',
              totalKills: 11,
              kdRatio: 0.79),
        ],
      ),
      const TeamModel(
        teamId: 'team_tt',
        teamName: 'Team Tamilas',
        tag: 'TT',
        logoUrl:
            'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Maxy', role: 'IGL', totalKills: 21, kdRatio: 1.50),
          PlayerModel(
              playerName: 'MrIGL',
              role: 'Assaulter',
              totalKills: 23,
              kdRatio: 1.64),
          PlayerModel(
              playerName: 'Fox',
              role: 'Assaulter',
              totalKills: 18,
              kdRatio: 1.29),
          PlayerModel(
              playerName: 'Manty',
              role: 'Support',
              totalKills: 12,
              kdRatio: 0.86),
        ],
      ),
      const TeamModel(
        teamId: 'team_rkn',
        teamName: 'Reckoning Esports',
        tag: 'RKN',
        logoUrl:
            'https://images.unsplash.com/photo-1542751110-97427bbecf20?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Viper', role: 'IGL', totalKills: 17, kdRatio: 1.21),
          PlayerModel(
              playerName: 'Hunter',
              role: 'Assaulter',
              totalKills: 22,
              kdRatio: 1.57),
          PlayerModel(
              playerName: 'Blaze',
              role: 'Assaulter',
              totalKills: 18,
              kdRatio: 1.29),
          PlayerModel(
              playerName: 'Shadow7',
              role: 'Support',
              totalKills: 11,
              kdRatio: 0.79),
        ],
      ),
      const TeamModel(
        teamId: 'team_medal',
        teamName: 'Medal Esports',
        tag: 'MEDAL',
        logoUrl:
            'https://images.unsplash.com/photo-1534423861386-85a16f5d1345?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Paradox',
              role: 'IGL',
              totalKills: 19,
              kdRatio: 1.36),
          PlayerModel(
              playerName: 'TopG',
              role: 'Assaulter',
              totalKills: 23,
              kdRatio: 1.64),
          PlayerModel(
              playerName: 'Kyoya',
              role: 'Assaulter',
              totalKills: 17,
              kdRatio: 1.21),
          PlayerModel(
              playerName: 'Infinity',
              role: 'Support',
              totalKills: 10,
              kdRatio: 0.71),
        ],
      ),
      const TeamModel(
        teamId: 'team_ent',
        teamName: 'Entity Gaming',
        tag: 'ENT',
        logoUrl:
            'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Saumraj',
              role: 'IGL',
              totalKills: 18,
              kdRatio: 1.29),
          PlayerModel(
              playerName: 'GamlaBoy',
              role: 'Assaulter',
              totalKills: 22,
              kdRatio: 1.57),
          PlayerModel(
              playerName: 'Secret',
              role: 'Assaulter',
              totalKills: 19,
              kdRatio: 1.36),
          PlayerModel(
              playerName: 'Pukar',
              role: 'Support',
              totalKills: 11,
              kdRatio: 0.79),
        ],
      ),
      const TeamModel(
        teamId: 'team_carnival',
        teamName: 'Carnival Gaming',
        tag: 'CG',
        logoUrl:
            'https://images.unsplash.com/photo-1563089145-599997674d42?w=100&auto=format&fit=crop&q=60',
        roster: [
          PlayerModel(
              playerName: 'Omega', role: 'IGL', totalKills: 16, kdRatio: 1.14),
          PlayerModel(
              playerName: 'Goblin',
              role: 'Assaulter',
              totalKills: 22,
              kdRatio: 1.57),
          PlayerModel(
              playerName: 'Akshat',
              role: 'Assaulter',
              totalKills: 17,
              kdRatio: 1.21),
          PlayerModel(
              playerName: 'Hector',
              role: 'Support',
              totalKills: 11,
              kdRatio: 0.79),
        ],
      ),
    ];
  }
}
