import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main(){
  runApp(const PulseTrackApp());
}

class PulseTrackApp extends StatelessWidget{
  const PulseTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PulseTrack",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}