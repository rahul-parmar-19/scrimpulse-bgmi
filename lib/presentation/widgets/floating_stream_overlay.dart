import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../logic/blocs/stream_overlay/stream_cubit.dart';
import '../../logic/blocs/stream_overlay/stream_state.dart';

class FloatingStreamOverlay extends StatefulWidget {
  const FloatingStreamOverlay({super.key});

  @override
  State<FloatingStreamOverlay> createState() => _FloatingStreamOverlayState();
}

class _FloatingStreamOverlayState extends State<FloatingStreamOverlay> {
  YoutubePlayerController? _controller;
  String? _currentVideoId;
  Offset _floatingPosition = const Offset(16, 80);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final streamState = context.watch<StreamCubit>().state;

    if (streamState.mode != StreamOverlayMode.hidden &&
        streamState.videoId.isNotEmpty &&
        streamState.videoId != _currentVideoId) {
      _initController(streamState.videoId);
    }
  }

  void _initController(String videoId) {
    _currentVideoId = videoId;
    _controller?.dispose();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: true,
        enableCaption: false,
        hideControls: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamState = context.watch<StreamCubit>().state;

    if (streamState.mode == StreamOverlayMode.hidden || _controller == null) {
      return const SizedBox.shrink();
    }

    if (streamState.mode == StreamOverlayMode.expanded) {
      // Top Pinned Video Banner
      return Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColors.neonYellow,
                topActions: [
                  IconButton(
                    icon: const Icon(Icons.picture_in_picture_alt, color: Colors.white),
                    tooltip: 'Minimize to Floating Card',
                    onPressed: () {
                      context.read<StreamCubit>().setMode(StreamOverlayMode.floating);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      context.read<StreamCubit>().closeStream();
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: AppColors.surfaceElevated,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.neonRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'OFFICIAL STREAM',
                      style: GoogleFonts.rajdhani(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'BGIS Official Cast • Krafton India Esports',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 24),
                    ),
                    onPressed: () {
                      context.read<StreamCubit>().setMode(StreamOverlayMode.floating);
                    },
                    icon: const Icon(Icons.arrow_downward, size: 14, color: AppColors.neonYellow),
                    label: Text(
                      'DOCK',
                      style: GoogleFonts.rajdhani(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonYellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Mini Draggable Floating PIP Overlay Widget
    final screenSize = MediaQuery.of(context).size;
    const cardWidth = 220.0;
    const cardHeight = 150.0;

    return Positioned(
      left: _floatingPosition.dx.clamp(10.0, screenSize.width - cardWidth - 10.0),
      top: _floatingPosition.dy.clamp(60.0, screenSize.height - cardHeight - 80.0),
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingPosition += details.delta;
          });
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neonYellow, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Positioned.fill(
                  child: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: false,
                  ),
                ),
                // Overlay controls bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: Colors.black.withOpacity(0.65),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.drag_indicator, size: 14, color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Text(
                              'LIVE',
                              style: GoogleFonts.rajdhani(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neonRed,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<StreamCubit>().setMode(StreamOverlayMode.expanded);
                              },
                              child: const Icon(Icons.fullscreen, size: 18, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                context.read<StreamCubit>().closeStream();
                              },
                              child: const Icon(Icons.close, size: 18, color: AppColors.neonRed),
                            ),
                          ],
                        ),
                      ],
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

