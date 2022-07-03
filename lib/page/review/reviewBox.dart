import 'package:card_swiper/card_swiper.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

import '../../widget/appbar/rating_bar.dart';

class ReviewPageReviewBox extends StatelessWidget {
  final PageController reviewPhotoController = PageController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 22 * Scale.width,
        right: 22 * Scale.width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reviewerIDDateArea(),
          reviewPhotoArea(),
          reviewInfoArea(),
        ],
      ),
    );
  }

  Widget reviewerIDDateArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildRatingBar(13, 5),
        Text(
          "YYYY.MM.DD",
          style: textStyle(
              const Color(0xff999999), FontWeight.w500, "NotoSansKR", 14.0),
        ),
      ],
    );
  }

  Widget reviewInfoArea() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "색감 화면과 같아요, 퀄리티 아주 좋아요,사이즈 딱 맞아요~~~~~~~~~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
                maxLines: 100,
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 15 * Scale.width),
              reviewerInfo("158cm | 47kg | 선택옵션 : 아이보리 / Free"),
              SizedBox(height: 5 * Scale.height),
            ],
          ),
        ),
      ],
    );
  }

  Widget reviewerInfo(String info) {
    return Container(
      constraints: BoxConstraints(maxWidth: 260 * Scale.width),
      child: Text("$info",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0),
          maxLines: 5,
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget reviewPhotoArea() {
    var photoList = [
      "assets/images/reviewImage1.png",
      "assets/images/reviewImage2.png"
    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0 * Scale.height),
      child: Center(
        child: Container(
          height: 300 * Scale.width,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                "${photoList[index]}",
                fit: BoxFit.fill,
              );
            },
            itemCount: 2,
            viewportFraction: 0.9,
            scale: 0.9,
            loop: false,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: const Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}
