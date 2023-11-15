import 'package:flutter/material.dart';
// Import your MuteUnmuteButton widget
import 'mute_unmute_button.dart'; 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Match'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/gameplay'); // Navigate to GameplayDesign
              },
              child: Text('Start'),
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
