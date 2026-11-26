import 'package:equatable/equatable.dart';

enum StreamOverlayMode {
  hidden,
  floating, // Mini floating PIP card
  expanded, // Top banner player
}

class StreamState extends Equatable {
  final StreamOverlayMode mode;
  final String videoUrl;
  final String videoId;
  final bool isPlaying;

  const StreamState({
    this.mode = StreamOverlayMode.hidden,
    this.videoUrl = '',
    this.videoId = '',
    this.isPlaying = false,
  });

  StreamState copyWith({
    StreamOverlayMode? mode,
    String? videoUrl,
    String? videoId,
    bool? isPlaying,
  }) {
    return StreamState(
      mode: mode ?? this.mode,
      videoUrl: videoUrl ?? this.videoUrl,
      videoId: videoId ?? this.videoId,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [mode, videoUrl, videoId, isPlaying];
}

