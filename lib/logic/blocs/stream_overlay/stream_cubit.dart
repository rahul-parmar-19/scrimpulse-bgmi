import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  StreamCubit() : super(const StreamState());

  void openStream({required String url, StreamOverlayMode mode = StreamOverlayMode.expanded}) {
    final videoId = YoutubePlayer.convertUrlToId(url) ?? 'dQw4w9WgXcQ';
    String? resolvedId;
    final trimmed = url.trim();

    if (trimmed.length == 11 && !trimmed.contains('/') && !trimmed.contains('?')) {
      resolvedId = trimmed;
    } else {
      resolvedId = YoutubePlayer.convertUrlToId(trimmed);
    }

    // Default to Krafton BGMI live stream / championship highlight when URL is generic
    final videoId = resolvedId ?? '7gX9y_1zKj4';

    emit(state.copyWith(
      mode: mode,
      videoUrl: url,
      videoId: videoId,
      isPlaying: true,
    ));
  }

  void toggleMinimize() {
    if (state.mode == StreamOverlayMode.expanded) {
      emit(state.copyWith(mode: StreamOverlayMode.floating));
    } else if (state.mode == StreamOverlayMode.floating) {
      emit(state.copyWith(mode: StreamOverlayMode.expanded));
    }
  }

  void setMode(StreamOverlayMode mode) {
    emit(state.copyWith(mode: mode));
  }

  void closeStream() {
    emit(state.copyWith(
      mode: StreamOverlayMode.hidden,
      isPlaying: false,
    ));
  }
}

