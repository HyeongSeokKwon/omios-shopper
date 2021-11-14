import 'dart:async';

import 'package:cloth_collection/util/util.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//점으로 현재 페이지 표시되는 이미지 슬라이드
class ImageSlideHasDot extends StatefulWidget {
  final double width;
  final double height;
  ImageSlideHasDot(this.width, this.height);
  @override
  _ImageSlideHasDotState createState() => _ImageSlideHasDotState();
}

class _ImageSlideHasDotState extends State<ImageSlideHasDot> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final List<Container> images = <Container>[
      Container(color: Colors.red),
      Container(color: Colors.blue),
      Container(color: Colors.pink)
    ];
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return images[index];
            },
            onPageChanged: (value) {
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: images.length,
                effect: WormEffect(
                    spacing: 8.0,
                    dotWidth: 15.0,
                    dotHeight: 15.0,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//숫자로 현재페이지 표시되는 이미지 슬라이드
class ImageSlideHasNum extends StatefulWidget {
  final double width;
  final double height;
  ImageSlideHasNum(this.width, this.height);
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
      width: widget.width,
      height: widget.height,
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
            bottom: widget.height * 0.054,
            right: widget.width * 0.053,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: widget.width * 0.109,
                height: widget.height * 0.092,
                decoration: BoxDecoration(
                  color: const Color(0xff444444),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                        "${(_currentPosition + 1).toInt()}/${images.length}",
                        style: textStyle(const Color(0xffffffff),
                            FontWeight.w400, "NotoSansKR", 12.0))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
