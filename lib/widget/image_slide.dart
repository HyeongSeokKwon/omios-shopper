import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

//점으로 현재 페이지 표시되는 이미지 슬라이드
class ImageSlideHasDot extends StatefulWidget {
  @override
  _ImageSlideHasDotState createState() => _ImageSlideHasDotState();
}

class _ImageSlideHasDotState extends State<ImageSlideHasDot> {
  PageController _pageController = PageController(initialPage: 0);
  double _currentPosition = 0.0;
  final List<Container> images = <Container>[
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

//숫자로 현재페이지 표시되는 이미지 슬라이드
class ImageSlideHasNum extends StatefulWidget {
  final double height;
  final double width;
  ImageSlideHasNum(this.height, this.width);
  @override
  _ImageSlideHasNumState createState() => _ImageSlideHasNumState();
}

class _ImageSlideHasNumState extends State<ImageSlideHasNum> {
  double _currentPosition = 0.0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPosition < 2) {
          _currentPosition = _currentPosition + 1;
          print(_currentPosition);
        } else {
          _currentPosition = 0;
          print(_currentPosition);
        }
        _pageController.animateToPage(_currentPosition.toInt(),
            duration: Duration(milliseconds: 3), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> images = <Container>[
      Container(color: Colors.purple[100]),
      Container(color: Colors.purple[200]),
      Container(color: Colors.purple[300]),
    ];
    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          PageView.builder(
            pageSnapping: true,
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
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: widget.width * 0.15,
              height: widget.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                  child: Text(
                "${(_currentPosition + 1).toInt()}/${images.length}",
                style: TextStyle(fontSize: 20),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
