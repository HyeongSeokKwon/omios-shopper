import 'package:cloth_collection/page/searchText.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DeepyHomeAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Container(
        child: Text("Deepy",
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 20.0)),
      ),
      titleSpacing: width * 0.053,
      actions: <Widget>[
        Row(
          children: [
            GestureDetector(
              child: SvgPicture.asset(
                "assets/images/svg/search.svg",
              ),
              onTap: () {
                Get.to(() => SearchText());
              },
            ),
            SizedBox(width: 13),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/images/svg/alarm.svg"),
            ),
            SizedBox(width: 13),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/images/svg/shopping_basket.svg"),
            ),
          ],
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
