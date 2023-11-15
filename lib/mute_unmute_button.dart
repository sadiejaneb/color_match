import 'package:flutter/material.dart';
import 'audio_manager.dart'; 

class MuteUnmuteButton extends StatefulWidget {
  @override
  _MuteUnmuteButtonState createState() => _MuteUnmuteButtonState();
}

class _MuteUnmuteButtonState extends State<MuteUnmuteButton> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen, // Background color for the button
        shape: BoxShape.circle, // Makes the container a circle
      ),
      
      width: 48.0, 
      height: 48.0, 
      child: IconButton(
        icon: Icon(
          isMuted
              ? Icons.volume_off
              : Icons.volume_up, // Change icon based on mute state
          color: Colors.white, // Icon color
        ),
        onPressed: () {
          setState(() {
            isMuted = !isMuted; // Toggle mute state
          });
          AudioManager.toggleMusicMute(); // Use AudioManager to mute/unmute
        },
      ),
    );
  }
}
