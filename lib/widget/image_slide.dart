import 'dart:async';

import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//점으로 현재 페이지 표시되는 이미지 슬라이드
class ImageSlideHasDot extends StatefulWidget {
  @override
  _ImageSlideHasDotState createState() => _ImageSlideHasDotState();
}

class _ImageSlideHasDotState extends State<ImageSlideHasDot> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final List<Container> images = <Container>[
      Container(child: Image.asset("assets/images/임시상품2.png")),
      Container(child: Image.asset("assets/images/임시상품3.png")),
      Container(child: Image.asset("assets/images/임시상품4.png")),
    ];
    return Container(
      width: 414 * Scale.width,
      height: (1.2) * 414 * Scale.width,
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
    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPosition < 2) {
          _currentPosition = _currentPosition + 1;
        } else {
          _currentPosition = 0;
        }
        _pageController.animateToPage(_currentPosition.toInt(),
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> images = <Container>[
      Container(
          child: Image.asset(
        "assets/images/배너1.png",
        width: 414 * Scale.width,
        fit: BoxFit.fill,
      )),
      Container(
          child: Image.asset(
        "assets/images/배너2.png",
        width: 414 * Scale.width,
        fit: BoxFit.fill,
      )),
      Container(
          child: Image.asset(
        "assets/images/배너3.png",
        width: 414 * Scale.width,
        fit: BoxFit.fill,
      )),
    ];
    return Container(
      width: 414 * Scale.width,
      height: 300 * Scale.height,
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
            bottom: Scale.height * 0.054,
            right: Scale.width * 0.053,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: Scale.width * 0.109,
                height: Scale.height * 0.092,
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
