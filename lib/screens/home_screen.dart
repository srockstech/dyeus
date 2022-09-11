import 'package:dyeus/components/rounded_button.dart';
import 'package:dyeus/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> showWarning() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to close the app?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('No')),
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        bool userChoice = await showWarning();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome to the app!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.03),
                ),
                SizedBox(
                  height: screenHeight * 0.2,
                ),
                RoundedButton(
                  color: Colors.deepOrange,
                  child: Text(
                    'Signout',
                    style: TextStyle(
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.02,
                      letterSpacing: screenHeight * 0.0005,
                    ),
                  ),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                    Fluttertoast.showToast(msg: 'Signed Out');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
