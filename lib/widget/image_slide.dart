import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ImageSlideHasDot extends StatefulWidget {
  @override
  _ImageSlideHasDotState createState() => _ImageSlideHasDotState();
}

class _ImageSlideHasDotState extends State<ImageSlideHasDot> {
  PageController _pageController = PageController(initialPage: 0);
  double _currentPosition = 0.0;
  final List<Container> images = <Container>[
    Container(
      color: Colors.red,
      height: 50,
    ),
    Container(color: Colors.blue, height: 50),
    Container(color: Colors.black, height: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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

class ImageSlideHasNum extends StatefulWidget {
  final double height;
  final double width;
  ImageSlideHasNum(this.height, this.width);
  @override
  _ImageSlideHasNumState createState() => _ImageSlideHasNumState();
}

class _ImageSlideHasNumState extends State<ImageSlideHasNum> {
  PageController _pageController = PageController(initialPage: 0);
  double _currentPosition = 0.0;
  final List<Container> images = <Container>[
    Container(
      color: Colors.purple[100],
      height: 50,
    ),
    Container(color: Colors.purple[200], height: 50),
    Container(color: Colors.purple[300], height: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              alignment: Alignment.bottomRight,
              child: Container(
                child:
                    Text("${(_currentPosition + 1).toInt()}/${images.length}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
