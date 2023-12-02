import 'package:flutter/material.dart';
import 'mute_unmute_button.dart';
import 'tutorial_page.dart'; // Import the TutorialPage
import 'accomplishments.dart'; // Import the Accomplishments page

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Match'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/gameplay');
                  },
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TutorialPage()),
                    );
                  },
                  child: const Text('Tutorial'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accomplishments()),
                    );
                  },
                  child: const Text('View Accomplishments'),
                ),
              ],
            ),
          ),
           Positioned(
            top: 20,
            right: 20,
            child: MuteUnmuteButton(),
          ),
        ],
      ),
    );
  }
}
