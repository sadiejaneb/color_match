import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    var colorPreview = Provider.of<PreviewModel>(context,
    listen: true);

    var colorMatch = Provider.of<MatchesModel>(context);


    void colorPreviewReset() {
      colorPreview.reset();
    }

    void matchesReset() {
      colorMatch.red = 0.0;
      colorMatch.green = 0.0;
      colorMatch.blue = 0.0;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0))
        ),
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.grey)
        ),
        child: const Text('Reset',
                    style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          colorPreviewReset();
          matchesReset();
        },
      ),
    );
  }
}