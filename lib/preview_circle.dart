import 'package:color_match/circle.dart';
import 'package:color_match/hex_color_manager.dart';

import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PreviewCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Provider.of<PreviewModel>(context, listen: true);
    ColorHexManager.setPreviewHex(color.colorPreview.value.toString());

    return Column(
      children: [
        Circle(color.colorPreview),
        Text("Preview"),
      ],
    );
  }
}