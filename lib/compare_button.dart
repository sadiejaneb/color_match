import 'dart:math';
import 'package:color_match/game_progression.dart';
import 'package:color_match/hex_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CompareButton extends StatefulWidget {
    final int similarityValue;

  CompareButton({Key? key, required this.similarityValue}) : super(key: key);

  @override
  _CompareButtonState createState() => _CompareButtonState();
}

class _CompareButtonState extends State<CompareButton> {
   @override
  void didUpdateWidget(covariant CompareButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.similarityValue != oldWidget.similarityValue) {
      print(
          'CompareButton received new similarityValue: ${widget.similarityValue}');
    }
  }
  
  int similarityValue = 90; // Initial value is set to 90

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

    // Convert hex strings to Color objects
    Color color1 = Color(int.parse(hexColor1.substring(1, 7), radix: 16) + 0xFF000000);
    Color color2 = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);

    // Calculate weighted Euclidean distance
    double weightedDistance = weightedEuclideanDistance(color1, color2);

    // Calculate similarity percentage based on the weighted distance
    double maxWeightedDistance = 441.672; // Maximum possible weighted distance with 255 as the maximum channel value
    double similarity = ((maxWeightedDistance - weightedDistance) / maxWeightedDistance) * 100;

    return similarity.clamp(0.0, 100.0); // Ensure similarity score stays within 0-100 range
    
}

 double weightedEuclideanDistance(Color color1, Color color2) {
    double redDiff = (color1.red - color2.red).abs() * 0.299;
    double greenDiff = (color1.green - color2.green).abs() * 0.587;
    double blueDiff = (color1.blue - color2.blue).abs() * 0.114;

    // Calculate weighted Euclidean distance
    double weightedDistance = sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff);

    return weightedDistance;
}

  @override
  Widget build(BuildContext context) {
    var gameProgress = Provider.of<GameProgress>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        String previewColor = ColorHexManager.getPreviewHex();
        String matchesColor = ColorHexManager.getMatchesHex();
        double similarity = calculateColorSimilarity(previewColor, matchesColor);
     


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

