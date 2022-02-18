import 'package:cloth_collection/controller/homeController.dart';
import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/page/SearchImage.dart';
import 'package:cloth_collection/page/category/category.dart';
import 'package:cloth_collection/page/deepyHome/deepyHome.dart';
import 'package:cloth_collection/page/myPage.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/appbar/category_Appbar.dart';
import 'package:cloth_collection/widget/appbar/chatting_Appbar.dart';
import 'package:cloth_collection/widget/appbar/deepyHomeAppbar.dart';
import 'package:cloth_collection/widget/appbar/imageSearch_Appbar.dart';
import 'package:cloth_collection/widget/appbar/myPage_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'chatting/chatting.dart';

const int HOME = 0;
const int CATEGORY = 1;
const int LIKE = 2;
const int CHAT = 3;
const int MYPAGE = 4;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  HomeController homeController = HomeController();
  FocusNode focusNode = FocusNode();
  late List<Widget> selectedPage;

  List<PreferredSizeWidget> appBar = [
    DeepyHomeAppbar(),
    CategoryAppbar(),
    ChattingAppbar(),
    ImageSearchAppbar(),
    MypageAppbar(),
  ];

  @override
  void initState() {
    super.initState();
    DBHelper().db;
    homeController.scrollController = ScrollController();
    selectedPage = [
      DeepyHome(homeController.scrollController),
      Category(),
      Chatting(),
      Chatting(),
      MyPage(),
    ];
  }

  @override
  void dispose() {
    focusNode.dispose();
    homeController.scrollController.dispose();
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: GetBuilder<HomeController>(
            init: homeController,
            builder: (controller) {
              return appBar[homeController.currentIndex];
            }),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<HomeController>(
          init: homeController,
          builder: (controller) {
            return selectedPage[homeController.currentIndex];
          }),
      bottomNavigationBar: _buildBottomNaviagationBar(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: const Color(0xffec5363),
      //   child: SvgPicture.asset("assets/images/svg/imgaeSearch.svg"),
      // ),
    );
  }

  Widget _buildBottomNaviagationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: GetBuilder<HomeController>(
          init: homeController,
          builder: (controller) {
            return BottomNavigationBar(
              backgroundColor: const Color(0xffffffff),
              selectedLabelStyle: TextStyle(fontSize: 0),
              unselectedLabelStyle: TextStyle(fontSize: 0),
              items: [
                BottomNavigationBarItem(
                  label: "",
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5 * Scale.height),
                    child: Column(
                      children: [
                        SvgPicture.asset(controller.currentIconUrl[HOME]),
                        SizedBox(height: 6 * Scale.height),
                        Text(
                          "홈",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 12.0),
                        )
                      ],
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5 * Scale.height),
                    child: Column(
                      children: [
                        SvgPicture.asset(controller.currentIconUrl[CATEGORY]),
                        SizedBox(height: 6 * Scale.height),
                        Text(
                          "카테고리",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 12.0),
                        )
                      ],
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5 * Scale.height),
                    child: Column(
                      children: [
                        SvgPicture.asset(controller.currentIconUrl[LIKE]),
                        SizedBox(height: 6 * Scale.height),
                        Text(
                          "찜한 상품",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 12.0),
                        )
                      ],
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Padding(
                    padding: EdgeInsets.only(
                      top: 5 * Scale.height,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(controller.currentIconUrl[CHAT]),
                        SizedBox(height: 6 * Scale.height),
                        Text(
                          "피드",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 12.0),
                        )
                      ],
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5 * Scale.height),
                    child: Column(
                      children: [
                        SvgPicture.asset(controller.currentIconUrl[MYPAGE]),
                        SizedBox(height: 6 * Scale.height),
                        Text(
                          "마이페이지",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 12.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 12 * Scale.width,
              onTap: (index) {
                homeController.onItemTapped(index);
              },
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
            );
          }),
    );
  }
}
