import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player_app/music_player_page/MusicPlayerPage.dart';
import 'package:music_player_app/music_player_page/enum/music_player_event.dart';
import 'package:music_player_app/music_player_page/services/music_player_service.dart';

part 'music_player_state.dart';

/// [MusicPlayerCubit] is acts as bloc ( bloc pattern) between [ MusicPlayerService] and [MusicPlayerPage]
class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  MusicPlayerService _service;

  MusicPlayerCubit()
      : super(MusicPlayerState(MusicPlayerEvent.EVENT_INIT,
            DateTime.now().millisecondsSinceEpoch)) {
    _service = MusicPlayerService();
    _service.onPlayerStop=_onPayerStop;
  }

  /// emits the new state with [MusicPlayerEvent] into [MusicPlayerCubit]
  void _emitEvent(MusicPlayerEvent event) {
    var newEvent = this.state.copyWith(event: event);
    emit(newEvent);
  }

  /// plays or pauses the music player and emits respective [MusicPlayerEvent] to [MusicPlayerCubit]
  void playOrPause() async {
    var event = _service.isPlaying()
        ? MusicPlayerEvent.EVENT_PAUSE
        : MusicPlayerEvent.EVENT_PLAYING;

    _emitEvent(event);
    _service.playOrPause();

  }
  /// seek music player to  [duration]
  void seek(Duration duration){
    _service.seek(duration);
  }
  /// [registerMaxDurationEvent] registers [fun] with Song(media) max duration in milli seconds [int]
  void registerMaxDurationEvent(Function(int maxDuration) fun ){
    _service.onSongMaxDuration=fun;
  }

  /// [registerCurrentDurationEvent] registers [fun] with Song(media) current duration in milli seconds [int]
  void registerCurrentDurationEvent(Function(int currentDuration) fun ){
    _service.onSongCurrentDuration=fun;
  }


  void _onPayerStop(){
    // calls when music player End
    _emitEvent(MusicPlayerEvent.EVENT_STOP);
  }

  /// releases resources
  @override
  Future<Function> close() {
    super.close();
    _service.close();
    return Future.value();
  }
}
