  // ignore_for_file: file_names

  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  class LoginScreen extends StatelessWidget {
    const LoginScreen({super.key});

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
                      // Modified title font and size
                      const Text(
                        'Water Rider', // Text to be displayed
                        style: TextStyle(
                          fontSize: 65.0, // Increased font size
                          fontWeight: FontWeight.bold, // Set font weight to bold
                          fontFamily: 'Pacifico ', // Use the custom font 'Pacifico'
                          color: Colors.blueAccent, // Set the text color to blue
                        ),
                        textAlign: TextAlign.center, // Center-align the text
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
                          backgroundColor: Colors.white // Dark blue color
                        ),
                        // Login Button
                        child: const Text('Login'),

                            ) ,
  //
                      const SizedBox(height: 40.0),
                //     const Text('Login with social media:'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            // Facebook Icon Button
                            icon: const FaIcon(
                              FontAwesomeIcons.facebook,
                              size: 45.0, // Set the size of the Facebook icon
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              
                            },
                          ),
                          IconButton(
                            // Google Icon Button
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              size: 45.0, // Set the size of the Google icon
                            ),
                            color: Colors.red,
                            onPressed: () {
                            
                            },
                          ),
                          IconButton(
                            // Twitter Icon Button
                            icon: const FaIcon(
                              FontAwesomeIcons.twitter,
                              size: 45.0, // Set the size of the Twitter icon
                            ),
                            color: Colors.cyan,
                            onPressed: () {
                            
                            },
                          ),
                        ],
                      ),


                      const  SizedBox(height: 40.0,) ,
                    const SizedBox(height: 80.0,) ,
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 40.0 ,
                            color: Colors.white ,
                            decoration: TextDecoration.underline, // Underlined
                              decorationThickness: 2 ,
                            decorationColor: Colors.white
                          ),
                        ),
                        onPressed: () {},
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