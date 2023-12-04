import 'package:flutter/material.dart';
import 'tutorial_screen.dart';
import 'tutorial_item.dart';
import 'home.dart'; // Assuming this is the file with the HomePage widget
import 'package:provider/provider.dart';
import 'game_progression.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int currentIndex = 0;
  final List<TutorialItem> tutorialItems = [
    TutorialItem(
      title: 'Select Level Difficulty',
      description:
          'Toggle the difficulty button to set your desired difficulty to be either "Normal" or "Hard".',
      imageUrl: 'assets/images/tutorial/step0.png',
    ),
    TutorialItem(
      title: 'Color Creation',
      description:
          'Adjust the Red, Green, and Blue color sliders to match the color shown in the Preview circle.',
      imageUrl: 'assets/images/tutorial/step1.png',
    ),
    TutorialItem(
      title: 'Compare Your Color',
      description: 'Press the "Compare" button to see your results.',
      imageUrl: 'assets/images/tutorial/step2.png',
    ),
    TutorialItem(
      title: 'Try Again',
      description:
          'If your color creation was not close enough, you will be prompted to try again. Press "OK" to continue.',
      imageUrl: 'assets/images/tutorial/step3.png',
    ),
    TutorialItem(
      title: 'Readjust the Color Sliders',
      description:
          'Readjust the sliders and press "Compare" again after your changes are made.',
      imageUrl: 'assets/images/tutorial/step4.png',
    ),
    TutorialItem(
      title: 'Proceed to the Next Level',
      description:
          'If your match is close enough, you will be prompted to proceed to the next level. Press "Next Level" to continue.',
      imageUrl: 'assets/images/tutorial/step5.png',
    ),
  ];

  void goToPrevious() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void goToNext() {
    setState(() {
      if (currentIndex < tutorialItems.length - 1) {
        currentIndex++;
      } else {
        // If on the last page, navigate back to the home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            // Call viewTutorial when the user completes the tutorial
            Provider.of<GameProgress>(context, listen: false).viewTutorial();
            return HomePage();
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tutorial')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TutorialScreen(item: tutorialItems[currentIndex]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex > 0)
                ElevatedButton(
                  onPressed: goToPrevious,
                  child: Text('Previous'),
                ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: goToNext,
                child: Text(
                  currentIndex < tutorialItems.length - 1 ? 'Next' : 'Done',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
