// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Riders',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Pacifico', // Apply 'Pacifico' font as the default for the app
      ),
      // Set the initial route to SplashScreen
      home: SplashScreen(), // Ensure SplashScreen is defined in splash_screen.dart
    );
  }
}
