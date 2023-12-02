import 'package:flutter/material.dart';
import 'audio_manager.dart';
import 'pause_menu_dialog.dart';

class PauseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        shape: BoxShape.circle,
      ),
      width: 48.0,
      height: 48.0,
      child: IconButton(
        icon: Icon(Icons.pause),
        padding: EdgeInsets.zero, // Remove padding to center the icon
        alignment: Alignment.center, // Explicitly center the icon
        onPressed: () {
          // Only pause the music; do not mute
          AudioManager.pauseMusic();
          _showPauseDialog(context);
        },
      ),
    );
  }

  void _showPauseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PauseMenuDialog();
      },
    ).then((_) {
      // Resume the music with the same volume settings as before
      AudioManager.resumeMusic();
    });
  }
}
