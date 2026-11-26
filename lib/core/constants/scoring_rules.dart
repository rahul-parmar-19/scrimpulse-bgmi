/// Official BGMI / Krafton 10-Point System Rules
class ScoringRules {
  /// Position to Placement Points Mapping (Official 10-point format)
  static const Map<int, int> placementPointsTable = {
    1: 10,  // WWCD (Winner Winner Chicken Dinner)
    2: 6,
    3: 5,
    4: 4,
    5: 3,
    6: 2,
    7: 1,
    8: 1,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
    14: 0,
    15: 0,
    16: 0,
  };

  static const int pointsPerKill = 1;

  /// Get placement points for a given finish position
  static int getPlacementPoints(int position) {
    if (position <= 0) return 0;
    return placementPointsTable[position] ?? 0;
  }
}

