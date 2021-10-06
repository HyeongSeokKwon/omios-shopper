import 'package:cloth_collection/page/SearchImage.dart';
import 'package:cloth_collection/page/deepyHome/deepyHome.dart';
import 'package:cloth_collection/page/myPage.dart';
import 'package:cloth_collection/widget/appbar/chatting_Appbar.dart';
import 'package:cloth_collection/widget/appbar/deepyHomeAppbar.dart';
import 'package:cloth_collection/widget/appbar/imageSearch_Appbar.dart';
import 'package:cloth_collection/widget/appbar/myPage_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'chatting/chatting.dart';

const int HOME = 0;
const int SEARCH = 1;
const int CHAT = 2;
const int MYPAGE = 3;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  late List<Widget> selectedPage;
  List<String> currentIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/searchImage.svg",
    "assets/images/svg/chat.svg",
    "assets/images/svg/myPage.svg"
  ];
  List<String> navigationIconUrl = [
    "assets/images/svg/home.svg",
    "assets/images/svg/searchImage.svg",
    "assets/images/svg/chat.svg",
    "assets/images/svg/myPage.svg"
  ];
  List<String> navigationOnTapIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/searchImageTapped.svg",
    "assets/images/svg/chatTapped.svg",
    "assets/images/svg/myPageTapped.svg"
  ];

  @override
  void initState() {
    super.initState();
    selectedPage = [
      DeepyHome(scrollController),
      SearchImage(),
      Chatting(),
      MyPage(),
    ];
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        currentIconUrl[_currentIndex] = navigationIconUrl[_currentIndex];
        _currentIndex = index;
        currentIconUrl[_currentIndex] = navigationOnTapIconUrl[_currentIndex];
      });
    }
    if (index == HOME) {
      if (scrollController.hasClients) {
        scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PreferredSizeWidget> appBar = [
      DeepyHomeAppbar(),
      ImageSearchAppbar(),
      ChattingAppbar(),
      MypageAppbar()
    ];
    return Scaffold(
      appBar: appBar[_currentIndex],
      body: selectedPage[_currentIndex],
      bottomNavigationBar: _buildBottomNaviagationBar(),
    );
  }

  Widget _buildBottomNaviagationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: "홈",
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(currentIconUrl[HOME]),
          ),
        ),
        BottomNavigationBarItem(
          label: "이미지검색",
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(currentIconUrl[SEARCH]),
          ),
        ),
        BottomNavigationBarItem(
          label: "채팅",
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(currentIconUrl[CHAT]),
          ),
        ),
        BottomNavigationBarItem(
          label: "마이페이지",
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(currentIconUrl[MYPAGE]),
          ),
        ),
      ],
      showUnselectedLabels: true,
      selectedFontSize: 12.0,
      selectedItemColor: const Color(0xffec5363),
      onTap: _onItemTapped,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
    );
  }
}
