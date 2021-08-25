import 'package:cloth_collection/page/page1.dart';
import 'package:cloth_collection/page/page2.dart';
import 'package:cloth_collection/page/page3.dart';
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("deepy", style: TextStyle(color: Colors.black)),
          backgroundColor: MAINCOLOR,
        ),
        body: TabBarView(
          children: [
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.purple[200],
          labelColor: Colors.purple[200],
          tabs: [
            Container(
              height: 50,
              child: Tab(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                text: 'home',
              ),
            ),
            Container(
              height: 50,
              child: Tab(
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                text: 'chat',
              ),
            ),
            Container(
              height: 50,
              child: Tab(
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                text: 'my',
              ),
            )
          ],
        ),
      ),
    );
  }
}
