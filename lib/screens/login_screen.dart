import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waterriderdemo/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Water Rider',
                      style: TextStyle(
                        fontSize: 65.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico ',
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 50.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email or Phone number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {},
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
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 45.0,
                          ),
                          color: Colors.red,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.twitter,
                            size: 45.0,
                          ),
                          color: Colors.cyan,
                          onPressed: () {},
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
        ],
      ),
    );
  }
}
