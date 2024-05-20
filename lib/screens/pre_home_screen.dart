import 'package:flutter/material.dart';

class pre_home_screen extends StatelessWidget {
  const pre_home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select User Type'),
      ),
      body: Container(
        color: Colors.blue, // Blue background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Handle passenger button tap
                  Navigator.pushNamed(context, '/passenger');
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text('Passenger', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle driver button tap
                  Navigator.pushNamed(context, '/driver');
                },
                icon: const Icon(Icons.directions_car, color: Colors.white),
                label: const Text('Driver', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
