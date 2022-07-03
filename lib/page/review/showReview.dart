import 'package:cloth_collection/page/review/reviewBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class ShowReviewPage extends StatefulWidget {
  const ShowReviewPage({Key? key}) : super(key: key);

  @override
  State<ShowReviewPage> createState() => _ShowReviewPageState();
}

class _ShowReviewPageState extends State<ShowReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/images/svg/moveToBack.svg",
                width: 10 * Scale.width,
                height: 20 * Scale.height,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(width: 14 * Scale.width),
            Text("리뷰",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 22.0)),
          ],
        ),
      ),
      body: ScrollArea(),
    );
  }
}

class ScrollArea extends StatefulWidget {
  const ScrollArea({Key? key}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          productInfo(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 5 * Scale.height, horizontal: 20 * Scale.width),
            child: Divider(
              thickness: 2 * Scale.height,
            ),
          ),
          ReviewPageReviewBox(),
        ],
      ),
    );
  }

  Widget productInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
      child: Row(
        children: [
          Container(
            width: 74 * Scale.width,
            height: 74 * Scale.width * 4 / 3,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/images/임시상품2.png')),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
          ),
          SizedBox(
            width: 13 * Scale.width,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 16.0),
                ),
                SizedBox(height: 4 * Scale.height),
                Text(
                  "display_color_name / size | 수량 : N",
                  style: textStyle(const Color(0xff797979), FontWeight.w400,
                      "NotoSansKR", 13.0),
                ),
                SizedBox(height: 8 * Scale.height),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 10 * Scale.width,
            ),
            child: SvgPicture.asset('assets/images/svg/mypageAddtionalMove.svg',
                width: 15 * Scale.width, height: 15 * Scale.width),
          )
        ],
      ),
    );
  }
}
