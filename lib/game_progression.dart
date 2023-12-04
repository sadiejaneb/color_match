import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GameProgress with ChangeNotifier {
  final MatchesModel matchesModel; // MatchesModel instance
  final PreviewModel previewModel; // PreviewModel instance

  // Create a SharedPreferences instance for storing/retrieving data
  late SharedPreferences _prefs;
  int userScoreValue = 80; // Default difficulty value

  bool _isHardMode = false;

  bool get isHardMode => _isHardMode;

  bool _viewedTutorial = false;

  bool get viewedTutorial => _viewedTutorial;

  int _totalAchievements = 0;

  int get totalAchievements => _totalAchievements;

  List<String> _earnedAccomplishments = [];

  List<String> get earnedAccomplishments => _earnedAccomplishments;
  bool _hardLevelAchievementAwarded = false;
  bool get hardLevelAchievementAwarded => _hardLevelAchievementAwarded;

  

  // Method to add an earned accomplishment
void addEarnedAccomplishment(String accomplishment) {
    _earnedAccomplishments.add(accomplishment);
    _saveAchievementsToSharedPreferences();
    notifyListeners();
  }

  void _saveAchievementsToSharedPreferences() async {
    await _prefs.setStringList(
        'earned_accomplishments', _earnedAccomplishments);
  }

  // Method to increment the total achievements
  void incrementTotalAchievements() {
    _totalAchievements++;
    notifyListeners();
  }

  // Method to mark the tutorial as viewed
  void viewTutorial() {
    _viewedTutorial = true;
    //notifyListeners();
  }

  // Method to set the difficulty mode
  void setHardMode(bool isHardMode) {
    _isHardMode = isHardMode;
    notifyListeners();
  }

  GameProgress(this.matchesModel, this.previewModel) {
    _initSharedPreferences();
  }

void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _level = _prefs.getInt('current_level') ?? 1;
    _currentLevelAchievement = _prefs.getInt('current_achievement') ?? 0;
    _viewedTutorial = _prefs.getBool('viewed_tutorial') ?? false;
    _hardLevelAchievementAwarded =
        _prefs.getBool('hard_level_achievement_awarded') ?? false;
    _totalAchievements = _prefs.getInt('total_achievements') ?? 0;

    final previewModelJson = _prefs.getString('preview_model_state');
    if (previewModelJson != null) {
      previewModel.fromJson(json.decode(previewModelJson));
    }

    _earnedAccomplishments =
        _prefs.getStringList('earned_accomplishments') ?? [];

    notifyListeners();
  }


  // Save current level and achievement to SharedPreferences
  void _saveProgressToSharedPreferences() async {
    await _prefs.setInt('current_level', _level);
    await _prefs.setInt('current_achievement', _currentLevelAchievement);

    // Save the PreviewModel state
    await _prefs.setString(
        'preview_model_state', json.encode(previewModel.toJson()));

     // Save additional states
    await _prefs.setBool('viewed_tutorial', _viewedTutorial);
    await _prefs.setBool(
        'hard_level_achievement_awarded', _hardLevelAchievementAwarded);
    await _prefs.setInt('total_achievements', _totalAchievements);
  }

  void incrementCurrentLevelAchievement() {
    _currentLevelAchievement++;
    if (_currentLevelAchievement == 1) {
      // Trigger first-level accomplishment
      completeFirstLevel();
    }
    _saveProgressToSharedPreferences(); // Save progress
    notifyListeners();
    incrementTotalAchievements(); // Increment total achievements
    addEarnedAccomplishment('Completed Level $_currentLevelAchievement!');
  }

  void completeFirstLevel() {
    
    print('Congratulations on completing your first level!');
    addEarnedAccomplishment('Completed Your First Level!');
  }

  void updateUserScoreValue(int newValue) {
    userScoreValue = newValue;
    notifyListeners();
  }

  // Modify your checkScoreForLevelChange method
  void checkScoreForLevelChange() {
    if (_userScore >= userScoreValue) {
      double currentScore = _userScore;
      updateUserScore(currentScore);
      _level++;
      resetGame();
      incrementCurrentLevelAchievement();
      _saveProgressToSharedPreferences(); // Save progress
    }
  }

  void resetGame() {
    matchesModel.red = _prefs.getDouble('saved_red_$_level') ?? 0.0;
    matchesModel.green = _prefs.getDouble('saved_green_$_level') ?? 0.0;
    matchesModel.blue = _prefs.getDouble('saved_blue_$_level') ?? 0.0;
    _userScore = 0.0;
    previewModel.reset();
    _saveProgressToSharedPreferences();
  }

  int _currentLevelAchievement = 0;

  int get currentLevelAchievement => _currentLevelAchievement;

void completeCurrentLevel(BuildContext context) {
    Provider.of<GameProgress>(context, listen: false).completeLevel();
  }


  void completeLevel() {
    _currentLevelAchievement += 1;
    notifyListeners();

    if (isHardMode && !_hardLevelAchievementAwarded) {
      _hardLevelAchievementAwarded = true; // Set the flag to true
      addEarnedAccomplishment('Completed a Hard Level! ');
    }

    incrementTotalAchievements(); // Increment total achievements
    addEarnedAccomplishment('Completed Level $_currentLevelAchievement!');
    _saveProgressToSharedPreferences(); // Save progress
  }

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
    if (_userScore != score) {
      _userScore = score;
      checkScoreForLevelChange();
      notifyListeners();
    }
  }

  int _previousLevel = 1;
  int get previousLevel => _previousLevel;

  void updatePreviousLevel(int newLevel) {
    _previousLevel = newLevel;
  }
  
}
