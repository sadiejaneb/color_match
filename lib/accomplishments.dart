import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_progression.dart';

class Accomplishments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accomplishments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Accomplishments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Display all accomplishments
            LevelAccomplishmentWidget(),
          ],
        ),
      ),
    );
  }
}

class LevelAccomplishmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProgress = context.watch<GameProgress>();

    return Column(
      children: [
        if (gameProgress.totalAchievements >= 2)
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Earned Three Achievements!'),
              subtitle: Text('Congratulations on earning three achievements.'),
            ),
          ),
        if (gameProgress.viewedTutorial)
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Viewed Tutorial!'),
              subtitle: Text('Congratulations on viewing the tutorial.'),
            ),
          ),
        if (gameProgress.currentLevelAchievement >= 1)
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Completed Your First Level!'),
              subtitle: Text('Congratulations on completing your first level.'),
            ),
          ),
        if (gameProgress.currentLevelAchievement >= 2)
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Completed Your Second Level!'),
              subtitle:
                  Text('Congratulations on completing your second level.'),
            ),
          ),
        if (gameProgress.currentLevelAchievement >= 5)
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Completed Your Fifth Level!'),
              subtitle: Text('Congratulations on completing your fifth level.'),
            ),
          ),
        if (gameProgress.currentLevelAchievement >= 10)
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Completed Your Fifth Level!'),
              subtitle: Text('Congratulations on completing your fifth level.'),
            ),
          ),
      ],
    );
  }
}
