import 'package:color_match/game_progression.dart';
import 'package:color_match/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_manager.dart';
import 'home.dart';
import 'gameplay_design.dart';
import 'matches_model.dart';
import 'preview_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Loading settings...");
  await AudioManager.loadSettings();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late MatchesModel matchesModel;
  late PreviewModel previewModel;
  late GameProgress gameProgress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AudioManager.playOrResumeMusic(); 

    // Initialize models
    matchesModel = MatchesModel();
    previewModel = PreviewModel();
    gameProgress = GameProgress(matchesModel, previewModel);
  }

  @override
  void dispose() {
    // Dispose models when app is closed
    matchesModel.dispose();
    previewModel.dispose();
    gameProgress.dispose();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PreviewModel>.value(
          value: previewModel,
        ),
        ChangeNotifierProvider<GameProgress>.value(
          value: gameProgress,
        ),
        ChangeNotifierProvider<MatchesModel>.value(
          value: matchesModel,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: HomePage(),
        routes: {
          '/gameplay': (context) => const GameplayDesign(),
          '/tutorial': (context) => TutorialPage(),
        },
      ),
    );
  }
}
