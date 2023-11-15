import 'package:flutter/material.dart';
import 'audio_manager.dart'; // Import your AudioManager

class MuteUnmuteButton extends StatefulWidget {
  @override
  _MuteUnmuteButtonState createState() => _MuteUnmuteButtonState();
}

class _MuteUnmuteButtonState extends State<MuteUnmuteButton> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isMuted
            ? Icons.volume_off
            : Icons.volume_up, // Change icon based on mute state
      ),
      onPressed: () {
        setState(() {
          isMuted = !isMuted; // Toggle mute state
        });
        AudioManager.toggleMusicMute(); // Use AudioManager to mute/unmute
      },
    );
  }
}