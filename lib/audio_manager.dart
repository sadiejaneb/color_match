import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _currentSongIndex = (_currentSongIndex + 1) % _songs.length;
    playOrResumeMusic();
    saveSettings(); // Save new song index
     print("Next song index: $_currentSongIndex");
  }

  static void previousSong() {
    _currentSongIndex = (_currentSongIndex - 1 + _songs.length) % _songs.length;
    playOrResumeMusic();
    saveSettings(); // Save new song index
  }

  static void muteMusic() {
    _audioPlayer.setVolume(0);
    _isMusicMuted = true;
  }

  static void unmuteMusic() {
    _audioPlayer.setVolume(1);
    _isMusicMuted = false;
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
  static double getVolume() {
    return _currentVolume; // Return the current volume level
  }
  static Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', _currentVolume);
    await prefs.setBool('isMuted', _isMusicMuted);
    await prefs.setInt(
        'currentSongIndex', _currentSongIndex); // Save current song index
        print("Saved song index: $_currentSongIndex");
  }

  static Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _currentVolume = prefs.getDouble('volume') ?? 1.0;
    _isMusicMuted = prefs.getBool('isMuted') ?? false;
    _currentSongIndex =
        prefs.getInt('currentSongIndex') ?? 0; // Load current song index
    print("Loaded song index: $_currentSongIndex");

    if (_isMusicMuted) {
      await _audioPlayer.setVolume(0);
    } else {
      await _audioPlayer.setVolume(_currentVolume);
    }
    // start playing the loaded song
    playOrResumeMusic();
  }

  // Update the setVolume and toggleMusicMute methods to save settings
  static void setVolume(double volume) {
    _currentVolume = volume;
    _audioPlayer.setVolume(volume);
    saveSettings();
  }

  static void toggleMusicMute() {
    if (_isMusicMuted) {
      unmuteMusic();
    } else {
      muteMusic();
    }
    saveSettings();
  }
}
