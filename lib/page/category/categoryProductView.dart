import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CategoryProductView extends StatefulWidget {
  const CategoryProductView({Key? key}) : super(key: key);

  @override
  _CategoryProductViewState createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/images/svg/moveToBack.svg",
                  width: 10 * Scale.width,
                  height: 20 * Scale.height,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 14 * Scale.width),
              Text("Categoryname",
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 22.0)),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 22 * Scale.width),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Vibrate.feedback(VIBRATETYPE);
                    },
                    child: SvgPicture.asset("assets/images/svg/search.svg"),
                  ),
                  SizedBox(width: 22 * Scale.width),
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0),
                      insets: EdgeInsets.symmetric(horizontal: 16.0)),
                  tabs: [
                    Tab(
                      text: "전체",
                    ),
                    Tab(
                      text: "플랫 / 로퍼",
                    ),
                    Tab(
                      text: "힐 / 펌프스",
                    ),
                    Tab(
                      text: "전체",
                    ),
                    Tab(
                      text: "전체",
                    ),
                    Tab(
                      text: "전체",
                    ),
                    Tab(
                      text: "전체",
                    ),
                  ],
                  labelStyle: textStyle(const Color(0xff333333),
                      FontWeight.w400, "NotoSansKR", 16.0),
                  unselectedLabelStyle: textStyle(const Color(0xffcccccc),
                      FontWeight.w400, "NotoSansKR", 16.0),
                ),
                ListView.builder(
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 20,
                      );
                    })
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
