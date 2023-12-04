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
    prefs.setDouble('saved_slider1_$currentLevel', slider1Value);
    prefs.setDouble('saved_slider2_$currentLevel', slider2Value);
    prefs.setDouble('saved_slider3_$currentLevel', slider3Value);
    prefs.setInt('completed_levels', currentLevel);
  }

  static Future<List<Map<String, dynamic>>> getUserProgressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the number of completed levels
    int completedLevels = prefs.getInt('completed_levels') ?? 0;

    List<Map<String, dynamic>> progressList = [];

    for (int level = 1; level <= completedLevels; level++) {
      double savedRed = prefs.getDouble('saved_red_$level') ?? 0.0;
      double savedGreen = prefs.getDouble('saved_green_$level') ?? 0.0;
      double savedBlue = prefs.getDouble('saved_blue_$level') ?? 0.0;
      int savedColorValue =
          prefs.getInt('saved_color_$level') ?? Colors.black.value;
      double savedSlider1 = prefs.getDouble('saved_slider1_$level') ?? 0.0;
      double savedSlider2 = prefs.getDouble('saved_slider2_$level') ?? 0.0;
      double savedSlider3 = prefs.getDouble('saved_slider3_$level') ?? 0.0;

      Color savedColor = Color(savedColorValue);

      progressList.add({
        'red': savedRed,
        'green': savedGreen,
        'blue': savedBlue,
        'color': savedColor,
        'slider1': savedSlider1,
        'slider2': savedSlider2,
        'slider3': savedSlider3,
      });
    }

    return progressList;
  }
}
