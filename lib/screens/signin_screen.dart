import 'package:dyeus/components/input_text_field.dart';
import 'package:dyeus/components/rounded_button.dart';
import 'package:dyeus/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'otp_verification.dart';

class SignInScreen extends StatefulWidget {
  final Function onTap;

  SignInScreen({@required this.onTap});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String phoneNumber;
  bool showSpinner = false;
  bool hiddenPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TextStyle headingTextStyle = TextStyle(
        color: kFontColor,
        fontWeight: FontWeight.bold,
        fontSize: screenHeight * 0.035);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Text(
              'Welcome Back!!',
              style: GoogleFonts.lora(
                textStyle: headingTextStyle,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Text(
              '\nPlease login with your phone number.',
              style:
                  TextStyle(color: kFontColor, fontSize: screenHeight * 0.019),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            InputTextField(
              prefixIcon: Container(
                width: screenHeight * 0.105,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenHeight * 0.007,
                    ),
                    Image.asset(
                      'images/indian-flag.png',
                      height: screenHeight * 0.025,
                    ),
                    SizedBox(
                      width: screenHeight * 0.005,
                    ),
                    Text(
                      '+91',
                      style: TextStyle(
                          color: kHintTextColor,
                          fontSize: screenHeight * 0.02,
                          height: screenHeight * 0.0013),
                    ),
                    SizedBox(
                      width: screenHeight * 0.005,
                    ),
                    Container(
                      height: screenHeight * 0.035,
                      width: screenHeight * 0.001,
                      color: kHintTextColor,
                    ),
                  ],
                ),
              ),
              screenHeight: screenHeight,
              keyboardType: TextInputType.phone,
              hintText: 'Phone Number',
              cursorColor: kFontColor,
              textColor: kFontColor,
              hintTextColor: kHintTextColor,
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            RoundedButton(
              color: kGreen,
              shadowColor: Color.fromRGBO(153, 153, 153, 0.1),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.02,
                  letterSpacing: screenHeight * 0.0005,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OTPVerification(phoneNumber);
                }));
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.012,
                    child: Divider(
                      height: 0,
                      color: kBorderColor,
                      thickness: screenHeight * 0.001,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.01),
                  child: Text(
                    'OR',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.021),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.012,
                    child: Divider(
                      height: 0,
                      color: kBorderColor,
                      thickness: screenHeight * 0.001,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.022,
            ),
            RoundedButton(
              bordered: true,
              color: kLightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/metamask_logo.png',
                    width: screenHeight * 0.027,
                  ),
                  Text(
                    '  Connect to',
                    style: TextStyle(color: kFontColor),
                  ),
                  Text(
                    ' Metamask',
                    style: TextStyle(
                        color: kFontColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            RoundedButton(
              bordered: true,
              color: kLightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/google_logo.png',
                    width: screenHeight * 0.025,
                  ),
                  Text(
                    '  Connect to',
                    style: TextStyle(color: kFontColor),
                  ),
                  Text(
                    ' Google',
                    style: TextStyle(
                        color: kFontColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            RoundedButton(
              color: kAppleBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/apple_logo.png',
                    width: screenHeight * 0.027,
                  ),
                  Text(
                    '  Connect to',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    ' Apple',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account?',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: kFontColor),
                ),
                GestureDetector(
                  child: Text(
                    ' SignUp',
                    style:
                        TextStyle(color: kGreen, fontWeight: FontWeight.bold),
                  ),
                  onTap: widget.onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
