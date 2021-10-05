import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

class ImageSearchAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Container(
        child: Text("이미지 검색",
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 20.0)),
      ),
    );
  }
}
