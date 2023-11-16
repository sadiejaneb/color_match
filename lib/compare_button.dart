import 'package:color_match/matches_circle.dart';
import 'package:color_match/preview_circle.dart';
import 'package:flutter/material.dart';


class CompareButton extends StatelessWidget {
  static var difference;

  const CompareButton({super.key});

  //Calculates the score
  String score(difference) {
    difference = ((PreviewCircle.previewHex)-
    (MatchesCircle.matchesHex)).abs();

    //your guess is in the top quadrant
    if(difference < 4194304) {
      return "Your score: 100%";
    } 
     //your guess is in the 2nd quadrant
    else if (difference < 8388608) {
      return "Your score: 75%";
    } 
     //your guess is in the 3rd quadrant
    else if (difference < 12582912) {
      return "Your score: 50%";
    } 
     //your guess is in the bottom quadrant
    else {
      return "Your score: 0%";
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Thank you for playing"),
            content: Text(score(difference),),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                })
            ]
            );
        }
      );
    }

    return ElevatedButton(
        style: ButtonStyle(
           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0))
        ),
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.blue)
        ),
        child: const Text('Compare',
                    style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          score(difference);
          _showDialog();
        },
      );
  
  }
}