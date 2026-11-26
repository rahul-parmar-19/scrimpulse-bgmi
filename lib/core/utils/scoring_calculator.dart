import '../constants/scoring_rules.dart';
import '../../data/models/standing_model.dart';

/// Dynamic 10-Point Scoring System Calculator for BGMI Tournaments
class ScoringCalculator {
  /// Calculate single match points for a team
  static int calculateMatchScore({
    required int position,
    required int kills,
  }) {
    final placementPts = ScoringRules.getPlacementPoints(position);
    final killPts = kills * ScoringRules.pointsPerKill;
    return placementPts + killPts;
  }

  /// Sort and rank a list of standings according to official BGMI tie-breaking criteria:
  /// 1. Total Points (Placement + Kills)
  /// 2. Total WWCDs (Chicken Dinners)
  /// 3. Total Placement Points
  /// 4. Total Kill Points
  static List<StandingModel> sortAndComputeRanks(List<StandingModel> standings) {
    final sortedList = List<StandingModel>.from(standings);

    sortedList.sort((a, b) {
      // 1. Total Points DESC
      if (b.totalPoints != a.totalPoints) {
        return b.totalPoints.compareTo(a.totalPoints);
      }
      // 2. WWCD count DESC
      if (b.wwcdCount != a.wwcdCount) {
        return b.wwcdCount.compareTo(a.wwcdCount);
      }
      // 3. Placement Points DESC
      if (b.placementPoints != a.placementPoints) {
        return b.placementPoints.compareTo(a.placementPoints);
      }
      // 4. Kill Points DESC
      return b.killPoints.compareTo(a.killPoints);
    });

    // Assign consecutive 1-indexed ranks
    return List.generate(sortedList.length, (index) {
      return sortedList[index].copyWith(rank: index + 1);
    });
  }
}

