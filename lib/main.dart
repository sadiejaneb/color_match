import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_manager.dart';
import 'home.dart';
import 'gameplay_design.dart';
import 'matches_model.dart';
import 'preview_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AudioManager.playOrResumeMusic(); // Move music playback start here
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AudioManager.stopMusic(); // Optionally stop music when app is closed
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioManager.pauseMusic();
    } else if (state == AppLifecycleState.resumed) {
      AudioManager.resumeMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomePage(),
      routes: {
        '/gameplay': (context) => MultiProvider(
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
