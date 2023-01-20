import 'package:flutter/material.dart';

double screenWidth, screenHeight;

Widget margin(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  screenWidth = size.width;
  screenHeight = size.height;
  return SizedBox(height: (screenHeight*0.005 + screenWidth*0.005)/2);
}

Widget freeArea() {
  return SizedBox(width: 0, height: 0);
}