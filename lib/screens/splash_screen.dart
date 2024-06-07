

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async'; // Import async to use Timer
import 'dart:math' as math;
import 'cubit/location_cubit.dart';
import 'login_screen.dart'; // Ensure this path is correct

// Define the StatefulWidget for the splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Define the State class that goes with SplashScreen
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Declare an AnimationController for the rotation
  late AnimationController _controller;

  static Future<bool> getLocation(BuildContext context,{bool determineToMap = false})async{
    LocationCubit locationCubit = BlocProvider.of(context,listen: false);
    bool? getLocation = await locationCubit.getGeoLocation(context,determineToMap: false );
    if(getLocation == true){
      print("truee");
      return true;
    }else{
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController with a 5-second duration for the spin
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward(); // Start the animation forward only once
    getLocation(context);
    // Set a timer to navigate to the LoginScreen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    });

  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use AnimatedBuilder to rebuild the widget on every animation tick
    return Container(
      color: const Color(0xFF00B4DA), // Set the background color to blue
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          // Rotate the logo using a Transform widget
          return Transform.rotate(
            // Multiply the controller value by 2 * pi to complete a full rotation
            angle: _controller.value * 2.0 * math.pi,
            child: child,
          );
        },
        // The child is now outside the builder method
        child: Center(
          child: Image.asset('images/water_rider_logo.png'), // Replace with your asset's path
        ),
      ),
    );
  }
}
