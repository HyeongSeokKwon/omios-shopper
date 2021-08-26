import 'package:cloth_collection/page/SearchImage.dart';
import 'package:cloth_collection/page/deepyHome.dart';
import 'package:cloth_collection/page/chatting.dart';
import 'package:cloth_collection/page/myPage.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> selectedPage = [
    DeepyHome(),
    SearchImage(),
    Chatting(),
    MyPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("deepy", style: TextStyle(color: Colors.black)),
        backgroundColor: MAINCOLOR,
      ),
      body: selectedPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "홈",
            icon: Icon(
              Icons.home,
              color: Colors.purple[100],
            ),
          ),
          BottomNavigationBarItem(
            label: "이미지검색",
            icon: Icon(
              Icons.home,
              color: Colors.purple[100],
            ),
          ),
          BottomNavigationBarItem(
            label: "채팅",
            icon: Icon(
              Icons.home,
              color: Colors.purple[100],
            ),
          ),
          BottomNavigationBarItem(
            label: "마이페이지",
            icon: Icon(
              Icons.home,
              color: Colors.purple[100],
            ),
          ),
        ],
        selectedItemColor: MAINCOLOR,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(color: MAINCOLOR),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        onTap: onItemTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void onItemTapped(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
