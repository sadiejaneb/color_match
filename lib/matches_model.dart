import 'package:flutter/material.dart';


class MatchesModel with ChangeNotifier {

  // Values of the sliders that can only be used in this class
  double _red = 0.0;
  double _green = 0.0;
  double _blue = 0.0;

  double get red => _red;

  set red(double value) {
    _red = value;
    notifyListeners();
  }

  double get green => _green;

  set green(double value) {
    _green = value;
    notifyListeners();
  }

  double get blue => _blue;

  set blue(double value) {
    _blue = value;
    notifyListeners();
  }
}
