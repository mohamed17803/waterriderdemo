import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waterriderdemo/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> _login(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (navigator.mounted) {
          navigator.pushReplacementNamed('/home');
        }
      } on FirebaseAuthException catch (e) {
        if (navigator.mounted) {
          String errorMessage = 'An error occurred';
          if (e.code == 'user-not-found' || e.code == 'wrong-password') {
            errorMessage = 'Wrong Password or Email Address. Try Again.';
          }
          ScaffoldMessenger.of(navigator.context).showSnackBar(
            SnackBar(content: Text(errorMessage, style: const TextStyle(color: Colors.red))),
          );
        }
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      if (navigator.mounted) {
        navigator.pushReplacementNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (navigator.mounted) {
        String errorMessage = 'An error occurred';
        if (e.code == 'account-exists-with-different-credential') {
          errorMessage = 'Account exists with different credentials';
        } else if (e.code == 'invalid-credential') {
          errorMessage = 'Invalid credentials';
        }
        ScaffoldMessenger.of(navigator.context).showSnackBar(
          SnackBar(content: Text(errorMessage, style: const TextStyle(color: Colors.red))),
        );
      }
    }
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email Address',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Water Rider',
                        style: TextStyle(
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Color(0xFF00B4DA),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50.0),
                      _buildEmailField(),
                      const SizedBox(height: 20.0),
                      _buildPasswordField(),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => _login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.facebook,
                              size: 45.0,
                            ),
                            color: Colors.blue,
                            onPressed: () async {
                              await _signInWithFacebook(context);
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
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 43.0,
                            fontFamily: "Pacifico",
                            color: Colors.white,
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
          ),
        ],
      ),
    );
  }
}
