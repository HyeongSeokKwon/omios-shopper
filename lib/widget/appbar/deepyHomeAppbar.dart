import 'package:cloth_collection/page/cart.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class DeepyHomeAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      //automaticallyImplyLeading: true,
      toolbarHeight: 100 * Scale.height,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Container(
                width: 80 * Scale.width,
                height: 70 * Scale.width,
                child: SvgPicture.asset(
                  "assets/images/svg/mainLogo.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 10 * Scale.width),
              Flexible(
                child: Container(
                  height: 45 * Scale.height,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 10 * Scale.width),
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey[500],
                        ),
                        SizedBox(width: 5 * Scale.width),
                        Text("검색어를 입력하세요",
                            style: textStyle(Colors.grey[500]!, FontWeight.w600,
                                "NotoSansKR", 14.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: width * 0.053),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Vibrate.feedback(VIBRATETYPE);
                },
                child: SvgPicture.asset("assets/images/svg/alarm.svg",
                    width: 26 * Scale.width, height: 26 * Scale.width),
              ),
              SizedBox(width: 13 * Scale.width),
              GestureDetector(
                onTap: () {
                  Vibrate.feedback(VIBRATETYPE);
                  Get.to(() => Cart());
                },
                child: SvgPicture.asset("assets/images/svg/cart.svg",
                    width: 26 * Scale.width, height: 26 * Scale.width),
              ),
            ],
          ),
        ),
      ],
      backgroundColor: Colors.white,
    );
  }

  // Widget _searchArea() {
  //   return
  // }
}
