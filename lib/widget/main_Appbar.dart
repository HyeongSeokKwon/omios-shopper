import 'package:flutter/material.dart';

Widget MainAppbar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Container(
        child: Row(
      children: [
        Text("deepy", style: TextStyle(color: Colors.black)),
      ],
    )),
    backgroundColor: Colors.white,
  );
}
