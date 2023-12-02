import 'package:flutter/material.dart';
import 'tutorial_screen.dart';
import 'tutorial_item.dart';

class TutorialPage extends StatelessWidget {
  final List<TutorialItem> tutorialItems = [
    TutorialItem(
      title: 'How to Start',
      description: 'Learn how to begin the game.',
      imageUrl: 'assets/images/tutorial/start_image.png',
    ),
    TutorialItem(
      title: 'Scoring Points',
      description: 'Understand how scoring works.',
      imageUrl: 'assets/images/tutorial/scoring_image.png',
    ),
    TutorialItem(
      title: 'Advanced Techniques',
      description: 'Master advanced gameplay techniques.',
      imageUrl: 'assets/images/tutorial/advanced_image.png',
    ),
    // Add more tutorial items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tutorial')),
      body: PageView.builder(
        itemCount: tutorialItems.length,
        itemBuilder: (context, index) {
          final item = tutorialItems[index];
          return TutorialScreen(item: item);
        },
      ),
    );
  }
}
