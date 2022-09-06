import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/dyeus_logo.jpg', height: 20),
      ),
    );
  }
}
