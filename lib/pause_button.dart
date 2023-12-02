import 'package:flutter/material.dart';
import 'pause_dialog.dart';

class PauseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
return IconButton(
      icon: Icon(
        Icons.pause,
        color: Colors.lightGreen, 
      ),
      iconSize: 35, 
      onPressed: () {
        _showPauseDialog(context);
      },
    );
  }

  void _showPauseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PauseMenuDialog();
      },
    );
  }

}
