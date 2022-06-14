import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/page/category/category.dart';
import 'package:cloth_collection/page/deepyHome/deepyHome.dart';
import 'package:cloth_collection/page/like/like.dart';
import 'package:cloth_collection/page/mypage/myPage.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/appbar/LikePageAppbar.dart';
import 'package:cloth_collection/widget/appbar/category_Appbar.dart';
import 'package:cloth_collection/widget/appbar/deepyHomeAppbar.dart';
import 'package:cloth_collection/widget/appbar/imageSearch_Appbar.dart';
import 'package:cloth_collection/widget/appbar/myPage_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  FocusNode focusNode = FocusNode();
  List<Widget> selectedPage = [
    DeepyHome(),
    Category(),
    LikePage(),
    Chatting(),
    MyPage(),
  ];
  List<PreferredSizeWidget> appBar = [
    DeepyHomeAppbar(),
    CategoryAppbar(),
    LikePageAppbar(),
    ImageSearchAppbar(),
    MypageAppbar(),
  ];
  List<String> currentIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/category.svg",
    "assets/images/svg/bottomNavigationUnlike.svg",
    "assets/images/svg/feed.svg",
    "assets/images/svg/myPage.svg",
  ];
  List<String> navigationIconUrl = [
    "assets/images/svg/home.svg",
    "assets/images/svg/category.svg",
    "assets/images/svg/bottomNavigationUnlike.svg",
    "assets/images/svg/feed.svg",
    "assets/images/svg/myPage.svg"
  ];
  List<String> navigationOnTapIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/categoryTapped.svg",
    "assets/images/svg/bottomNavigationLike.svg",
    "assets/images/svg/feedTapped.svg",
    "assets/images/svg/myPageTapped.svg"
  ];

  @override
  void initState() {
    super.initState();
    print('init');
    DBHelper().db;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70), child: appBar[_currentIndex]),
      backgroundColor: Colors.white,
      body: selectedPage[_currentIndex],
      bottomNavigationBar: _buildBottomNaviagationBar(),
    );
  }

  Widget _buildBottomNaviagationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
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
                  SvgPicture.asset(currentIconUrl[HOME]),
                  SizedBox(height: 6 * Scale.height),
                  Text(
                    "홈",
                    style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                        "NotoSansKR", 12.0),
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
                  SvgPicture.asset(currentIconUrl[CATEGORY]),
                  SizedBox(height: 6 * Scale.height),
                  Text(
                    "카테고리",
                    style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                        "NotoSansKR", 12.0),
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
                  SvgPicture.asset(currentIconUrl[LIKE]),
                  SizedBox(height: 6 * Scale.height),
                  Text(
                    "찜한 상품",
                    style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                        "NotoSansKR", 12.0),
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
                  SvgPicture.asset(currentIconUrl[CHAT]),
                  SizedBox(height: 6 * Scale.height),
                  Text(
                    "피드",
                    style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                        "NotoSansKR", 12.0),
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
                  SvgPicture.asset(currentIconUrl[MYPAGE]),
                  SizedBox(height: 6 * Scale.height),
                  Text(
                    "마이페이지",
                    style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                        "NotoSansKR", 12.0),
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
          setState(() {
            currentIconUrl[_currentIndex] = navigationIconUrl[_currentIndex];
            _currentIndex = index;
            currentIconUrl[_currentIndex] =
                navigationOnTapIconUrl[_currentIndex];
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
