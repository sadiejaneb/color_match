import 'package:audioplayers/audioplayers.dart';


class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isMusicMuted = false;

  static Future<void> playOrResumeMusic() async {
    if (!_isMusicMuted) {
      //await _audioPlayer.play('background_music.mp3', isLooping: true);
    }
  }

  static void muteMusic() {
    _audioPlayer.setVolume(0);
    _isMusicMuted = true;
  }

  static void unmuteMusic() {
    _audioPlayer.setVolume(1);
    _isMusicMuted = false;
  }

  static void toggleMusicMute() {
    if (_isMusicMuted) {
      unmuteMusic();
    } else {
      muteMusic();
    }
  }

  static Future<void> stopMusic() async {
    if (!_isMusicMuted) {
      await _audioPlayer.stop();
    }
  }
  static Future<void> pauseMusic() async {
    if (!_isMusicMuted) {
      await _audioPlayer.pause();
    }
  }

  static Future<void> resumeMusic() async {
    if (!_isMusicMuted) {
      await _audioPlayer.resume();
    }
  }
}
