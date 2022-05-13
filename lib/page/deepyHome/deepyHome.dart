import 'package:cloth_collection/controller/homeController.dart';
import 'package:cloth_collection/page/deepyHome/HomeArea.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeepyHome extends StatefulWidget {
  DeepyHome();
  @override
  _DeepyHomeState createState() => _DeepyHomeState();
}

class _DeepyHomeState extends State<DeepyHome>
    with SingleTickerProviderStateMixin {
  late TabController categoryTabController;
  HomeController homeController = Get.put<HomeController>(HomeController());
  List<Tab> tabList = [];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    categoryTabController = TabController(length: 6, vsync: this);
    tabList.add(
      Tab(
        text: "홈",
      ),
    );
    tabList.add(
      Tab(text: "당일발송"),
    );
    tabList.add(
      Tab(text: "타임세일"),
    );
    tabList.add(
      Tab(text: "Best"),
    );
    tabList.add(
      Tab(text: "신상품"),
    );
    tabList.add(
      Tab(text: "이벤트"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        child: Column(
          children: [
            categoryBarArea(),
            Expanded(
              child: TabBarView(
                controller: categoryTabController,
                children: [
                  HomeArea(
                    tabController: categoryTabController,
                  ),
                  HomeArea(
                    tabController: categoryTabController,
                  ),
                  HomeArea(
                    tabController: categoryTabController,
                  ),
                  HomeArea(
                    tabController: categoryTabController,
                  ),
                  HomeArea(
                    tabController: categoryTabController,
                  ),
                  HomeArea(
                    tabController: categoryTabController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget a() {
    return Column();
  }

  Widget b() {
    return Column();
  }

  Widget c() {
    return Column();
  }

  Widget d() {
    return Column();
  }

  Widget e() {
    return Column();
  }

  Widget categoryBarArea() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 40 * Scale.height,
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 5 * Scale.width),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.5),
            insets: EdgeInsets.symmetric(horizontal: 0.0)),
        labelStyle:
            textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 14.0),
        unselectedLabelColor: const Color(0xffcccccc),
        unselectedLabelStyle:
            textStyle(Colors.black, FontWeight.w400, "NotoSansKR", 14.0),
        tabs: tabList,
        controller: categoryTabController,
      ),
    );
  }
}
