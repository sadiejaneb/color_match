import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  
  final Color color;
  const Circle(this.color, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black, width: 3,),
            color: color),
      ),
    );
  }
}