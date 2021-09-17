import 'package:cloth_collection/page/searchText.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppbar extends StatelessWidget with PreferredSizeWidget {
  final FocusNode focusNode;

  MainAppbar(this.focusNode);
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
      actions: [
        GestureDetector(
          child: Image.asset("assets/images/search.png"),
          onTap: () {
            Get.to(SearchText());
          },
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
}
