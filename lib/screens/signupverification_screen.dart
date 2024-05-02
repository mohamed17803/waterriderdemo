// Import necessary packages
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Ensure this import path is correct

class SignUpVerificationScreen extends StatelessWidget {
  const SignUpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color to blue as in the image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon( // Ship wheel icon similar to that in the image
              Icons.anchor,
              color: Colors.white,
              size: 100.0,
            ),

            // Text displaying "Sign up completed"
            const Text(
              'Sign up completed',
              style: TextStyle(
                fontFamily: 'Pacifico', // Apply Pacifico font as requested
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20.0), // Provide spacing between elements

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  // Navigate to LoginScreen when button is pressed
                );
              }, // Button text as seen in the image

              style : ElevatedButton.styleFrom(foregroundColor: Colors.blue, backgroundColor: Colors.white ) ,

              child:
              const Text('Go to Login Page'),





            ),
          ],
        ),
      ),
    );
  }
}