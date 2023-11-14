
import 'package:color_match/compare_button.dart';
import 'package:color_match/matches_circle.dart';
import 'package:color_match/preview_circle.dart';
import 'package:color_match/reset_button.dart';
import 'package:color_match/sliders.dart';
import 'package:flutter/material.dart';

class GameplayDesign extends StatelessWidget {
  const GameplayDesign({super.key}); //delete??

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Match')), //AppBar
      body: Column(
        children: [
          // ignore: prefer_const_constructors
          Center(
            // ignore: prefer_const_constructors
            child: Text(
              // ignore: prefer_const_constructors
              'Match The Color!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PreviewCircle(),
              MatchesCircle(),
            ],
          ),
          
          const Sliders(),
          ResetButton(),
          CompareButton()
    
        ],
      ),
    );
  }
}