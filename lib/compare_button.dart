import 'dart:math';
import 'package:color_match/game_progression.dart';
import 'package:color_match/hex_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'user_progress.dart';
import 'matches_model.dart';

class CompareButton extends StatefulWidget {
  final int similarityValue;

  CompareButton({Key? key, required this.similarityValue}) : super(key: key);

  @override
  _CompareButtonState createState() => _CompareButtonState();
}

class LabColor {
  final double l;
  final double a;
  final double b;

  LabColor(this.l, this.a, this.b);
}

class _CompareButtonState extends State<CompareButton> {
  double slider1Value = 0.0;
  double slider2Value = 0.0;
  double slider3Value = 0.0;

  int similarityValue = 80; // Initial value is set to 80
  final Logger _logger = Logger();
  @override
  void didUpdateWidget(covariant CompareButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.similarityValue != oldWidget.similarityValue) {
      print(
          'CompareButton received new similarityValue: ${widget.similarityValue}');
    }
  }

  void updateSimilarityValue(int newValue) {
    setState(() {
      similarityValue = newValue;
    });
  }

  double calculateColorSimilarity(String hexColor1, String hexColor2) {
    if (hexColor1.length < 7 || hexColor2.length < 7) {
      // Handle invalid color strings
      return 0.0;
    }
    _logger.d('Hex Color 1: $hexColor1');
    _logger.d('Hex Color 2: $hexColor2');

    LabColor lab1 = hexToLab(hexColor1);
    LabColor lab2 = hexToLab(hexColor2);

    // Calculate color difference using CIEDE2000 algorithm
    double deltaE = calculateDeltaE2000(lab1, lab2);

    // Calculate similarity based on the color difference
    double similarity = 100 -
        deltaE; // Invert the difference as higher similarity means lower deltaE

    return similarity.clamp(
        0.0, 100.0); // Ensure similarity score stays within 0-100 range
  }

  LabColor hexToLab(String hexColor) {
    Color color =
        Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    double? r = color.red / 255.0;
    double? g = color.green / 255.0;
    double? b = color.blue / 255.0;

    // Convert sRGB to XYZ
    r = ((r > 0.04045) ? pow(((r + 0.055) / 1.055), 2.4) : r / 12.92)
        as double?;
    g = ((g > 0.04045) ? pow(((g + 0.055) / 1.055), 2.4) : g / 12.92)
        as double?;
    b = ((b > 0.04045) ? pow(((b + 0.055) / 1.055), 2.4) : b / 12.92)
        as double?;

    double? x = r! * 0.4124564 + g! * 0.3575761 + b! * 0.1804375;
    double? y = r * 0.2126729 + g * 0.7151522 + b * 0.0721750;
    double? z = r * 0.0193339 + g * 0.1191920 + b * 0.9503041;

    // Convert XYZ to CIELAB
    x = x / 0.95047;
    y = y / 1.00000;
    z = z / 1.08883;

    x = ((x > 0.008856) ? pow(x, 1 / 3) : (7.787 * x) + 16 / 116) as double?;
    y = ((y > 0.008856) ? pow(y, 1 / 3) : (7.787 * y) + 16 / 116) as double?;
    z = ((z > 0.008856) ? pow(z, 1 / 3) : (7.787 * z) + 16 / 116) as double?;

    double l = (116 * y!) - 16;
    double a = 500 * (x! - y);
    double bValue = 200 * (y - z!);

    return LabColor(l, a, bValue);
  }

  double calculateDeltaE2000(LabColor lab1, LabColor lab2) {
    // CIEDE2000 algorithm
    double kL = 1;
    double kC = 1;
    double kH = 1;

    double deltaL = lab2.l - lab1.l;
    double avgL = (lab1.l + lab2.l) / 2;
    double c1 = sqrt(pow(lab1.a, 2) + pow(lab1.b, 2));
    double c2 = sqrt(pow(lab2.a, 2) + pow(lab2.b, 2));
    double avgC = (c1 + c2) / 2;
    num avgC7 = pow(avgC, 7);
    double g = 0.5 * (1 - sqrt(avgC7 / (avgC7 + 6103515625))); // 25^7

    double a1p = lab1.a * (1 + g);
    double a2p = lab2.a * (1 + g);

    double c1p = sqrt(pow(a1p, 2) + pow(lab1.b, 2));
    double c2p = sqrt(pow(a2p, 2) + pow(lab2.b, 2));
    double avgCp = (c1p + c2p) / 2;
    double deltaCp = c2p - c1p;

    double h1p = atan2(lab1.b, a1p);
    h1p += (h1p < 0) ? 2 * pi : 0;

    double h2p = atan2(lab2.b, a2p);
    h2p += (h2p < 0) ? 2 * pi : 0;

    double dLp = lab2.l - lab1.l;
    double dCp = c2p - c1p;
    double dHp = (deltaCp == 0) ? 0 : (h2p - h1p).abs();
    dHp -= (dHp > pi) ? 2 * pi : 0;
    dHp += (dHp < -pi) ? 2 * pi : 0;
    double deltaHp = 2 * sqrt(c1p * c2p) * sin(dHp / 2);

    double avgHp = (h1p + h2p) / 2;
    double hpAdjustment =
        (deltaCp == 0) ? 0 : (pi - (avgHp - pi).abs() % (2 * pi)) - pi;
    double deltaLp = dLp;
    num deltaCp7 = pow(deltaCp, 7);

    double deltaE = sqrt(pow(deltaLp / (kL * kL), 2) +
        pow(deltaCp / (kC * kC), 2) +
        pow(deltaHp / (kH * kH), 2) +
        (deltaCp / (kC * kC)) *
            (deltaCp / (kC * kC)) *
            deltaLp *
            deltaLp /
            deltaCp7);

    return deltaE;
  }

  @override
  Widget build(BuildContext context) {
    var gameProgress = context.read<GameProgress>();

    return ElevatedButton(
      onPressed: () {
        String previewColor = ColorHexManager.getPreviewHex();
        String matchesColor = ColorHexManager.getMatchesHex();
        double similarity =
            calculateColorSimilarity(previewColor, matchesColor);

        gameProgress.updateUserScore(similarity);

        if (similarity > similarityValue) {
          print('similarity value: $similarityValue');
          _showCongratsDialog(context, gameProgress);
        } else {
          _showTryAgainDialog(context);
        }
      },
      child: const Text(
        'Compare',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _showCongratsDialog(BuildContext context, GameProgress gameProgress) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excellent Match!'),
          content: Text('You can proceed to the next level.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Next Level'),
            ),
          ],
        );
      },
    );
  }

  void _saveUserProgress(
    GameProgress gameProgress,
    double slider1Value,
    double slider2Value,
    double slider3Value,
  ) {
    String matchesHex = ColorHexManager.getMatchesHex();
    Color matchesColor = Color(int.parse(matchesHex, radix: 16));

    UserProgress.saveUserProgress(
      gameProgress.matchesModel.red,
      gameProgress.matchesModel.green,
      gameProgress.matchesModel.blue,
      matchesColor,
      gameProgress.level,
      slider1Value,
      slider2Value,
      slider3Value,
    );
  }

  void _showTryAgainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not Quite!'),
          content: Text('Please try again.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
