import 'package:flutter/material.dart';
import 'audio_manager.dart';

class PauseMenuDialog extends StatefulWidget {
  @override
  _PauseMenuDialogState createState() => _PauseMenuDialogState();
}

class _PauseMenuDialogState extends State<PauseMenuDialog> {
  double volume = 1.0; // Adjust based on your AudioManager settings

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pause Menu'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Volume Slider
          Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            onChanged: (newVolume) {
              setState(() {
                volume = newVolume;
                AudioManager.setVolume(newVolume); // Adjust the volume
              });
            },
          ),
          // Song Selection Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  AudioManager.previousSong(); // Play the previous song
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  AudioManager.nextSong(); // Play the next song
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Resume'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog and resume the game
          },
        ),
        TextButton(
          child: Text('Main Menu'),
          onPressed: () {
            // Navigate back to the main screen
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
