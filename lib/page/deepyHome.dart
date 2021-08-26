import 'package:cloth_collection/widget/image_slide.dart';
import 'package:flutter/material.dart';

class DeepyHome extends StatefulWidget {
  @override
  _DeepyHomeState createState() => _DeepyHomeState();
}

class _DeepyHomeState extends State<DeepyHome> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(child: ImageSlideHasNum(width, height));
  }
}
