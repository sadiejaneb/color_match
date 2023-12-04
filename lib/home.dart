import 'package:flutter/material.dart';
import 'music_button.dart';
import 'tutorial_page.dart';
import 'accomplishments.dart';
import 'user_progress_page.dart';

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
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                // Colorful "COLOR MATCH" text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildColorfulText('COLOR'),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildColorfulText('MATCH'),
                      ),
                    ],
                  ),
                ),
                // Buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/gameplay');
                    },
                    child: const Text('Start'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TutorialPage()),
                      );
                    },
                    child: const Text('Tutorial'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Accomplishments()),
                      );
                    },
                    child: const Text('Accomplishments'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProgressPage()),
                      );
                    },
                    child: const Text('Saved Colors'),
                  ),
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

  List<Widget> _buildColorfulText(String text) {
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.cyan,
      Colors.lime,
    ];
    int colorIndex = 0;

    return text.split('').map((letter) {
      Color color = colors[colorIndex++ % colors.length];
      return Text(
        letter,
        style: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      );
    }).toList();
  }
}
