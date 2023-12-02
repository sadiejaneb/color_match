import 'package:flutter/material.dart';
import 'music_button_dialog.dart';

class MuteUnmuteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen, // Background color of the button
        shape: BoxShape.circle, // Makes the container a circle
      ),
      child: IconButton(
        icon: Icon(
          Icons.volume_up, 
        ),
        iconSize: 25,
        onPressed: () {
          _showPauseDialog(context);
        },
      ),
    );
  }

  void _showPauseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MusicMenuDialog();
      },
    );
  }
}
