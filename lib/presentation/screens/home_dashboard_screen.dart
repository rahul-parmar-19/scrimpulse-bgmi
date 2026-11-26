import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/notification_service.dart';
import '../../data/repositories/esports_repository.dart';
import '../../data/repositories/mock_data_generator.dart';
import '../../logic/blocs/leaderboard/leaderboard_bloc.dart';
import '../../logic/blocs/leaderboard/leaderboard_event.dart';
import '../../logic/blocs/matches/matches_bloc.dart';
import '../../logic/blocs/matches/matches_event.dart';
import '../../logic/blocs/stream_overlay/stream_cubit.dart';
import '../../logic/blocs/stream_overlay/stream_state.dart';
import '../widgets/floating_stream_overlay.dart';
import 'leaderboard_screen.dart';
import 'matches_schedule_screen.dart';
import 'team_roster_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    LeaderboardScreen(),
    MatchesScheduleScreen(),
    TeamRosterScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Dispatch initial stream events
    context.read<LeaderboardBloc>().add(
          const StartLeaderboardStreamEvent(MockDataGenerator.tournamentId),
        );
    context.read<MatchesBloc>().add(
          const StartMatchesStreamEvent(MockDataGenerator.tournamentId),
        );
  }

  @override
  Widget build(BuildContext context) {
    final streamMode = context.watch<StreamCubit>().state.mode;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.neonYellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SP',
                style: GoogleFonts.rajdhani(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'SCRIM',
                    style: GoogleFonts.rajdhani(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'PULSE',
                    style: GoogleFonts.rajdhani(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: AppColors.neonYellow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Push notification simulator button
          IconButton(
            icon: const Icon(Icons.notifications_active,
                color: AppColors.neonCyan),
            tooltip: 'Simulate WWCD Notification Alert',
            onPressed: () {
              NotificationService().showInstantAlert(
                title: 'WINNER WINNER CHICKEN DINNER! 🍗',
                body:
                    'Team SouL secured WWCD in Match 13 with 14 Kills! Total 24 Points added.',
                isWWCD: true,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.surfaceElevated,
                  content: Text(
                    'Simulated WWCD Push Alert Dispatched!',
                    style: GoogleFonts.inter(color: AppColors.goldWWCD),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          // Live Stream Toggle button
          IconButton(
            icon: const Icon(Icons.live_tv, color: AppColors.neonRed),
            tooltip: 'Watch BGMI Live Stream',
            onPressed: () => _showStreamUrlDialog(context),
          ),
          // Firebase Cloud Sync & Admin Seeder
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColors.surfaceBorder),
            ),
            onSelected: (value) async {
              if (value == 'seed') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.surfaceElevated,
                    content: Text(
                      'Uploading 12 Teams, Matches & Points to Firebase Firestore...',
                      style: GoogleFonts.inter(color: AppColors.neonCyan),
                    ),
                  ),
                );
                try {
                  await context.read<EsportsRepository>().seedInitialTournamentData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green.shade800,
                      content: Text(
                        'Uploaded to Firebase Firestore Successfully!',
                        style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.neonRed,
                      content: Text('Firebase upload note: $e'),
                    ),
                  );
                }
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'seed',
                child: Row(
                  children: [
                    const Icon(Icons.cloud_upload_outlined, color: AppColors.neonYellow, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Sync / Upload to Firebase',
                      style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Body with Optional Expanded Player at top
          Column(
            children: [
              if (streamMode == StreamOverlayMode.expanded)
                const FloatingStreamOverlay(),
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _screens,
                ),
              ),
            ],
          ),

          // Floating Draggable PiP Video Widget
          if (streamMode == StreamOverlayMode.floating)
            const FloatingStreamOverlay(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            activeIcon: Icon(Icons.leaderboard),
            label: 'Standings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            activeIcon: Icon(Icons.groups),
            label: 'Rosters',
          ),
        ],
      ),
    );
  }

  void _showStreamUrlDialog(BuildContext context) {
    final textController = TextEditingController(
      text: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
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
              'Paste any official YouTube Live match stream URL or Video ID:',
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
                color: AppColors.textMuted,
                fontWeight: FontWeight.bold,
              ),
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
}
