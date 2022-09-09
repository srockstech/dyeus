import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the app!',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
        ),
      ),
    );
  }
}
