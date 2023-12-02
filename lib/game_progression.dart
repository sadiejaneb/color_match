import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GameProgress with ChangeNotifier {
  final MatchesModel matchesModel; // MatchesModel instance
  final PreviewModel previewModel; // PreviewModel instance

  // Create a SharedPreferences instance for storing/retrieving data
  late SharedPreferences _prefs;

  GameProgress(this.matchesModel, this.previewModel) {
    _initSharedPreferences();
  }

 void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _level = _prefs.getInt('current_level') ?? 1;
    _currentLevelAchievement = _prefs.getInt('current_achievement') ?? 0;

    // Load the PreviewModel state
    final previewModelJson = _prefs.getString('preview_model_state');
    if (previewModelJson != null) {
      previewModel.fromJson(json.decode(previewModelJson));
    }

    notifyListeners();
  }

  // Save current level and achievement to SharedPreferences
  void _saveProgressToSharedPreferences() async {
    await _prefs.setInt('current_level', _level);
    await _prefs.setInt('current_achievement', _currentLevelAchievement);

    // Save the PreviewModel state
    await _prefs.setString(
        'preview_model_state', json.encode(previewModel.toJson()));
  }


  // Modify your incrementCurrentLevelAchievement method
  void incrementCurrentLevelAchievement() {
    if ((_level - _currentLevelAchievement) % 2 == 0) {
      _currentLevelAchievement++;
      _saveProgressToSharedPreferences(); // Save progress
      notifyListeners();
    }
  }

  // Modify your checkScoreForLevelChange method
  void checkScoreForLevelChange() {
    if (_userScore >= 90) {
      _level++;
      resetGame();
      incrementCurrentLevelAchievement();
      _saveProgressToSharedPreferences(); // Save progress
    }
  }

  void resetGame() {
    matchesModel.red = 0.0;
    matchesModel.green = 0.0;
    matchesModel.blue = 0.0;
    _userScore = 0.0;
    previewModel.reset();
    _saveProgressToSharedPreferences();
  }

  int _currentLevelAchievement = 0;
  int get currentLevelAchievement => _currentLevelAchievement;

  int _level = 1;
  double _userScore = 0.0;

  int get level => _level;

  set level(int value) {
    _level = value;
    resetGame(); // Reset the game when the level changes
    notifyListeners();
  }

  double get userScore => _userScore;

  set userScore(double value) {
    _userScore = value;
    checkScoreForLevelChange();
    notifyListeners();
  }

  void updateUserScore(double score) {
    _userScore = score;
    checkScoreForLevelChange();
    notifyListeners();
  }

  // Other methods relevant to game progression...

  int _previousLevel = 1;
  int get previousLevel => _previousLevel;

  void updatePreviousLevel(int newLevel) {
    _previousLevel = newLevel;
  }
}
