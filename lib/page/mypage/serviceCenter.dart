import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class ServiceCenter extends StatelessWidget {
  const ServiceCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
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
                Text("고객센터",
                    style: textStyle(const Color(0xff333333), FontWeight.w700,
                        "NotoSansKR", 22.0)),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50 * Scale.height),
              child: Column(
                children: [
                  TabBar(
                    isScrollable: false,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          width: 2.0, color: const Color(0xffec5363)),
                    ),
                    tabs: [
                      Container(
                        width: 207 * Scale.width,
                        child: Tab(
                          text: "FAQ",
                        ),
                      ),
                      Container(
                        width: 207 * Scale.width,
                        child: Tab(
                          text: "내 문의내역",
                        ),
                      ),
                    ],
                    labelColor: const Color(0xffec5363),
                    unselectedLabelColor: const Color(0xffcccccc),
                    labelStyle: textStyle(
                        Color(0xffec5363), FontWeight.w500, "NotoSansKR", 16.0),
                    unselectedLabelStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                  )
                ],
              ),
            ),
          ),
          body: scrollArea(),
        ),
      ),
    );
  }

  Widget scrollArea() {
    return TabBarView(
      children: [
        productInCartArea(),
        productInCartArea(),
      ],
    );
  }

  Widget productInCartArea() {
    return SingleChildScrollView(
      child: Column(
        children: [
          questionTopThree(),
          customerServiceArea(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20 * Scale.height),
            child: Divider(
              thickness: 10,
              color: Colors.grey[50],
            ),
          ),
          qnaArea(),
        ],
      ),
    );
  }

  Widget questionTopThree() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20 * Scale.height, horizontal: 20 * Scale.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "자주 묻는 질문",
                        style: textStyle(
                            Colors.black, FontWeight.w500, 'NotoSansKR', 22.0)),
                    TextSpan(
                        text: " TOP 3",
                        style: textStyle(Color(0xffec5363), FontWeight.w700,
                            'NotoSansKR', 22.0))
                  ],
                ),
              ),
              Text("더보기",
                  style: textStyle(
                      Color(0xffec5363), FontWeight.w500, 'NotoSansKR', 14.0))
            ],
          ),
        ),
        ListView.separated(
          //api 연동
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0 * Scale.height),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text((index + 1).toString(),
                              style: textStyle(Color(0xffec5363),
                                  FontWeight.w700, 'NotoSansKR', 20.0)),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            "질문 내용",
                            style: textStyle(Colors.black, FontWeight.w400,
                                'NotoSansKR', 18.0),
                          ),
                          flex: 9,
                        ),
                        Expanded(
                          child: Icon(Icons.keyboard_arrow_down),
                          flex: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey[500]);
          },
        ),
      ],
    );
  }

  Widget customerServiceArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "고객센터",
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
          ),
          Text(
            "주말/공휴일 휴무",
            style: textStyle(
                Colors.grey[600]!, FontWeight.w400, 'NotoSansKR', 11.0),
          ),
          SizedBox(height: 20 * Scale.height),
          Text(
            "상품/배송/교환/환불 문의",
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
          ),
          Center(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40 * Scale.height,
                    child: Center(
                        child: Text(
                      "카톡상담",
                      style: textStyle(
                          Colors.black, FontWeight.w700, 'NotoSansKR', 14.0),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                        color: Colors.yellow[600]),
                  ),
                ),
                SizedBox(width: 10 * Scale.width),
                Expanded(
                  child: Container(
                    height: 40 * Scale.height,
                    child: Center(
                        child: Text("전화상담",
                            style: textStyle(Colors.black, FontWeight.w700,
                                'NotoSansKR', 14.0))),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                      border: Border.all(color: Colors.grey[600]!),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20 * Scale.height),
          Text(
            "앱 버그 및 오류 신고",
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
          ),
          Container(
            width: double.maxFinite,
            height: 40 * Scale.height,
            child: Center(
              child: Text(
                "카톡상담",
                style: textStyle(
                    Colors.black, FontWeight.w700, 'NotoSansKR', 14.0),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
                color: Colors.yellow[600]),
          ),
        ],
      ),
    );
  }

  Widget qnaArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              qnaKindsButton("전체"),
              qnaKindsButton("주문/결제"),
              qnaKindsButton("배송문의"),
              qnaKindsButton("취소/환불"),
            ],
          ),
          SizedBox(height: 5 * Scale.height),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              qnaKindsButton("교환/반품"),
              qnaKindsButton("포인트/쿠폰"),
              qnaKindsButton("로그인/회원정보"),
            ],
          ),
          SizedBox(height: 5 * Scale.height),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              qnaKindsButton("서비스/기타문의"),
            ],
          ),
        ],
      ),
    );
  }

  Widget qnaKindsButton(String type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * Scale.width),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 3 * Scale.height, horizontal: 10 * Scale.width),
          child: Center(
            child: Text(
              type,
              style: textStyle(
                  Colors.grey[500]!, FontWeight.w500, 'NotoSansKR', 13.0),
            ),
          ),
        ),
      ),
    );
  }
}
