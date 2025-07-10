import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  AudioHelper._();

  static AudioHelper get _instance => AudioHelper._();

  factory AudioHelper() {
    return _instance;
  }

  AudioPlayer? audioPlayer;

  /// This will be used to initialise the audio player.
  Future<void> init(
    String path, {
    bool shouldLoop = false,
  }) async {
    audioPlayer = AudioPlayer();
    await audioPlayer!.setSourceAsset(path);
    if (shouldLoop) {
      audioPlayer!.setReleaseMode(ReleaseMode.loop);
    }
  }

  /// This will be used to play/resume music/sfx.
  Future<void> play() async {
    if (audioPlayer?.state != PlayerState.playing) {
      await audioPlayer?.resume();
    }
  }

  /// This will be used to pause music/sfx.
  Future<void> pause() async {
    await audioPlayer?.pause();
  }

  /// This will be used to dispose the player.
  Future<void> dispose() async {
    await audioPlayer?.dispose();
  }
}
