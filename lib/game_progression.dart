
import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';


class GameProgress with ChangeNotifier {
  final MatchesModel matchesModel; // MatchesModel instance
  final PreviewModel previewModel; // PreviewModel instance

  GameProgress(this.matchesModel, this.previewModel);

  int _level = 1;
  double _userScore = 0.0;

  int get level => _level;

  set level(int value) {
    _level = value;
    resetGame(); // Reset the game when level changes
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

  void checkScoreForLevelChange() {
    if (_userScore >= 90) {
      _level++;
      resetGame();
    }
  }

  void resetGame() {
    matchesModel.red = 0.0;
    matchesModel.green = 0.0;
    matchesModel.blue = 0.0;
   _userScore = 0.0;
    previewModel.reset(); // Reset the preview circle
  }
  // Other methods relevant to game progression...
}
