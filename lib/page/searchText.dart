import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchText extends StatefulWidget {
  @override
  _SearchTextState createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Container(
                width: 50,
                color: Colors.red,
                child: SvgPicture.asset("assets/images/svg/search.svg"),
              ),
              Container(
                width: 50,
                color: Colors.red,
                child: SvgPicture.asset("assets/images/svg/alarm.svg"),
              ),
              Container(
                width: 50,
                color: Colors.red,
                child:
                    SvgPicture.asset("assets/images/svg/shopping_basket.svg"),
              ),
            ],
          ),
        ));
  }
}
