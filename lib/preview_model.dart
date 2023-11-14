import 'package:color_match/color_generator.dart';
import 'package:flutter/material.dart';

class PreviewModel with ChangeNotifier{
  Color colorPreviewModel =ColorGenerator.getColor();
  Color get colorPreview => colorPreviewModel;

//method to reset preview circle 

void reset() {
  colorPreviewModel = ColorGenerator.getColor();
  notifyListeners();
}
}