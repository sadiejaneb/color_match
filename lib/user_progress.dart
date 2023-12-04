import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProgress {
  static Future<void> saveUserProgress(
    double red,
    double green,
    double blue,
    Color colorValue,
    int currentLevel,
    double slider1Value,
    double slider2Value,
    double slider3Value,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('saved_red_$currentLevel', red);
    prefs.setDouble('saved_green_$currentLevel', green);
    prefs.setDouble('saved_blue_$currentLevel', blue);
    prefs.setInt('saved_color_$currentLevel', colorValue.value);
    prefs.setInt('completed_levels', currentLevel);
  }

  static Future<List<Map<String, dynamic>>> getUserProgressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the number of completed levels
    int completedLevels = prefs.getInt('completed_levels') ?? 0;

    List<Map<String, dynamic>> progressList = [];

    for (int level = 1; level <= completedLevels; level++) {
      double? savedRed = prefs.getDouble('saved_red_$level');
      double? savedGreen = prefs.getDouble('saved_green_$level');
      double? savedBlue = prefs.getDouble('saved_blue_$level');
      int? savedColorValue = prefs.getInt('saved_color_$level');

      if (savedRed != null &&
          savedGreen != null &&
          savedBlue != null &&
          savedColorValue != null) {
        Color savedColor = Color(savedColorValue);

        progressList.add({
          'red': savedRed,
          'green': savedGreen,
          'blue': savedBlue,
          'color': savedColor,
        });
      }
    }

    return progressList;
  }
}
