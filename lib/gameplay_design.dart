
import 'package:color_match/compare_button.dart';
import 'package:color_match/game_progression.dart';
import 'package:color_match/matches_circle.dart';
import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_circle.dart';
import 'package:color_match/preview_model.dart';
import 'package:color_match/sliders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameplayDesign extends StatelessWidget {
  const GameplayDesign({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProgress>(
      builder: (context, gameProgress, _) {
        var userScore = gameProgress.userScore.round();
        var currentLevel = gameProgress.level;

        return Scaffold(
          appBar: AppBar(title: Text('Color Match - Level $currentLevel')),
          body: Column(
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
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
              CompareButton(),
            ],
          ),
        );
      },
    );
  }
}
