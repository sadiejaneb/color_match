import 'package:color_match/circle.dart';
import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PreviewCircle extends StatelessWidget {
  static var previewHex;

  const PreviewCircle({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<PreviewModel> (context, listen: true);
    previewHex = color.colorPreview.value;

    return Column(
      children: [
        Circle(color.colorPreview),
        const Text("Preview"),
      ],
    );
  }
}