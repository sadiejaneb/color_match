import 'package:flutter/material.dart';
import 'audio_manager.dart';

class MusicMenuDialog extends StatefulWidget {
  @override
  _MusicMenuDialogState createState() => _MusicMenuDialogState();
}

class _MusicMenuDialogState extends State<MusicMenuDialog> {
  double volume = 1.0; // Default value

  @override
  void initState() {
    super.initState();
    // Initialize the volume with the current volume from AudioManager
    initializeVolume();
  }

  void initializeVolume() async {
    double currentVolume =
        await AudioManager.getVolume(); // Assuming getVolume is an async method
    setState(() {
      volume = currentVolume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Music Menu'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Volume Slider
          Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            divisions: 10,
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
        Center(
          // Center the Resume button
          child: TextButton(
            child: Text('Resume'),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Close the dialog and resume the game
            },
          ),
        ),
      ],
      actionsAlignment:
          MainAxisAlignment.center, // Ensure alignment is centered
    );
  }
}
