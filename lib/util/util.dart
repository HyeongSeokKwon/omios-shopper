import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const MAINCOLOR = Color.fromRGBO(176, 140, 217, 100);

String setPriceFormat(int price) {
  final oCcy = new NumberFormat("#,###", "ko_KR");
  return "${oCcy.format(price)}원";
}

TextStyle textStyle(
  Color color,
  FontWeight fontWeight,
  var fontFamily,
  var fontSize,
) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontStyle: FontStyle.normal,
    fontFamily: fontFamily,
    fontSize: fontSize,
  );
}
