import 'dart:math';


import 'package:flutter/material.dart';

class PreviewModel with ChangeNotifier {
  Color _colorPreviewModel = _generateColor(); // Initially generate a color
  Color get colorPreview => _colorPreviewModel;

  void reset() {
    _colorPreviewModel = _generateColor(); // Reset to a new color
    notifyListeners();
  }

  static Color _generateColor() {
    // Generate a random color
    return Color.fromRGBO(
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
      1,
    );
  }
  
}
