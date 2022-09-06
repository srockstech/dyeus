import 'package:dyeus/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_button.dart';
import '../constants.dart';

class OTPVerification extends StatefulWidget {
  String phoneNumber;

  OTPVerification(this.phoneNumber);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int resendOTPGap;
  String otp;
  String buttonText;

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

  @override
  void initState() {
    buttonText = 'Resend OTP';
    FirebaseAuthMethods firebaseAuthMethod =
        FirebaseAuthMethods(phoneNumber: widget.phoneNumber, context: context);
    startResendOTPTimer();
    super.initState();
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
                'A five digit code has been sent to +91 ${widget.phoneNumber}',
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
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.14,
              ),
              TextField(
                maxLength: 5,
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                  fontWeight: FontWeight.w600,
                  letterSpacing: screenHeight * 0.063,
                ),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.001,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.length == 5) {
                    setState(() {
                      buttonText = 'Done';
                    });
                  } else {
                    setState(() {
                      buttonText = 'Resend OTP';
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: screenHeight * 0.07,
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: screenHeight * 0.07,
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: screenHeight * 0.07,
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: screenHeight * 0.07,
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: screenHeight * 0.07,
                  ),
                ],
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
                onPressed: () {},
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
