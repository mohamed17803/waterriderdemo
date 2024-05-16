import 'package:flutter/material.dart';
import 'login_screen.dart'; // Ensure this import path is correct

class SignUpVerificationScreen extends StatelessWidget {
  const SignUpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00B4DA), // Set background color to #00B4DA
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset( // Ship wheel logo as in the image
              'images/water_rider_logo.png', // Replace with your actual asset path
              width: 400.0,
              height: 400.0,
            ),

            // Text displaying "Sign up completed"
            const Text(
              'Sign up completed ',
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
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  // Navigate to LoginScreen when button is pressed
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, // Button text color
                backgroundColor: Colors.white, // Button background color
              ),
              child: const Text(
                'Go to Login Page',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
