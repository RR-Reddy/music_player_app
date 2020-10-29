import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

/// [MusicPlayerService] manges complete music player functionality
class MusicPlayerService {
  static const _SONG_NAME = "song_1.mp3";

  AudioCache _audioCache;
  AudioPlayer _audioPlayer;

  StreamSubscription _subscriptionPlayerState;
  StreamSubscription _subscriptionSongCurrentDuration;

  Function(int) _onSongMaxDuration;
  Function(int) _onSongCurrentDuration;
  Function() _onPlayerStop;

  /// [onSongMaxDuration] trigger [fun] with Song(media) max duration in milli seconds [int]
  set onSongMaxDuration(Function(int) fun) {
    _onSongMaxDuration = fun;
  }

  /// [onSongCurrentDuration] trigger [fun] with Song(media) current duration in milli seconds [int]
  set onSongCurrentDuration(Function(int) fun) {
    _onSongCurrentDuration = fun;
  }

  /// [onPlayerStop] trigger [fun] when player state becomes STOP
  set onPlayerStop(Function fun) {
    _onPlayerStop = fun;
  }

  MusicPlayerService() {
    _init();
  }

  /// initialization of music player
  void _init() async {
    _audioCache = AudioCache(prefix: 'assets/mp3_files/');
    await _audioCache.load(_SONG_NAME);
  }

  /// returns [bool] based on Music player Playing state
  bool isPlaying() {
    if (_audioPlayer == null) {
      return false;
    } else {
      return _audioPlayer.state == AudioPlayerState.PLAYING;
    }
  }

  /// returns [bool] based on Music player Pause state
  bool isPaused() {
    if (_audioPlayer == null) {
      return false;
    } else {
      return _audioPlayer.state == AudioPlayerState.PAUSED;
    }
  }

  /// seek music player to  [duration]
  void seek(Duration duration) {
    _audioPlayer?.seek(duration);
  }

  /// plays music player if it not playing
  /// OR
  /// pauses music player if it is playing
  void playOrPause() async {
    if (isPaused()) {
      _audioPlayer.resume();
    } else if (isPlaying()) {
      _audioPlayer.pause();
    } else {
      _audioPlayer = await _audioCache.play(_SONG_NAME);
      _registerEvents();
    }
  }

  /// registers required events or states of music player
  void _registerEvents() async {
    _subscriptionPlayerState =
        _audioPlayer.onPlayerStateChanged.listen((audioPlayerState) async {
      if (AudioPlayerState.COMPLETED == audioPlayerState &&
          _onPlayerStop != null) {
        _onPlayerStop();
      }
    });

    _subscriptionSongCurrentDuration =
        _audioPlayer.onDurationChanged.listen((maxDuration) async {
      if (_onSongMaxDuration != null) {
        _onSongMaxDuration(maxDuration.inMilliseconds);
      }

      if (_onSongCurrentDuration != null) {
        var currentDuration = await _audioPlayer.getCurrentPosition();
        _onSongCurrentDuration(currentDuration);
      }
    });
  }

  /// releases resources and cancels subscriptions if any
  void close() async {
    await _audioPlayer?.stop();
    _subscriptionPlayerState?.cancel();
    _subscriptionSongCurrentDuration?.cancel();
    _audioCache?.clearCache();
  }
}
