import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/page/coupon/coupon.dart';
import 'package:cloth_collection/page/mypage/serviceCenter.dart';
import 'package:cloth_collection/page/mypage/setting.dart';
import 'package:cloth_collection/page/orderHistory/orderHistory.dart';
import 'package:cloth_collection/page/point/point.dart';
import 'package:cloth_collection/page/recentviewProduct.dart';
import 'package:cloth_collection/page/review/createReview.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final ShopperInfoBloc shopperInfoBloc = ShopperInfoBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => shopperInfoBloc,
      child: BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
        builder: (context, state) {
          if (state.getShopperInfoState == ApiState.initial) {
            context.read<ShopperInfoBloc>().add(GetShopperInfoEvent());
            return progressBar();
          } else if (state.getShopperInfoState == ApiState.success) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                  child: Column(
                    children: [
                      shortUserInfoArea(),
                      SizedBox(height: 40 * Scale.height),
                      myActivityArea(),
                      SizedBox(height: 30 * Scale.height),
                      pointAndCouponArea(),
                      SizedBox(height: 64 * Scale.height),
                      addtionalAppInfo(),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.getShopperInfoState == ApiState.fail) {
            return ErrorCard();
          } else {
            return progressBar();
          }
        },
      ),
    );
  }

  Widget shortUserInfoArea() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage("assets/images/임시상품1.png"),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(width: 16 * Scale.width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${context.read<ShopperInfoBloc>().state.shopperInfo['nickname']} 님 안녕하세요!",
                      style: textStyle(const Color(0xff333333), FontWeight.w500,
                          "NotoSansKR", 18.0),
                    ),
                    SizedBox(height: 6 * Scale.height),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              style: textStyle(Color(0xff797979),
                                  FontWeight.w500, "NotoSansKR", 16.0),
                              text: context
                                  .read<ShopperInfoBloc>()
                                  .state
                                  .shopperInfo['membership']['name']),
                          TextSpan(
                              style: textStyle(const Color(0xff999999),
                                  FontWeight.w400, "NotoSansKR", 16.0),
                              text: "등급 혜택 보기 >")
                        ],
                      ),
                    ),
                    SizedBox(height: 6 * Scale.height),
                    Container(
                        child: InkWell(
                      child: Text("로그아웃",
                          style: textStyle(Color(0xff797979), FontWeight.w400,
                              "NotoSansKR", 14.0)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('autoLogin', false);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Login(),
                          ),
                          (route) =>
                              false, //if you want to disable back feature set to false
                        );
                      },
                    )),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Setting(
                              shopperInfoBloc: shopperInfoBloc,
                            ))));
              }),
              child: SvgPicture.asset(
                "assets/images/svg/mypageMove.svg",
                width: 24 * Scale.width,
                height: 24 * Scale.width,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget myActivityArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Column(
            children: [
              SvgPicture.asset("assets/images/svg/mypageOrderHistory.svg"),
              SizedBox(height: 4 * Scale.height),
              Text("주문내역",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 14.0)),
            ],
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => OrderHistory()));
          },
        ),
        GestureDetector(
          child: Column(
            children: [
              SvgPicture.asset("assets/images/svg/mypageMakeReview.svg"),
              SizedBox(height: 4 * Scale.height),
              Text("리뷰작성",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 14.0)),
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateReview()));
          },
        ),
        GestureDetector(
          child: Column(
            children: [
              SvgPicture.asset("assets/images/svg/mypageLikeProduct.svg"),
              SizedBox(height: 4 * Scale.height),
              Text("찜한상품",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 14.0)),
            ],
          ),
        ),
        GestureDetector(
          child: Column(
            children: [
              SvgPicture.asset(
                  "assets/images/svg/mypageRecentlyViewProduct.svg"),
              SizedBox(height: 4 * Scale.height),
              Text("최근 본 상품",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 14.0)),
            ],
          ),
          onTap: () {
            Get.to(() => RecentviewProduct());
          },
        ),
      ],
    );
  }

  Widget pointAndCouponArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 180 * Scale.width,
          height: 66 * Scale.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0xffe2e2e2), width: 1),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x0f000000),
                  offset: Offset(0, 3),
                  blurRadius: 15,
                  spreadRadius: 0)
            ],
            color: const Color(0xffffffff),
          ),
          child: BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
            builder: (context, state) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => PointPage(
                            point: state.shopperInfo['point'],
                          )),
                    ),
                  );
                }),
                child: Padding(
                  padding: EdgeInsets.only(left: 12 * Scale.width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "포인트",
                        style: textStyle(
                          const Color(0xff797979),
                          FontWeight.w400,
                          "NotoSansKR",
                          14.0,
                        ),
                      ),
                      SizedBox(height: 2 * Scale.height),
                      BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
                        builder: (context, state) {
                          return Text(
                            setPriceFormat(context
                                    .read<ShopperInfoBloc>()
                                    .state
                                    .shopperInfo['point']) +
                                " P",
                            style: textStyle(
                              const Color(0xff333333),
                              FontWeight.w500,
                              "NotoSansKR",
                              16.0,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        InkWell(
          onTap: (() => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Coupon(),
                ),
              )),
          child: Container(
            width: 180 * Scale.width,
            height: 66 * Scale.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xffe2e2e2), width: 1),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x0f000000),
                    offset: Offset(0, 3),
                    blurRadius: 15,
                    spreadRadius: 0)
              ],
              color: const Color(0xffffffff),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 12 * Scale.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "쿠폰",
                    style: textStyle(
                      const Color(0xff797979),
                      FontWeight.w400,
                      "NotoSansKR",
                      14.0,
                    ),
                  ),
                  SizedBox(height: 2 * Scale.height),
                  Text(
                    "0 장",
                    style: textStyle(
                      const Color(0xff333333),
                      FontWeight.w500,
                      "NotoSansKR",
                      16.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget addtionalAppInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/images/svg/mypageQuestion.svg",
                    width: 18 * Scale.width,
                    height: 18 * Scale.width,
                    fit: BoxFit.scaleDown),
                SizedBox(width: 16 * Scale.width),
                Text(
                  "앱 문의",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 16.0),
                ),
              ],
            ),
            SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
          ],
        ),
        SizedBox(height: 32 * Scale.height),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => ServiceCenter())));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svg/mypageCustomerCenter.svg",
                      width: 18 * Scale.width,
                      height: 18 * Scale.width,
                      fit: BoxFit.scaleDown),
                  SizedBox(width: 16 * Scale.width),
                  Text(
                    "고객센터",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 16.0),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
            ],
          ),
        ),
        SizedBox(height: 32 * Scale.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/images/svg/mypageUsingTerm.svg",
                    width: 18 * Scale.width,
                    height: 18 * Scale.width,
                    fit: BoxFit.scaleDown),
                SizedBox(width: 16 * Scale.width),
                Text(
                  "이용약관",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 16.0),
                ),
              ],
            ),
            SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
          ],
        ),
        SizedBox(height: 32 * Scale.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/images/svg/mypageInfoPolicy.svg",
                    width: 18 * Scale.width,
                    height: 18 * Scale.width,
                    fit: BoxFit.scaleDown),
                SizedBox(width: 16 * Scale.width),
                Text(
                  "개인정보 취급방침",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 16.0),
                ),
              ],
            ),
            SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
          ],
        ),
        SizedBox(height: 32 * Scale.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/images/svg/mypageVersionInfo.svg",
                    width: 18 * Scale.width,
                    height: 18 * Scale.width,
                    fit: BoxFit.scaleDown),
                SizedBox(width: 16 * Scale.width),
                Text(
                  "버전정보",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 16.0),
                ),
              ],
            ),
            SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
          ],
        )
      ],
    );
  }
}
