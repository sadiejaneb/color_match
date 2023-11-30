import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_progression.dart';

class Accomplishments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProgress = Provider.of<GameProgress>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Accomplishments')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current Level Achievement: ${gameProgress.currentLevelAchievement}'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
