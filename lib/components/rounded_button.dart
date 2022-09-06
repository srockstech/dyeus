import 'package:dyeus/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final Function onPressed;
  final Color shadowColor;
  final bool bordered;

  RoundedButton(
      {this.shadowColor = Colors.transparent,
      @required this.color,
      @required this.child,
      @required this.onPressed,
      this.bordered = false});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: (bordered)
            ? BorderSide(
                color: kBorderColor,
              )
            : BorderSide(
                color: Colors.transparent,
              ),
        padding: EdgeInsets.all(screenHeight * 0.018),
        backgroundColor: color,
        shadowColor: shadowColor,
        elevation: screenHeight * 0.01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenHeight * 0.04)),
        ),
      ),
      child: child,
    );
  }
}
