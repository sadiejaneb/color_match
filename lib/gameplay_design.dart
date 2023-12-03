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

class GameplayDesign extends StatefulWidget {
  const GameplayDesign({Key? key}) : super(key: key);

  @override
  _GameplayDesignState createState() => _GameplayDesignState();
}

class _GameplayDesignState extends State<GameplayDesign> {
  int similarityValue = 90; // Default difficulty value
  int userScoreValue = 90; // Default user score threshold

  void updateSimilarityValue(int newValue) {
    setState(() {
      similarityValue = newValue;
      print('Updated similarityValue: $similarityValue');
    });
  }

  void updateUserScoreValue(int newValue) {
    setState(() {
      userScoreValue = newValue;
      print('Updated userScoreValue: $userScoreValue');
    });
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
                  onDifficultyChanged:
                      updateSimilarityValue, // Update similarityValue
                  onScoreThresholdChanged:
                      updateUserScoreValue, // Update userScoreValue
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
