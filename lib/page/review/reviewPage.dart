import 'package:cloth_collection/page/review/createReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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

class _ScrollAreaState extends State<ScrollArea>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late int selectedTab;
  @override
  void initState() {
    super.initState();
    selectedTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return scrollArea();
  }

  Widget scrollArea() {
    List<Widget> tabBarViewList = [
      canCreateReview(),
      createdReview(),
    ];
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: StatefulBuilder(
                builder: ((context, setState) => Column(
                      children: <Widget>[
                        TabBar(
                          tabs: [
                            Text(
                              "작성 가능한 리뷰",
                              style: textStyle(Colors.black, FontWeight.w400,
                                  'NotoSansKR', 18.0),
                            ),
                            Text(
                              "작성한 리뷰",
                              style: textStyle(Colors.black, FontWeight.w400,
                                  'NotoSansKR', 18.0),
                            ),
                          ],
                          onTap: (index) {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          isScrollable: true,
                          labelStyle: textStyle(const Color(0xff333333),
                              FontWeight.w500, "NotoSansKR", 18.0),
                          unselectedLabelStyle: textStyle(
                              const Color(0xffcccccc),
                              FontWeight.w500,
                              "NotoSansKR",
                              18.0),
                        ),
                        SizedBox(height: 15 * Scale.height),
                        tabBarViewList[selectedTab],
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewTabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        canCreateReview(),
        createdReview(),
      ],
    );
  }

  Widget canCreateReview() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: ((context, index) {
        return canCreateReviewBox();
      }),
    );
  }

  Widget canCreateReviewBox() {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "구매확정일 YY.MM.FF",
            style: textStyle(
                Colors.grey[400]!, FontWeight.w400, 'NotoSansKR', 13.0),
          ),
          SizedBox(height: 5 * Scale.height),
          Row(
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
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
            child: Divider(
              thickness: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "최대 적립 포인트 xxx원",
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 14.0),
                  ),
                  Text(
                    "YY.MM.DD 까지 작성 가능",
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 14.0),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CreateReview())));
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 25 * Scale.width,
                        vertical: 10 * Scale.height),
                    child: Text(
                      "리뷰 작성",
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'NotoSansKR', 14.0),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget createdReview() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: ((context, index) {
        return createdReviewBox();
      }),
    );
  }

  Widget createdReviewBox() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
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
