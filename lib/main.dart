import 'package:dyeus/screens/loading_screen.dart';
import 'package:dyeus/screens/login_screen.dart';
import 'package:dyeus/screens/registration_screen.dart';
import 'package:dyeus/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(FlashChat());
}

class FlashChat extends StatefulWidget {
  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  bool firebaseInitializationComplete = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kGreen,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            primary: kBlack,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            primary: kBlack,
          ),
        ),
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
        splashFactory: InkRipple.splashFactory,
        splashColor: kLightGreen,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: kBlack,
          tertiary: Colors.white,
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
