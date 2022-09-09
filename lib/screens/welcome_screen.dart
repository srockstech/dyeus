import 'package:dyeus/constants.dart';
import 'package:flutter/material.dart';

import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.09),
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
                      borderRadius:
                          BorderRadius.all(Radius.circular(screenHeight * 0.1)),
                      border: Border.all(
                        color: kBorderColor,
                      ),
                    ),
                    height: screenHeight * 0.055,
                    width: screenHeight * 0.2,
                    child: TabBar(
                      controller: _tabController,
                      splashFactory: NoSplash.splashFactory,
                      splashBorderRadius:
                          BorderRadius.all(Radius.circular(screenHeight * 0.1)),
                      indicator: BoxDecoration(
                        color: kGreen,
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 0.1)),
                      ),
                      labelColor: kFontColor,
                      unselectedLabelColor: kFontColor,
                      tabs: [
                        Tab(
                          text: 'SignIn',
                        ),
                        Tab(
                          text: 'SignUp',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SignInScreen(
                      onTap: () {
                        _tabController.animateTo(1);
                      },
                    ),
                    SignUpScreen(
                      onTap: () {
                        _tabController.animateTo(0);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
