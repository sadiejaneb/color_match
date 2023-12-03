import 'package:color_match/circle.dart';
import 'package:color_match/hex_color_manager.dart';
import 'package:color_match/matches_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2)}';
}

class MatchesCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<MatchesModel>(builder: (context, matchesModel, _) {
        var color = Color.fromRGBO(
          matchesModel.red.toInt(),
          matchesModel.green.toInt(),
          matchesModel.blue.toInt(),
          1,
        );

        ColorHexManager.setMatchesHex(colorToHex(color));

        return Column(
          children: [
            Circle(color),
            Text("Your Color"),
          ],
        );
      });
}