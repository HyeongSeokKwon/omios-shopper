import 'package:flutter/material.dart';

import '../../../util/util.dart';

class MainText extends StatelessWidget {
  const MainText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 110 * Scale.height, left: 22 * Scale.width),
      child: Text("지금 당신의 쇼핑몰을\n책임지는 시간\nOMIOS",
          style: textStyle(
              const Color(0xff333333), FontWeight.w700, "NotoSansKR", 26.0)),
    );
  }
}
