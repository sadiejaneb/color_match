import 'package:color_match/gameplay_design.dart';
import 'package:color_match/home.dart';
import 'package:color_match/matches_model.dart';
import 'package:color_match/preview_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomePage(), // Set the initial route
      routes: {
        '/gameplay': (context) => MultiProvider( // Wrap GameplayDesign with MultiProvider
              providers: [
                ChangeNotifierProvider<PreviewModel>(
                  create: (context) => PreviewModel(),
                ),
                ChangeNotifierProvider<MatchesModel>(
                  create: (context) => MatchesModel(),
                )
              ],
              child: const GameplayDesign(),
            ),
      },
    );
  }
}
