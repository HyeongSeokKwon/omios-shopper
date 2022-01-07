import 'package:card_swiper/card_swiper.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/appbar/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewBox extends StatefulWidget {
  const ReviewBox({Key? key}) : super(key: key);

  @override
  _ReviewBoxState createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
  PageController reviewPhotoController = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: 22 * Scale.width,
          right: 22 * Scale.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25 * Scale.height),
            reviewerIDDateArea(),
            SizedBox(height: 8 * Scale.height),
            buildRatingBar(14, 4.3),
            SizedBox(height: 11 * Scale.height),
            reviewInfoArea(),
            reviewPhotoArea(),
            SizedBox(height: 8 * Scale.height),
            addtionalButtonArea(),
          ],
        ),
      ),
    );
  }

  Widget reviewerIDDateArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "nick_name",
          style: textStyle(
              const Color(0xff333333), FontWeight.w500, "NotoSansKR", 16.0),
        ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 55 * Scale.width,
                  child: Text(
                    "체형 정보",
                    style: textStyle(const Color(0xff999999), FontWeight.w500,
                        "NotoSansKR", 14.0),
                  ),
                ),
                SizedBox(width: 47 * Scale.width),
                reviewerInfo("158cm | 47kg | 상의 44 | 하의 23 | 발 245"),
              ],
            ),
            SizedBox(height: 5 * Scale.height),
            Row(
              children: [
                Container(
                  width: 55 * Scale.width,
                  child: Text(
                    "선택옵션",
                    style: textStyle(const Color(0xff999999), FontWeight.w500,
                        "NotoSansKR", 14.0),
                  ),
                ),
                SizedBox(width: 47 * Scale.width),
                reviewerInfo("연베이지"),
              ],
            ),
            SizedBox(height: 5 * Scale.height),
            Row(
              children: [
                Container(
                  width: 55 * Scale.width,
                  child: Text(
                    "한줄평",
                    style: textStyle(const Color(0xff999999), FontWeight.w500,
                        "NotoSansKR", 14.0),
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(width: 47 * Scale.width),
                reviewerInfo("색감 화면과 같아요, 퀄리티 아주 좋아요,사이즈 딱 맞아요"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget reviewerInfo(String info) {
    return Text("$info",
        style: textStyle(
            const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0),
        maxLines: 2,
        softWrap: false,
        overflow: TextOverflow.visible);
  }

  Widget reviewPhotoArea() {
    var photoList = [
      "assets/images/reviewImage1.png",
      "assets/images/reviewImage2.png"
    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14 * Scale.height),
      child: Center(
        child: Container(
          width: 400 * Scale.width,
          height: 400 * Scale.height,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset("${photoList[index]}");
            },
            itemCount: 2,
            viewportFraction: 0.8,
            scale: 0.9,
            loop: false,
          ),
        ),
      ),
    );
  }

  Widget addtionalButtonArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "리뷰가 도움이 되었나요?",
          style:
              textStyle(Color(0xff999999), FontWeight.w400, "NotoSansKR", 13.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/like.svg",
                        width: 8 * Scale.width,
                        height: 8 * Scale.width,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(width: 5 * Scale.width),
                      Text(
                        "9",
                        style: textStyle(const Color(0xffec5363),
                            FontWeight.w400, "NotoSansKR", 13.0),
                      ),
                    ],
                  ),
                  width: 41 * Scale.width,
                  height: 24 * Scale.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        Border.all(color: const Color(0xffec5363), width: 1),
                    color: const Color(0xffffffff),
                  ),
                ),
                SizedBox(width: 6 * Scale.width),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/unlike.svg",
                        width: 8 * Scale.width,
                        height: 8 * Scale.width,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(width: 5 * Scale.width),
                      Text("9",
                          style: textStyle(const Color(0xff999999),
                              FontWeight.w400, "NotoSansKR", 13.0)),
                    ],
                  ),
                  width: 41 * Scale.width,
                  height: 24 * Scale.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        Border.all(color: const Color(0xff999999), width: 1),
                    color: const Color(0xffffffff),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/svg/report.svg",
                      width: 8 * Scale.width,
                      height: 8 * Scale.width,
                    ),
                    SizedBox(width: 3.2 * Scale.width),
                    Text(
                      "신고하기",
                      style: textStyle(const Color(0xfff84457), FontWeight.w500,
                          "NotoSansKR", 13.0),
                    ),
                  ],
                ),
                width: 80 * Scale.width,
                height: 24 * Scale.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: const Color(0xfffff0f2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
