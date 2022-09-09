import 'package:dyeus/services/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../components/rounded_button.dart';
import '../constants.dart';
import 'home_screen.dart';

class OTPVerification extends StatefulWidget {
  final String phoneNumber;

  OTPVerification(this.phoneNumber);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int resendOTPGap;
  String otp = '';
  String buttonText;
  TextEditingController otpController;
  FirebaseAuthMethods firebaseAuthMethod;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget bottomHelperOptions(screenHeight) {
    if (buttonText == 'Done') {
      return Column(
        children: [
          Text(
            'Didn\'t receive any code?',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          GestureDetector(
            child: Text(
              'Re-send Code',
              style: TextStyle(color: kGreen, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    } else {
      return null;
    }
  }

  void startResendOTPTimer() async {
    resendOTPGap = 30;
    while (resendOTPGap != 0) {
      await Future.delayed(
        Duration(seconds: 1),
        () {},
      );
      setState(() {
        resendOTPGap--;
      });
    }
  }

  void sendAndReadOTP() {
    firebaseAuthMethod = FirebaseAuthMethods(
        context: context,
        otpController: otpController,
        otpCode: (value) {
          setState(() {
            otp = value;
          });
        });
  }

  Future<void> autoFillOTPAndVerifyUser() async {
    bool verify = await firebaseAuthMethod.phoneSignin(widget.phoneNumber);
    if (verify == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  void verifyUserFromAutoDetectedOTP() async {
    sendAndReadOTP();
    await autoFillOTPAndVerifyUser();
  }

  Future<void> verifyUserFromManuallyEnteredOTP() async {
    bool verify = await firebaseAuthMethod.verifyManuallyEnteredOtp();
    if (verify == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    buttonText = 'Resend OTP';
    otpController = TextEditingController();
    startResendOTPTimer();
    sendAndReadOTP();
    autoFillOTPAndVerifyUser();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TextStyle headingTextStyle = TextStyle(
        color: kFontColor,
        fontWeight: FontWeight.bold,
        fontSize: screenHeight * 0.035);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.025, vertical: screenHeight * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter OTP',
                style: GoogleFonts.lora(
                  textStyle: headingTextStyle,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                'A six digit code has been sent to +91 ${widget.phoneNumber}',
                style: TextStyle(
                    color: kFontColor, fontSize: screenHeight * 0.0185),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  Text(
                    'Incorrect number? ',
                    style: TextStyle(
                        color: kFontColor, fontSize: screenHeight * 0.019),
                  ),
                  GestureDetector(
                    child: Text(
                      ' Change',
                      style:
                          TextStyle(color: kGreen, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.14,
              ),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  colorBuilder: FixedColorBuilder(Colors.black),
                  textStyle: TextStyle(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                controller: otpController,
                currentCode: otp,
                onCodeChanged: (code) {
                  setState(() {
                    otp = code;
                  });
                  if (code.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      buttonText = 'Done';
                    });
                  } else {
                    setState(() {
                      buttonText = 'Resend OTP';
                    });
                  }
                },
                codeLength: 6,
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              RoundedButton(
                color: (resendOTPGap == 0 || buttonText == 'Done')
                    ? kGreen
                    : kMidGreen,
                shadowColor: (resendOTPGap == 0 || buttonText == 'Done')
                    ? Color.fromRGBO(153, 153, 153, 0.1)
                    : Color.fromRGBO(153, 153, 153, 0),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: (resendOTPGap == 0 || buttonText == 'Done')
                        ? kFontColor
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.02,
                    letterSpacing: screenHeight * 0.0005,
                  ),
                ),
                onPressed: () async {
                  if (buttonText == 'Done') {
                    await verifyUserFromManuallyEnteredOTP();
                  } else if (buttonText == 'Resend OTP' && resendOTPGap == 0) {
                    initState();
                  }
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                child: (resendOTPGap != 0)
                    ? Text(
                        'Resend OTP in ${resendOTPGap}s',
                        textAlign: TextAlign.center,
                      )
                    : bottomHelperOptions(screenHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
