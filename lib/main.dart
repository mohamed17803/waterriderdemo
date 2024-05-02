// ignore_for_file: unused_import

// Importing necessary Flutter material components.
import 'package:flutter/material.dart';
// Importing the sign-up screen used in the application.
import 'screens/signup_screen.dart';

// The main function is the entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  // Constructor for MyApp with a key parameter.
  const MyApp({super.key});

  @override
  // The build method describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    return MaterialApp(
      // The title of the application, shown in the task manager.
      title: 'Water Riders',
      // ThemeData allows defining the theme of the application.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Setting a custom font for the entire application.
        fontFamily: 'Pacifico',
      ),
      // The initial route that the app will display on startup.
      home: const SignUpScreen(), // Set SignUpScreen as the home route
    );
  }
}
