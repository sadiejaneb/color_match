import 'dart:math';
import 'package:flutter/material.dart';

class ColorGenerator {
  static Random rand = Random();

  //generate a random color
  static Color getColor() {

    return Color.fromRGBO(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255), 1);
  }
}