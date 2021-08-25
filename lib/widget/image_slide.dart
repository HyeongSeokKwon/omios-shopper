import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ImageSlide extends StatefulWidget {
  @override
  _ImageSlideState createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  PageController _pageController = PageController(initialPage: 0);
  double _currentPosition = 0.0;
  final List<Container> images = <Container>[
    Container(color: Colors.red, height: 50, width: 20),
    Container(color: Colors.blue, height: 50),
    Container(color: Colors.black, height: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              _currentPosition = index.toDouble();
              return images[index];
            },
            onPageChanged: (value) {
              _currentPosition = value.toDouble();
              setState(() {});
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DotsIndicator(
                dotsCount: images.length,
                position: _currentPosition,
              ),
            ),
          )
        ],
      ),
    );
  }
}
