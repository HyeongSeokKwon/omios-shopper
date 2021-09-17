import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

AppBar mainAppbar(double width, double height) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      child: Row(
        children: [
          Text("Deepy",
              style: textStyle(const Color(0xff333333), FontWeight.w700,
                  "NotoSansKR", 20.0)),
        ],
      ),
    ),
    titleSpacing: width * 0.053,
    actions: [
      GestureDetector(
        onTap: () {},
        child: Image.asset("assets/images/search.png"),
      ),
      GestureDetector(
        onTap: () {},
        child: Image.asset("assets/images/alarm.png"),
      ),
      GestureDetector(
        onTap: () {},
        child: Image.asset("assets/images/shopping_basket.png"),
      )
    ],
    backgroundColor: Colors.white,
  );
}
