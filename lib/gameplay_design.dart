import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_match/compare_button.dart';
import 'package:color_match/game_progression.dart';
import 'package:color_match/matches_circle.dart';
import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_circle.dart';
import 'package:color_match/preview_model.dart';
import 'package:color_match/sliders.dart';
import 'pause_button.dart';
import 'difficulty_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_progress.dart';

class GameplayDesign extends StatefulWidget {
  const GameplayDesign({Key? key}) : super(key: key);

  @override
  _GameplayDesignState createState() => _GameplayDesignState();
}

class _GameplayDesignState extends State<GameplayDesign> {
  int similarityValue = 80; // Default difficulty value
  int userScoreValue = 80; // Default user score threshold
  bool isHard = false; // Define isHard as a property

  void toggleDifficulty() {
    setState(() {
      isHard = !isHard;
    });
    int newValue = isHard ? 90 : 80;
    updateSimilarityValue(newValue);
    updateUserScoreValue(newValue);

    // Set the difficulty mode in GameProgress
    Provider.of<GameProgress>(context, listen: false).setHardMode(isHard);
    // Assuming you also have a method to handle completing a level in the GameplayDesign widget
    Provider.of<GameProgress>(context, listen: false).completeLevel();
  }
  

  void _loadSimilarityValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedValue = prefs.getInt('similarityValue') ?? 80;
    setState(() {
      similarityValue = savedValue;
    });
  }

  void _loadUserScoreValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedValue = prefs.getInt('userScoreValue') ?? 80;
    setState(() {
      userScoreValue = savedValue;
    });
  }

  void updateSimilarityValue(int newValue) {
    setState(() {
      similarityValue = newValue;
      print('Updated similarityValue: $similarityValue');
      // Save similarityValue
      _saveSimilarityValue(newValue);
    });
  }

  void updateUserScoreValue(int newValue) {
    setState(() {
      userScoreValue = newValue;
      print('Updated userScoreValue: $userScoreValue');
      // Save userScoreValue
      _saveUserScoreValue(newValue);
    });
  }

  void _saveSimilarityValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('similarityValue', value);
  }

  void _saveUserScoreValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userScoreValue', value);
  }

  void saveUserAnswer() {
    MatchesModel matchesModel =
        Provider.of<MatchesModel>(context, listen: false);
    int currentLevel = Provider.of<GameProgress>(context, listen: false).level;

    UserProgress.saveUserProgress(
      matchesModel.red,
      matchesModel.green,
      matchesModel.blue,
      Color.fromRGBO(
        matchesModel.red.toInt(),
        matchesModel.green.toInt(),
        matchesModel.blue.toInt(),
        1,
      ),
      currentLevel,
      matchesModel.red,
      matchesModel.green,
      matchesModel.blue,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User answer saved for Level $currentLevel'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProgress>(
      builder: (context, gameProgress, _) {
        var userScore = gameProgress.userScore.round();
        var currentLevel = gameProgress.level;

        return Scaffold(
          appBar: AppBar(title: Text('Color Match - Level $currentLevel')),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Score: $userScore%',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Match The Color!',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PreviewCircle(),
                        MatchesCircle(),
                      ],
                    ),
                    Sliders(),
                    CompareButton(
                        similarityValue:
                            similarityValue), // Pass the similarityValue to CompareButton
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: DifficultyButton(
                  onDifficultyChanged: updateSimilarityValue,
                  onScoreThresholdChanged: updateUserScoreValue,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: saveUserAnswer,
                  child: Text('Save Color'),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: PauseButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
