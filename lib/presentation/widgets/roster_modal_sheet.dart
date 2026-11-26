import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/team_model.dart';

class RosterModalSheet extends StatelessWidget {
  final TeamModel team;

  const RosterModalSheet({super.key, required this.team});

  static void show(BuildContext context, TeamModel team) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: AppColors.surfaceBorder, width: 1),
      ),
      builder: (context) => RosterModalSheet(team: team),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toUpperCase()) {
      case 'IGL':
        return AppColors.neonYellow;
      case 'ASSAULTER':
        return AppColors.neonRed;
      case 'SUPPORT':
        return AppColors.neonCyan;
      case 'SNIPER':
        return AppColors.neonOrange;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Team Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.neonYellow.withOpacity(0.4)),
                ),
                child: Center(
                  child: Text(
                    team.tag.isNotEmpty
                        ? team.tag
                        : (team.teamName.length >= 2
                            ? team.teamName.substring(0, 2)
                            : (team.teamName.isNotEmpty ? team.teamName : 'TM')),
                    style: GoogleFonts.rajdhani(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.neonYellow,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.teamName,
                      style: GoogleFonts.rajdhani(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Official 4-Player Active Roster',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.textMuted),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(color: AppColors.surfaceBorder, height: 1),
          const SizedBox(height: 14),

          // Roster List
          ...team.roster.map((player) {
            final roleColor = _getRoleColor(player.role);
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: roleColor.withOpacity(0.15),
                    child: Text(
                      player.playerName.isNotEmpty ? player.playerName[0] : 'P',
                      style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.bold,
                        color: roleColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.playerName,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: roleColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            player.role.toUpperCase(),
                            style: GoogleFonts.rajdhani(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              color: roleColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Player Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${player.totalKills} Kills',
                        style: GoogleFonts.rajdhani(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.neonCyan,
                        ),
                      ),
                      Text(
                        '${player.kdRatio.toStringAsFixed(2)} K/D',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

