import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/team_model.dart';
import '../../data/repositories/mock_data_generator.dart';
import '../../logic/blocs/leaderboard/leaderboard_bloc.dart';
import '../../logic/blocs/leaderboard/leaderboard_event.dart';
import '../../logic/blocs/leaderboard/leaderboard_state.dart';
import '../../logic/blocs/stream_overlay/stream_cubit.dart';
import '../widgets/roster_modal_sheet.dart';
import '../widgets/standing_row_card.dart';

class LeaderboardScreen extends StatelessWidget {
  final String tournamentId;

  const LeaderboardScreen({
    super.key,
    this.tournamentId = MockDataGenerator.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<LeaderboardBloc, LeaderboardState>(
        builder: (context, state) {
          if (state.status == LeaderboardStatus.loading &&
              state.standings.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.neonYellow),
            );
          }

          final tournament =
              state.tournament ?? MockDataGenerator.getTournament();
          final standings = state.standings;

          return RefreshIndicator(
            color: AppColors.neonYellow,
            backgroundColor: AppColors.surface,
            onRefresh: () async {
              context
                  .read<LeaderboardBloc>()
                  .add(RefreshLeaderboardEvent(tournamentId));
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                // Tournament Header Banner
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      border: Border(
                        bottom: BorderSide(color: AppColors.surfaceBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                gradient: AppColors.liveBadgeGradient,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.stream,
                                      size: 12, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    tournament.status.toUpperCase(),
                                    style: GoogleFonts.rajdhani(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'PRIZE POOL: ${tournament.totalPrize}',
                              style: GoogleFonts.rajdhani(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.neonYellow,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tournament.name,
                          style: GoogleFonts.rajdhani(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Action Buttons: Stream Watch & Scoring System Guide
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _showStreamPrompt(
                                    context, tournament.liveStreamUrl),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.neonYellow,
                                  foregroundColor: Colors.black,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: const Icon(Icons.play_circle_fill,
                                    size: 18),
                                label: Text(
                                  'WATCH LIVE STREAM',
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _showScoringSystemDialog(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.neonCyan,
                                side:
                                    const BorderSide(color: AppColors.neonCyan),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.info_outline, size: 16),
                              label: Text(
                                '10-PT SYSTEM',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Table Header Column Labels
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TableHeaderDelegate(),
                ),

                // Standings List
                if (standings.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.leaderboard_outlined,
                              size: 48, color: AppColors.textMuted),
                          const SizedBox(height: 12),
                          Text(
                            'No points recorded yet',
                            style: GoogleFonts.inter(
                                color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final standing = standings[index];
                        return StandingRowCard(
                          standing: standing,
                          onTap: () {
                            // Find matching mock or real team
                            final teams = MockDataGenerator.getTeams();
                            final team = teams.firstWhere(
                              (t) =>
                                  t.teamName.toLowerCase().contains(
                                      standing.teamName.toLowerCase()) ||
                                  standing.teamName
                                      .toLowerCase()
                                      .contains(t.tag.toLowerCase()),
                              orElse: () => TeamModel(
                                teamId: standing.teamId,
                                teamName: standing.teamName,
                                tag: '',
                                logoUrl: standing.teamLogoUrl,
                                roster: const [],
                              ),
                            );
                            RosterModalSheet.show(context, team);
                          },
                        );
                      },
                      childCount: standings.length,
                    ),
                  ),

                // Bottom Padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showScoringSystemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.surfaceBorder),
        ),
        title: Text(
          'Official BGMI 10-Point Scoring System',
          style: GoogleFonts.rajdhani(
            color: AppColors.neonYellow,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ruleRow('1st (WWCD)', '10 Points', AppColors.goldWWCD),
            _ruleRow('2nd Place', '6 Points', AppColors.silverRank),
            _ruleRow('3rd Place', '5 Points', AppColors.bronzeRank),
            _ruleRow('4th Place', '4 Points', AppColors.textPrimary),
            _ruleRow('5th Place', '3 Points', AppColors.textPrimary),
            _ruleRow('6th Place', '2 Points', AppColors.textPrimary),
            _ruleRow('7th - 8th', '1 Point', AppColors.textSecondary),
            _ruleRow('9th - 16th', '0 Points', AppColors.textMuted),
            const Divider(color: AppColors.surfaceBorder, height: 18),
            _ruleRow('Every Kill', '+1 Point each', AppColors.neonCyan),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'GOT IT',
              style: GoogleFonts.rajdhani(
                color: AppColors.neonYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStreamPrompt(BuildContext context, String currentUrl) {
    final textController = TextEditingController(
      text: currentUrl.isNotEmpty
          ? currentUrl
          : 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.surfaceBorder),
        ),
        title: Row(
          children: [
            const Icon(Icons.live_tv, color: AppColors.neonRed),
            const SizedBox(width: 8),
            Text(
              'BGMI LIVE STREAM',
              style: GoogleFonts.rajdhani(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paste any YouTube Live stream URL or video ID to stream inside the app:',
              style: GoogleFonts.inter(
                  fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: textController,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceElevated,
                hintText: 'https://www.youtube.com/watch?v=...',
                hintStyle:
                    GoogleFonts.inter(color: AppColors.textMuted, fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.surfaceBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.neonYellow),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'CANCEL',
              style: GoogleFonts.rajdhani(
                  color: AppColors.textMuted, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonYellow,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              final url = textController.text.trim();
              Navigator.pop(ctx);
              if (url.isNotEmpty) {
                context.read<StreamCubit>().openStream(url: url);
              }
            },
            child: Text(
              'PLAY LIVE',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ruleRow(String rank, String pts, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rank,
              style: GoogleFonts.inter(
                  fontSize: 13, color: AppColors.textSecondary)),
          Text(
            pts,
            style: GoogleFonts.rajdhani(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      color: AppColors.background,
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '#',
              style: GoogleFonts.rajdhani(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
            ),
          ),
          const SizedBox(width: 44),
          Expanded(
            child: Text(
              'TEAM',
              style: GoogleFonts.rajdhani(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: AppColors.textMuted,
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Center(
              child: Text(
                'PLACE',
                style: GoogleFonts.rajdhani(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Center(
              child: Text(
                'KILLS',
                style: GoogleFonts.rajdhani(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neonCyan,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: Center(
              child: Text(
                'PTS',
                style: GoogleFonts.rajdhani(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.neonYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 38.0;

  @override
  double get minExtent => 38.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
