import 'package:dyeus/constants.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.09),
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: screenHeight * 0.025,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 0.1)),
                        border: Border.all(
                          color: kBorderColor,
                        ),
                      ),
                      height: screenHeight * 0.055,
                      width: screenHeight * 0.2,
                      child: TabBar(
                        splashFactory: NoSplash.splashFactory,
                        splashBorderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 0.1)),
                        indicator: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 0.1)),
                        ),
                        labelColor: kFontColor,
                        unselectedLabelColor: kFontColor,
                        tabs: [
                          Tab(
                            text: 'Signin',
                          ),
                          Tab(
                            text: 'Signup',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LoginScreen(),
                      RegistrationScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
