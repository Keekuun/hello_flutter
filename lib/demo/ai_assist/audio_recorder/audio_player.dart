import 'dart:async';

import 'package:flutter_sound/public/flutter_sound_player.dart';

class AudioPlayerManager {
  AudioPlayer player = AudioPlayer();

  static AudioPlayerManager? _instance;

  static AudioPlayerManager get() {
    _instance ??= AudioPlayerManager._internal();
    return _instance!;
  }

  AudioPlayerManager._internal();
}

class AudioPlayer {
  FlutterSoundPlayer? playerModule;
  String? playingUrl;
  StreamSubscription? _subscription;
  Function()? _onDone;

  Future<StreamSubscription?> playOrStop(String path,
      {Function(PlaybackDisposition)? onProgress, Function()? onDone}) async {
    bool toPlay = true;
    if (playerModule?.isPlaying == true) {
      toPlay = playingUrl != path;
      stop();
    }
    if (toPlay) {
      return play(path, onProgress: onProgress, onDone: onDone);
    }
    return null;
  }

  Future<StreamSubscription?> play(String path,
      {Function(PlaybackDisposition)? onProgress, Function()? onDone}) async {
    _onDone?.call();
    await reset();
    playerModule ??= FlutterSoundPlayer();
    await playerModule?.openPlayer();
    playingUrl = path;
    _subscription = subscribe(path, onProgress: onProgress, onDone: onDone);
    await playerModule!.startPlayer(fromURI: path, whenFinished: whenFinished);
    return _subscription;
  }

  void whenFinished() async {
    await reset();
    _onDone?.call();
  }

  StreamSubscription? subscribe(String path,
      {Function(PlaybackDisposition)? onProgress, Function()? onDone}) {
    if (path == playingUrl) {
      _subscription?.cancel();
      _onDone = onDone;
      _subscription = playerModule?.onProgress?.listen(onProgress);
      playerModule?.setSubscriptionDuration(const Duration(seconds: 1));
      return _subscription;
    } else {
      return null;
    }
  }

  void unsubscribe({StreamSubscription? subscription, Function()? onDone}) {
    if (subscription == _subscription) {
      _subscription = null;
    }
    if (onDone == _onDone) {
      _onDone = null;
    }
  }

  Future stop() async {
    _onDone?.call();
    return reset();
  }

  Future reset() async {
    playingUrl = null;
    print("reset audio: $playerModule");
    await _subscription?.cancel();
    await playerModule?.closePlayer();
    playerModule = null;
  }
}
