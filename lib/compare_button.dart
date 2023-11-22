import 'package:color_match/game_progression.dart';
import 'package:color_match/hex_color_manager.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CompareButton extends StatelessWidget {
  static double calculateColorSimilarity(String hexColor1, String hexColor2) {
    Color color1 = Color(int.parse(hexColor1.substring(1, 7), radix: 16) + 0xFF000000);
    Color color2 = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);

double distance = ((color1.red - color2.red).abs() +
        (color1.green - color2.green).abs() +
        (color1.blue - color2.blue).abs()) as double;

    double maxDistance = 255 * 3;
    double similarity = ((maxDistance - distance) / maxDistance) * 100;

    return similarity.clamp(0.0, 100.0); // Ensure similarity score stays within 0-100 range
  }

  @override
  Widget build(BuildContext context) {
    var gameProgress = Provider.of<GameProgress>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        String previewColor = ColorHexManager.getPreviewHex();
        String matchesColor = ColorHexManager.getMatchesHex();
        double similarity = calculateColorSimilarity(previewColor, matchesColor);

        gameProgress.updateUserScore(similarity); // Update the user's score directly
      },
      child: const Text(
        'Compare',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
