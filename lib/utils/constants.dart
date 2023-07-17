import 'package:flutter/material.dart';

Color? primary = const Color(0xFFeb6e4b);
Color? white = Colors.white;
Color? black = Colors.black;
Color? grey = const Color(0xFFf2f2f2);

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
