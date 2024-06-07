import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// SignUpScreen is a stateful widget
class SignUpScreen extends StatefulWidget {
  final VoidCallback? onSignUpComplete; // Callback function when sign up is complete

  const SignUpScreen({super.key, this.onSignUpComplete});

  @override
  SignUpScreenState createState() => SignUpScreenState(); // Creates the state for this widget
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final _emailController = TextEditingController(); // Controller for the email input
  final _passwordController = TextEditingController(); // Controller for the password input
  final _confirmPasswordController = TextEditingController(); // Controller for the confirm password input
  final _phoneController = TextEditingController(); // Controller for the phone number input
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _dateController = TextEditingController(); // Controller for the phone number input

  String gender = '';

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Function to handle the sign-up process
  void _onSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) { // Validate the form fields
      try {

        // final email = _emailController.text.trim(); // Get the email from the controller
        // final password = _passwordController.text.trim(); // Get the password from the controller
        // Create a new user with email and password
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ).then((value) async {
          users.doc(FirebaseAuth.instance.currentUser?.uid).set({
            'emailAddress': _emailController.text.trim(),
            'password': _passwordController.text,
            'phone': _phoneController.text,
            'gender': gender,
            'birthday': _dateController.text,
            'uid': FirebaseAuth.instance.currentUser?.uid,
          });
          if(!FirebaseAuth.instance.currentUser!.emailVerified){
            await FirebaseAuth.instance.currentUser!.sendEmailVerification();
          }
        });
        // Navigate to the sign-up verification screen if sign up is successful
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/signupVerification');
        }
      } on FirebaseAuthException catch (e) {
        // Show error message if sign up fails
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An error occurred')),
          );
        }
      }
    }
  }

  // Function to show the date picker and select the date of birth
  // Future<void> _selectDateOfBirth(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _dateOfBirth ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != _dateOfBirth) {
  //     setState(() {
  //       _dateOfBirth = picked; // Update the selected date of birth
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00B4DA), // Background color of the screen
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(color: Colors.white)), // Title of the app bar
        centerTitle: true, // Center the title
        backgroundColor: Colors.transparent, // Make the app bar background transparent
        elevation: 0, // Remove the shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the columns to take all available space
              children: <Widget>[
                // Email input field
                TextFormField(
                  controller: _emailController, // Connect the controller
                  decoration: const InputDecoration(
                    labelText: 'Email', // Label text
                    fillColor: Colors.white, // Background color of the input
                    filled: true, // Make sure the background color is applied
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email'; // Validation message for empty email
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email'; // Validation message for invalid email
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0), // Spacing between fields
                // Password input field
                TextFormField(
                  controller: _passwordController, // Connect the controller
                  obscureText: true, // Hide the text
                  decoration: const InputDecoration(
                    labelText: 'Password', // Label text
                    fillColor: Colors.white, // Background color of the input
                    filled: true, // Make sure the background color is applied
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password'; // Validation message for empty password
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0), // Spacing between fields
                // Confirm Password input field
                TextFormField(
                  controller: _confirmPasswordController, // Connect the controller
                  obscureText: true, // Hide the text
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password', // Label text
                    fillColor: Colors.white, // Background color of the input
                    filled: true, // Make sure the background color is applied
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match'; // Validation message for mismatched passwords
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0), // Spacing between fields
                // Phone Number input field
                TextFormField(
                  controller: _phoneController, // Connect the controller
                  decoration: const InputDecoration(
                    labelText: 'Phone Number', // Label text
                    fillColor: Colors.white, // Background color of the input
                    filled: true, // Make sure the background color is applied
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number'; // Validation message for empty phone number
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0), // Spacing between fields
                // Gender selection dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Gender', // Label text
                    fillColor: Colors.white, // Background color of the dropdown
                    filled: true, // Make sure the background color is applied
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  value: null, // Default value
                  onChanged: (String? newValue) {
                    gender = newValue!;
                    print("gender = $gender");
                  }, // Handle dropdown value change
                  items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value, // Value of the dropdown item
                      child: Text(value),
                      onTap: (){
                        gender = value ;
                      },// Display text
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender'; // Validation message for unselected gender
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0), // Spacing between fields
                // Date of Birth input field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth', // Label text
                    fillColor: Colors.white, // Background color of the input
                    filled: true, // Make sure the background color is applied
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  controller: _dateController, // Show the selected date of birth
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from the text field
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse ('2100-10-20')
                    ).then((value){
                      _dateController.text = DateFormat.yMMMd().format(value!);
                    });
                    //_selectDateOfBirth(context); // Show the date picker
                  },
                  validator: (value) {
                    if (_dateController.text.isEmpty) {
                      return 'Please select your date of birth'; // Validation message for unselected date of birth
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0), // Spacing before the button
                // Sign Up button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue, // Text color
                    backgroundColor: Colors.white, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20), // Button padding
                  ),
                  onPressed: () => _onSignUp(context), // Handle sign up button press
                  child: const Text('Sign Up', style: TextStyle(color: Colors.blue)), // Button text
                ),
                const SizedBox(height: 20), // Spacing before the alternative sign-up methods
                // 'or' text
                const Center(
                  child: Text(
                    'or',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20), // Spacing before the sign-up options
                // 'Sign Up With' text
                const Center(
                  child: Text(
                    'Sign Up With',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20), // Spacing before the social sign-up buttons
                // Social sign-up buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space the buttons evenly
                  children: <Widget>[
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.white), // Facebook icon
                      onPressed: () {
                        // TODO: Implement Facebook Sign Up
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white), // Google icon
                      onPressed: () {
                        // TODO: Implement Google Sign Up
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.white), // Twitter icon
                      onPressed: () {
                        // TODO: Implement Twitter Sign Up
                      },
                    ),
                  ],
                ),
                // ... Other UI elements if any ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
