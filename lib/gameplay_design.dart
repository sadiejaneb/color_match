
import 'package:color_match/compare_button.dart';
import 'package:color_match/game_progression.dart';
import 'package:color_match/matches_circle.dart';
import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_circle.dart';
import 'package:color_match/preview_model.dart';
import 'package:color_match/sliders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pause_button.dart';
import 'mute_unmute_button.dart';
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
          body: Stack(
            children: [
              // Main content with padding
              Padding(
                padding: EdgeInsets.only(top: 60), // Adjust as needed
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
                    CompareButton(),
                  ],
                ),
              ),
              // Positioned PauseButton
              Positioned(
                top: kToolbarHeight - 40, 
                left: 10,
                child: PauseButton(),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: MuteUnmuteButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
