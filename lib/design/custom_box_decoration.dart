import 'package:flutter/material.dart';

class CustomBoxDecoration {
  static BoxDecoration bottomLeftRoundCornerShadow(double screenHeight) {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black87,
          offset: Offset(screenHeight * 0.02, screenHeight * 0.005),
          blurRadius: screenHeight * 0.025,
        ),
      ],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(screenHeight * 0.1, screenHeight * 0.07),
      ),
    );
  }

  static BoxDecoration topRightRoundCornerShadow(double screenHeight) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.elliptical(screenHeight * 0.07, screenHeight * 0.065),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black87,
          offset: Offset(screenHeight * -0.028, screenHeight * 0.007),
          spreadRadius: screenHeight * 0.007,
          blurRadius: screenHeight * 0.03,
        ),
      ],
      color: Colors.white,
    );
  }
}
