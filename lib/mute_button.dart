import 'package:flutter/material.dart';
import 'audio_manager.dart'; // Replace with your file name

class MuteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.music_note), // You can change the icon as needed
      onPressed: () {
        AudioManager.toggleMusicMute();
      },
    );
  }
}
