import 'package:flutter/material.dart';

class DifficultyButton extends StatefulWidget {
  final Function(int) onDifficultyChanged;
  final Function(int) onScoreThresholdChanged;

  DifficultyButton({
    Key? key,
    required this.onDifficultyChanged,
    required this.onScoreThresholdChanged,
  }) : super(key: key);

  @override
  _DifficultyButtonState createState() => _DifficultyButtonState();
}

class _DifficultyButtonState extends State<DifficultyButton> {
  bool isHard = false;

  void toggleDifficulty() {
    setState(() {
      isHard = !isHard;
    });
    int newValue = isHard ? 95 : 90;
    widget.onDifficultyChanged(newValue);
    widget.onScoreThresholdChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: toggleDifficulty,
      child: Text(isHard ? 'Hard' : 'Normal'),
    );
  }
}
