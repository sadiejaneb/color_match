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

  Map<String, dynamic> toJson() {
    return {
      'red': _colorPreviewModel.red,
      'green': _colorPreviewModel.green,
      'blue': _colorPreviewModel.blue,
    };
  }

  void fromJson(Map<String, dynamic> json) {
    final red = json['red'] ?? 0;
    final green = json['green'] ?? 0;
    final blue = json['blue'] ?? 0;
    _colorPreviewModel = Color.fromRGBO(red, green, blue, 1);
    notifyListeners();
  }
}
