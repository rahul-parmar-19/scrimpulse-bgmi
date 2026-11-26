import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/notification_service.dart';
import '../../data/repositories/mock_data_generator.dart';
import '../../logic/blocs/matches/matches_bloc.dart';
import '../../logic/blocs/matches/matches_event.dart';
import '../../logic/blocs/matches/matches_state.dart';
import '../../logic/blocs/stream_overlay/stream_cubit.dart';
import '../widgets/map_badge.dart';
import '../widgets/match_card.dart';

class MatchesScheduleScreen extends StatelessWidget {
  final String tournamentId;

  const MatchesScheduleScreen({
    super.key,
    this.tournamentId = MockDataGenerator.tournamentId,
  });

  static const List<String> availableFilters = [
    'ALL',
    'Erangel',
    'Miramar',
    'Sanhok',
    'Rondo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MatchesBloc, MatchesState>(
        builder: (context, state) {
          if (state.status == MatchesStatus.loading && state.allMatches.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.neonYellow),
            );
          }

          final matches = state.filteredMatches;

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // Map Filter Bar
              SliverToBoxAdapter(
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: availableFilters.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = availableFilters[index];
                      final isSelected = state.selectedMap.toUpperCase() == filter.toUpperCase();

                      if (filter == 'ALL') {
                        return ChoiceChip(
                          label: Text(
                            'ALL MAPS',
                            style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              color: isSelected ? Colors.black : AppColors.textSecondary,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: AppColors.neonYellow,
                          backgroundColor: AppColors.surfaceElevated,
                          onSelected: (_) {
                            context.read<MatchesBloc>().add(const FilterByMapEvent('ALL'));
                          },
                        );
                      }

                      return MapBadge(
                        mapName: filter,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<MatchesBloc>().add(FilterByMapEvent(filter));
                        },
                      );
                    },
                  ),
                ),
              ),

              // Match Count Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MATCH SCHEDULE',
                        style: GoogleFonts.rajdhani(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        '${matches.length} Matches Found',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.neonCyan,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Matches List
              if (matches.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No matches found for ${state.selectedMap}',
                      style: GoogleFonts.inter(color: AppColors.textMuted),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final match = matches[index];
                      return MatchCard(
                        match: match,
                        onWatchLiveTap: () {
                          context.read<StreamCubit>().openStream(
                            url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                          );
                        },
                        onRemindTap: () {
                          NotificationService().showInstantAlert(
                            title: 'Match ${match.matchNumber} Countdown',
                            body: 'Match starting soon on ${match.mapName}! SouL, GodLike, and XSpark entering lobby.',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.surfaceElevated,
                              content: Text(
                                'Alert registered for Match ${match.matchNumber} (${match.mapName})',
                                style: GoogleFonts.inter(color: AppColors.neonCyan),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    },
                    childCount: matches.length,
                  ),
                ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          );
        },
      ),
    );
  }
}

