import 'package:flutter/material.dart';
// Import your MuteUnmuteButton widget
import 'mute_unmute_button.dart'; 
import 'accomplishments.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    Navigator.pushNamed(
                        context, '/gameplay'); // Navigate to GameplayDesign
                 },
                 child: const Text('Start'),
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
          const Positioned(
            top: 20, 
            right: 20, 
            child: MuteUnmuteButton(), 
          ),
        ],
      ),
    );
  }
}
