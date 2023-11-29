import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Accomplishments extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accomplishments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello'),
            Text('bye'),
          ],
        ),
      ),
    );
 }
}