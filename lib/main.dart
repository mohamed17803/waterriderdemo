// Importing necessary Flutter material components.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waterriderdemo/screens/signupverification_screen.dart';
// Importing screens used in the application.
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/signup_screen.dart';
import 'firebase_options.dart';
// Added the Authentication
// The main function is the entry point of the Flutter application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const SplashScreen(), // Ensure SplashScreen is defined in splash_screen.dart
      // Named routes allow for easy navigation throughout the app.
      routes: {
        // Defining the route for the Login screen.
        '/login': (context) => const LoginScreen(),
        // Defining the route for the Sign-up screen.
        '/signup': (context) => const SignUpScreen(),
        // Defining the route for the Sign-up Verification screen.
        '/signupVerification': (context) => const SignUpVerificationScreen(),
      },
      // The onGenerateRoute function is called when navigating to a named route.
      onGenerateRoute: (settings) {
        // If the route name is '/signup', navigate to the SignUpScreen.
        if (settings.name == '/signup') {
          return MaterialPageRoute(
            builder: (context) {
              return  SignUpScreen(onSignUpComplete: () {
                // After signing up, navigate to the SignUpVerificationScreen.
                Navigator.pushReplacementNamed(context, '/signupVerification');
              });
            },
          );
        }
        // Return null for any other routes not defined here.
        return null;
      },
      // Setting debugShowCheckedModeBanner to false removes the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
