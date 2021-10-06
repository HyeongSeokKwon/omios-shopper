import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

class MypageAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: width * 0.3,
      leading: Container(
        child: Center(
          child: Row(
            children: [
              SizedBox(width: width * 0.053),
              Text("마이페이지",
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 22.0)),
            ],
          ),
        ),
      ),
    );
  }
}
