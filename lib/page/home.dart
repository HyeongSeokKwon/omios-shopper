import 'package:cloth_collection/page/SearchImage.dart';
import 'package:cloth_collection/page/deepyHome/deepyHome.dart';
import 'package:cloth_collection/page/chatting.dart';
import 'package:cloth_collection/page/myPage.dart';
import 'package:cloth_collection/widget/main_Appbar.dart';
import 'package:flutter/material.dart';

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
    "assets/images/homeTapped.png",
    "assets/images/searchImage.png",
    "assets/images/chat.png",
    "assets/images/myPage.png"
  ];
  List<String> navigationIconUrl = [
    "assets/images/home.png",
    "assets/images/searchImage.png",
    "assets/images/chat.png",
    "assets/images/myPage.png"
  ];
  List<String> navigationOnTapIconUrl = [
    "assets/images/homeTapped.png",
    "assets/images/searchImageTapped.png",
    "assets/images/chatTapped.png",
    "assets/images/myPageTapped.png"
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
    return Scaffold(
      appBar: MainAppbar(focusNode),
      body: selectedPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "홈",
            icon: Image.asset(currentIconUrl[HOME]),
          ),
          BottomNavigationBarItem(
            label: "이미지검색",
            icon: Image.asset(currentIconUrl[SEARCH]),
          ),
          BottomNavigationBarItem(
            label: "채팅",
            icon: Image.asset(currentIconUrl[CHAT]),
          ),
          BottomNavigationBarItem(
            label: "마이페이지",
            icon: Image.asset(currentIconUrl[MYPAGE]),
          ),
        ],
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        selectedItemColor: const Color(0xffec5363),
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
