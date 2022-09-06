import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthMethods {
  final String phoneNumber;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext context;

  FirebaseAuthMethods({@required this.phoneNumber, @required this.context});

  phoneSignin() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (credential) async {
        _auth.signInWithCredential(credential);
        Fluttertoast.showToast(msg: 'Verified successfully!');
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      },
      codeSent: (verificationId, resendToken) {},
      codeAutoRetrievalTimeout: (value) {},
    );
  }
}
