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

  Future<bool> verifyManuallyEnteredOtp() async {
    bool success = false;
    PhoneAuthCredential credential;
    try {
      credential = PhoneAuthProvider.credential(
        verificationId: FirebaseAuthMethods.codeVerificationId,
        smsCode: otpController.text.trim(),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    try {
      final user = await _auth.signInWithCredential(credential);
      if (user != null) {
        Fluttertoast.showToast(msg: 'Verification Successful!');
        success = true;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return success;
  }

  Future<bool> phoneSignin(String phoneNumber) async {
    String otp;
    bool success = false;
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (credential) async {
        try {
          final user = await _auth.signInWithCredential(credential);
          if (user != null) {
            otp = credential.smsCode;
            otpCode = (otp) {};
            Fluttertoast.showToast(msg: 'Verified Successfully!');
            success = true;
          }
        } catch (e) {
          Fluttertoast.showToast(msg: e);
        }
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      },
      codeSent: (verificationId, resendToken) async {
        codeVerificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (value) {},
    );
    return success;
  }
}
