import 'package:flutter/material.dart';
import 'package:waterriderdemo/core/navigation_constants.dart';
import 'package:waterriderdemo/screens/passenger_screen.dart';

class PreHomeScreen extends StatelessWidget {
  const PreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00B4DA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'Select User Type',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  navigateTo(context, const PassengerScreen());
                },
                icon: const Icon(Icons.person, color: Colors.black),
                label: const Text('Passenger', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/driver');
                },
                icon: const Icon(Icons.directions_car, color: Colors.black),
                label: const Text('Driver', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
