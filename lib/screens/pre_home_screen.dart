import 'package:flutter/material.dart';

class pre_home_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
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
                icon: Icon(Icons.person, color: Colors.white),
                label: Text('Passenger', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle driver button tap
                  Navigator.pushNamed(context, '/driver');
                },
                icon: Icon(Icons.directions_car, color: Colors.white),
                label: Text('Driver', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
