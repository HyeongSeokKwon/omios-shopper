import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloth_collection/page/productDetail/photoViewer.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//점으로 현재 페이지 표시되는 이미지 슬라이드
class ImageSlideHasDot extends StatefulWidget {
  final List<dynamic> imageList;
  ImageSlideHasDot({required this.imageList});
  @override
  _ImageSlideHasDotState createState() => _ImageSlideHasDotState();
}

class _ImageSlideHasDotState extends State<ImageSlideHasDot> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414 * Scale.width,
      height: 1.2 * 414 * Scale.width,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: "${widget.imageList[index]['image_url']}",
                    fit: BoxFit.fill,
                    width: 414 * Scale.width,
                    height: 1.2 * 414 * Scale.width,
                  ),
                  onTap: () {
                    Get.to(() =>
                        PhotoViewer(imageList: widget.imageList, index: index));
                  },
                ),
              );
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
                count: widget.imageList.length,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> images = <Container>[
      Container(
          child: Image.asset(
        "assets/images/배너1.png",
      )),
      Container(
          child: Image.asset(
        "assets/images/배너2.png",
      )),
      Container(
          child: Image.asset(
        "assets/images/배너3.png",
      )),
    ];

    return CarouselSlider(
      items: images,
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        aspectRatio: 2,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
