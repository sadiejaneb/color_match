import 'package:color_match/matches_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sliders extends StatelessWidget {
  const Sliders({super.key});

  Widget _createSlider(
          {required String label,
          required Color color,
          required double value,
          required Function(double) onChanged}) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Slider(
              activeColor: color,
              value: value,
              onChanged: onChanged,
              min: 0,
              max: 255,
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    var color = Provider.of<MatchesModel>(context, listen: true);
    return Column(
      children: [
        _createSlider(
            label: "Red (${color.red.toInt()})",
            color: Colors.red,
            value: color.red,
            onChanged: (value) => color.red = value),
        _createSlider(
            label: "Green (${color.green.toInt()})",
            color: Colors.green,
            value: color.green,
            onChanged: (value) => color.green = value),
        _createSlider(
            label: "Blue (${color.blue.toInt()})",
            color: Colors.blue,
            value: color.blue,
            onChanged: (value) => color.blue = value),
      ],
    );
  }
}
