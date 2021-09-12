import 'dart:ui';

import 'package:flutter/material.dart';

const MAINCOLOR = Color.fromRGBO(176, 140, 217, 100);

TextStyle textstyle(
    Color color, FontWeight fontWeight, var fontFamily, var fontSize) {
  return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      fontSize: fontSize);
}
