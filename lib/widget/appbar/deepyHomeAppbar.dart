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
      toolbarHeight: 90 * Scale.height,
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
                child: Text(
                  "Omios",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSansKR",
                      fontSize: 23,
                      fontWeight: FontWeight.w900),
                ),
                color: Colors.white,
              ),
              SizedBox(width: 10 * Scale.width),
              Container(
                  width: 220 * Scale.width,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 5),
                      Text("검색어를 입력하세요",
                          style: textStyle(Colors.grey[500]!, FontWeight.w600,
                              "NotoSansKR", 14.0)),
                    ],
                  )),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: width * 0.053),
          child: Row(
            children: [
              // GestureDetector(
              //   child: SvgPicture.asset(
              //     "assets/images/svg/search.svg",
              //   ),
              //   onTap: () {
              //     Vibrate.feedback(VIBRATETYPE);
              //     Get.to(() => SearchText());
              //   },
              // ),
              GestureDetector(
                onTap: () {
                  Vibrate.feedback(VIBRATETYPE);
                },
                child: SvgPicture.asset("assets/images/svg/alarm.svg"),
              ),
              SizedBox(width: width * 0.053),
              GestureDetector(
                onTap: () {
                  Vibrate.feedback(VIBRATETYPE);
                  Get.to(() => Cart());
                },
                child: SvgPicture.asset("assets/images/svg/cart.svg"),
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
