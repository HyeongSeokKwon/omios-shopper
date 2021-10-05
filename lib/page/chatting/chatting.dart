import 'package:cloth_collection/page/chatting/widget/briefChattingBox.dart';
import 'package:flutter/material.dart';

class Chatting extends StatefulWidget {
  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              BriefChattingBox(),
              SizedBox(height: 20),
            ],
          );
        });
  }
}
