import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CategoryAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: const Color(0xffffffff),
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: width * 0.3,
      leading: Container(
        child: Center(
          child: Row(
            children: [
              SizedBox(width: width * 0.053),
              Text("카테고리",
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 22.0)),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: width * 0.053),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Vibrate.feedback(VIBRATETYPE);
                },
                child: SvgPicture.asset("assets/images/svg/search.svg"),
              ),
              SizedBox(width: width * 0.053),
              GestureDetector(
                onTap: () {
                  Vibrate.feedback(VIBRATETYPE);
                },
                child: SvgPicture.asset("assets/images/svg/cart.svg"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
