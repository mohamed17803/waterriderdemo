import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waterriderdemo/core/navigation_constants.dart';
import 'package:waterriderdemo/screens/pre_home_screen.dart';
import 'package:waterriderdemo/screens/profile_screen.dart';
import 'package:waterriderdemo/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forget_password.dart';

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
          navigateAndRemove(context, const PreHomeScreen());
        }
      } on FirebaseAuthException catch (e) {
        if (navigator.mounted) {
          String errorMessage = 'Wrong Password or Email Address. Try Again';
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,);
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
                        'WATER RIDER',
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
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              navigateTo(context, const ForgetPasswordScreen());
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue.withOpacity(.7),
                                color: Colors.blue.withOpacity(.7),
                                fontSize: 16
                              ),
                            ),
                          )
                        ],
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
                            onPressed: ()  {},
                          ),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              size: 45.0,
                            ),
                            color: Colors.red,
                            onPressed: () async {
                              UserCredential cred = await signInWithGoogle();
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
                          navigateTo(context, const SignUpScreen());
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
