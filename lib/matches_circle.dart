import 'package:color_match/circle.dart';
import 'package:color_match/hex_color_manager.dart';
import 'package:color_match/matches_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchesCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<MatchesModel>(builder: (context, matchesModel, _) {
        var color = Color.fromRGBO(
          matchesModel.red.toInt(),
          matchesModel.green.toInt(),
          matchesModel.blue.toInt(),
          1,
        );

        ColorHexManager.setMatchesHex(color.value.toString());

        return Column(
          children: [
            Circle(color),
            Text("Your Color"),
          ],
        );
      });
}