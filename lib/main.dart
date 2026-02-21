//App Entry Point

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'navigation/main_navigation.dart';

void main(){ //starting point
  runApp(const PulseTrackApp()); // which widget is the root of the app.
}

class PulseTrackApp extends StatelessWidget{ //does not change
  const PulseTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PulseTrack",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,//centralized theme
      home: const MainNavigation(),
    );
  }
}