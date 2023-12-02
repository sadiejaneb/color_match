import 'package:flutter/material.dart';

class PauseMenuDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Paused')),
      content: Text('Game is paused.'),
      actions: <Widget>[
        TextButton(
          child: Text('Resume'),
          onPressed: () => Navigator.of(context).pop(), // Just close the dialog
        ),
        TextButton(
          child: Text('Main Menu'),
          onPressed: () {
            Navigator.of(context)
                .popUntil((route) => route.isFirst); // Go to the main menu
          },
        ),
      ],
    );
  }
}
