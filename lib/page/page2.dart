import 'package:cloth_collection/widget/image_slide.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(height: 100, child: ImageSlide()),
    );
  }
}
