

// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore
// This file contains the UI and logic for the user login screen.

// Importing necessary Flutter and Firebase packages.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waterriderdemo/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

// LoginScreen is a StatelessWidget that builds the login interface.
class LoginScreen extends StatelessWidget {
  // Constructor with a key to initialize the superclass properties.
  LoginScreen({super.key});

  // GlobalKey to uniquely identify the Form widget and allow form validation.
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers to manage the text input for email and password.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to handle user login using Firebase Authentication.
  void _login(BuildContext context) async {
    // Reference to the Navigator state to manage navigation.
    final navigator = Navigator.of(context);

    // Trigger validation of each form field.
    if (_formKey.currentState!.validate()) {
      try {
        // Sign in with email and password using Firebase Authentication.
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Navigate to the HomeScreen if the widget is still mounted.
        if (navigator.mounted) {
          navigator.pushReplacementNamed('/home');
        }
      } on FirebaseAuthException catch (e) {
        // Display an error message if login fails and the widget is still mounted.
        if (navigator.mounted) {
          ScaffoldMessenger.of(navigator.context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An error occurred')),
          );
        }
      }
    }
  }

  // The build method describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure for the login screen.
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Container for the background image.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center widget to center the login form on the screen.
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey, // Assign the GlobalKey to the Form widget.
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // App title text.
                      const Text(
                        'Water Rider',
                        style: TextStyle(
                          fontSize: 65.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50.0),
                      // Email input field with validation.
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      // Password input field with validation.
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      // Login button that triggers the _login method.
                      ElevatedButton(
                        onPressed: () => _login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text('Login'),
                      ),
                    const SizedBox(height: 40.0),
                    // Social media login options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 45.0,
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            // TODO: Implement Facebook login functionality
                          },
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 45.0,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            // TODO: Implement Google login functionality
                          },
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.twitter,
                            size: 45.0,
                          ),
                          color: Colors.cyan,
                          onPressed: () {
                            // TODO: Implement Twitter login functionality
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    const SizedBox(height: 80.0),
                    // Sign up button
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 43.0,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          )],

      ),
    );
  }
}
