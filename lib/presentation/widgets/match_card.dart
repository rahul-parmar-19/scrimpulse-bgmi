import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/match_model.dart';
import 'map_badge.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;
  final VoidCallback? onWatchLiveTap;
  final VoidCallback? onRemindTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onWatchLiveTap,
    this.onRemindTap,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('dd MMM');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: match.isLive
              ? AppColors.neonRed.withOpacity(0.6)
              : AppColors.surfaceBorder,
          width: match.isLive ? 1.4 : 1.0,
        ),
      ),
      child: Column(
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: match.isLive
                  ? AppColors.neonRed.withOpacity(0.12)
                  : AppColors.surfaceElevated,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'MATCH ${match.matchNumber}',
                      style: GoogleFonts.rajdhani(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: match.isLive ? AppColors.neonRed : AppColors.neonYellow,
                      ),
                    ),
                    const SizedBox(width: 8),
                    MapBadge(mapName: match.mapName),
                  ],
                ),
                if (match.isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.neonRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.fiber_manual_record, size: 8, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          'LIVE NOW',
                          style: GoogleFonts.rajdhani(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    '${dateFormat.format(match.startTime)} • ${timeFormat.format(match.startTime)}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.groupInfo,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (match.winnerTeam.isNotEmpty)
                        Row(
                          children: [
                            const Icon(Icons.emoji_events, size: 14, color: AppColors.goldWWCD),
                            const SizedBox(width: 4),
                            Text(
                              'WWCD: ${match.winnerTeam}',
                              style: GoogleFonts.rajdhani(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldWWCD,
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          '16 Teams • 64 Players • Erangel Classic Format',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                    ],
                  ),
                ),

                // Action Button
                if (match.isLive)
                  ElevatedButton.icon(
                    onPressed: onWatchLiveTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 16),
                    label: Text(
                      'STREAM',
                      style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed: onRemindTap,
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.neonCyan,
                      size: 20,
                    ),
                    tooltip: 'Set Match Countdown Alert',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

