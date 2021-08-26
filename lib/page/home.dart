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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("deepy", style: TextStyle(color: Colors.black)),
          backgroundColor: MAINCOLOR,
        ),
        body: TabBarView(
          children: [
            DeepyHome(),
            SearchImage(),
            Chatting(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.purple[200],
          labelColor: Colors.purple[200],
          tabs: [
            Container(
              child: Tab(
                icon: Icon(
                  Icons.home,
                  color: Colors.purple[100],
                ),
                text: '홈',
              ),
            ),
            Container(
              child: Tab(
                icon: Icon(
                  Icons.chat,
                  color: Colors.purple[100],
                ),
                text: '이미지 검색',
              ),
            ),
            Container(
              child: Tab(
                icon: Icon(
                  Icons.people,
                  color: Colors.purple[100],
                ),
                text: '채팅',
              ),
            ),
            Container(
              child: Tab(
                icon: Icon(
                  Icons.people,
                  color: Colors.purple[100],
                ),
                text: '마이페이지',
              ),
            )
          ],
        ),
      ),
    );
  }
}
