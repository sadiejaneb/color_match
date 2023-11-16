import 'package:flutter/material.dart';
// Import your MuteUnmuteButton widget
import 'mute_unmute_button.dart'; 
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
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/gameplay'); // Navigate to GameplayDesign
              },
              child: const Text('Start'),
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
