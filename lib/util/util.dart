import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

const MAINCOLOR = const Color(0xffec5363);
const VIBRATETYPE = FeedbackType.light;

late bool canVibrate;

class Scale {
  static late double width;
  static late double height;

  static void setScale(BuildContext context) {
    width = MediaQuery.of(context).size.width / 414;
    height = MediaQuery.of(context).size.height / 896;
  }
}

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
    fontSize: fontSize * Scale.height,
  );
}
