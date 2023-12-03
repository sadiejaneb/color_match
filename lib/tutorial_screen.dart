import 'package:flutter/material.dart';
import 'tutorial_item.dart';

class TutorialScreen extends StatelessWidget {
  final TutorialItem item;

  const TutorialScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Image.asset(
            item.imageUrl,
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
