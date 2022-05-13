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
}
