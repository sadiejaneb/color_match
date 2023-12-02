import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isMusicMuted = false;
  static double _currentVolume = 1.0;
  static int _currentSongIndex = 0; // Index to track the current song
  static List<String> _songs = [
    'background_music.mp3',
    'song2.mp3',
    'song3.mp3',
  ];

  static Future<void> playOrResumeMusic() async {
    if (!_isMusicMuted) {
      await _audioPlayer.play(AssetSource(_songs[_currentSongIndex]));
      _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set the audio to loop
    }
  }
  static void nextSong() {
    _currentSongIndex =
        (_currentSongIndex + 1) % _songs.length; // Move to the next song
    playOrResumeMusic(); // Play the new song
  }

  static void previousSong() {
    _currentSongIndex = (_currentSongIndex - 1 + _songs.length) %
        _songs.length; // Move to the previous song
    playOrResumeMusic(); // Play the new song
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
  static void setVolume(double volume) {
    _currentVolume = volume; // Update the volume tracking variable
    _audioPlayer.setVolume(volume);
  }
  static double getVolume() {
    return _currentVolume; // Return the current volume level
  }
}
