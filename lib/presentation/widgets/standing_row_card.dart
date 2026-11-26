import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/standing_model.dart';

class StandingRowCard extends StatelessWidget {
  final StandingModel standing;
  final VoidCallback? onTap;

  const StandingRowCard({
    super.key,
    required this.standing,
    this.onTap,
  });

  Color _getRankColor() {
    switch (standing.rank) {
      case 1:
        return AppColors.goldWWCD;
      case 2:
        return AppColors.silverRank;
      case 3:
        return AppColors.bronzeRank;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTopThree = standing.rank <= 3;
    final rankColor = _getRankColor();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isTopThree
                  ? rankColor.withOpacity(0.06)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isTopThree
                    ? rankColor.withOpacity(0.35)
                    : AppColors.surfaceBorder.withOpacity(0.6),
                width: isTopThree ? 1.2 : 0.8,
              ),
            ),
            child: Row(
              children: [
                // Rank Number / Medal
                SizedBox(
                  width: 32,
                  child: Center(
                    child: Text(
                      '#${standing.rank}',
                      style: GoogleFonts.rajdhani(
                        fontSize: isTopThree ? 17 : 14,
                        fontWeight: FontWeight.w800,
                        color: rankColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Team Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 34,
                    height: 34,
                    color: AppColors.surfaceElevated,
                    child: CachedNetworkImage(
                      imageUrl: standing.teamLogoUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surfaceElevated,
                        child: const Icon(Icons.shield, size: 16, color: AppColors.textMuted),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surfaceElevated,
                        child: Center(
                          child: Text(
                            standing.teamName.isNotEmpty ? standing.teamName[0] : 'T',
                            style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.bold,
                              color: AppColors.neonYellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Team Name & Matches
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        standing.teamName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isTopThree ? AppColors.textPrimary : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '${standing.matchesPlayed} Matches',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppColors.textMuted,
                            ),
                          ),
                          if (standing.wwcdCount > 0) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.goldWWCD.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.emoji_events, size: 10, color: AppColors.goldWWCD),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${standing.wwcdCount} WWCD',
                                    style: GoogleFonts.rajdhani(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldWWCD,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Placement Points
                SizedBox(
                  width: 36,
                  child: Center(
                    child: Text(
                      '${standing.placementPoints}',
                      style: GoogleFonts.rajdhani(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                // Kill Points
                SizedBox(
                  width: 36,
                  child: Center(
                    child: Text(
                      '${standing.killPoints}',
                      style: GoogleFonts.rajdhani(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neonCyan,
                      ),
                    ),
                  ),
                ),

                // Total Points (Highlighted)
                Container(
                  width: 48,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isTopThree
                        ? rankColor.withOpacity(0.18)
                        : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isTopThree ? rankColor.withOpacity(0.5) : AppColors.surfaceBorder,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${standing.totalPoints}',
                      style: GoogleFonts.rajdhani(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isTopThree ? rankColor : AppColors.neonYellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

