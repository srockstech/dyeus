import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext context;
  static String codeVerificationId;
  final TextEditingController otpController;
  Function(String) otpCode;

  FirebaseAuthMethods(
      {@required this.context, @required this.otpController, this.otpCode});

  Future<UserCredential> phoneSignIn(String phoneNumber) async {
    String otp;
    UserCredential userCredential;
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (credential) async {
        try {
          final user = await _auth.signInWithCredential(credential);
          if (_auth.currentUser != null) {
            otp = credential.smsCode;
            otpCode = (otp) {};
          }
        } catch (e) {
          Fluttertoast.showToast(msg: e);
        }
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      },
      // autoRetrievedSmsCodeForTesting: '987654',
      codeSent: (verificationId, resendToken) async {
        PhoneAuthCredential credential;
        try {
          credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otpController.text.trim(),
          );
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString() + 'ok');
        }
        try {
          await _auth.signInWithCredential(credential);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
      },
      codeAutoRetrievalTimeout: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Unable to automatically read the code. Please enter it manually.'),
          ),
        );
      },
    );
    return userCredential;
  }
}
