part of 'music_player_cubit.dart';

/// [MusicPlayerState] represents UI state
@immutable
class MusicPlayerState {
  final MusicPlayerEvent event;
  /// [eventTs] current time stamp in milli seconds
  final int eventTs;

  MusicPlayerState(this.event, this.eventTs);

  MusicPlayerState copyWith({MusicPlayerEvent event}) {
    return MusicPlayerState(
        event ?? this.event, DateTime.now().millisecondsSinceEpoch);
  }
}
