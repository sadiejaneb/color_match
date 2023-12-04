import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'game_progression.dart';

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

  @override
  void initState() {
    super.initState();
    _loadDifficultyState();
  }

  void _loadDifficultyState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool savedIsHard = prefs.getBool('isHard') ?? false;
    setState(() {
      isHard = savedIsHard;
    });
  }

  void toggleDifficulty() {
    setState(() {
      isHard = !isHard;
    });
    int newValue = isHard ? 90 : 80;
    widget.onDifficultyChanged(newValue);
    widget.onScoreThresholdChanged(newValue);
    _saveDifficultyState();
    // Set the difficulty mode in GameProgress
    Provider.of<GameProgress>(context, listen: false).setHardMode(isHard);
    // Assuming you also have a method to handle completing a level in the GameplayDesign widget
    Provider.of<GameProgress>(context, listen: false).completeLevel();
  }

  void _saveDifficultyState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHard', isHard);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: toggleDifficulty,
      child: Text(isHard ? 'Hard' : 'Normal'),
    );
  }
}
