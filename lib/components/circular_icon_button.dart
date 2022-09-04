import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    @required this.screenHeight,
    this.icon,
    this.onPressed,
    this.height,
    this.width,
  });

  final double screenHeight;
  final Widget icon;
  final Function onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.1),
        border: Border.all(color: Colors.grey, width: screenHeight * 0.001),
      ),
      margin: EdgeInsets.all(screenHeight * 0.01),
      height: (height == null) ? screenHeight * 0.055 : height,
      width: (width == null) ? screenHeight * 0.055 : width,
      child: IconButton(
        icon: icon,
        iconSize: screenHeight * 0.03,
        color: kBlack,
        onPressed: onPressed,
      ),
    );
  }
}
