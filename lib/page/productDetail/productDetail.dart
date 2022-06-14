import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/controller/productDetailController.dart';
import 'package:cloth_collection/controller/recentViewController.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/page/SearchByText/searchByText.dart';
import 'package:cloth_collection/page/order/order.dart';
import 'package:cloth_collection/page/productDetail/widget/review.dart';
import 'package:cloth_collection/page/qna/qna.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/appbar/rating_bar.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../../bloc/bloc.dart';
import '../../bloc/cart_bloc/bloc/cart_state.dart';

class ProductDetail extends StatefulWidget {
  final int productId;
  ProductDetail({required this.productId});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  final RecentViewController recentViewController = RecentViewController();
  final ProductDetailController productDetailController =
      ProductDetailController();
  final PageController pageController = PageController();
  late TabController _controller;
  late NavigatorState navigator;
  late Future recommandProductFuture;
  late Future productDetailInfo;
  @override
  void initState() {
    super.initState();
    recentViewController.dataInit();
    recentViewController.insertRecentView(
      widget.productId,
    );
    productDetailInfo =
        productDetailController.getProductDetailInfo(widget.productId);
    recommandProductFuture = productDetailController.getRecommandProductInfo();
    _controller = TabController(length: 4, vsync: this);

    pageController.addListener(() {
      productDetailController.changeOffset(pageController.offset);
    });
  }

  @override
  void didChangeDependencies() {
    navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    productDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent // status bar 색깔
            ));
    return Builder(builder: (context) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65 * Scale.height),
            child: _buildAppBar()),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          top: false,
          bottom: true,
          child: SingleChildScrollView(
            controller: pageController,
            child: _buildScroll(),
          ),
        ),
        bottomNavigationBar: FutureBuilder(
            future: productDetailInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildBottomNaviagationBar();
                } else {
                  return ErrorCard();
                }
              } else {
                return progressBar();
              }
            }),
      );
    });
  }

  Widget _buildAppBar() {
    return GetBuilder<ProductDetailController>(
        init: productDetailController,
        builder: (controller) {
          return AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 22 * Scale.width),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset("assets/images/svg/cart.svg",
                      width: 26 * Scale.width, height: 26 * Scale.height),
                ),
              )
            ],
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white.withOpacity(controller.opacity),
            elevation: 0.0,
          );
        });
  }

  Widget _buildScroll() {
    return FutureBuilder(
      future: productDetailInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  ImageSlideHasDot(
                      imageList: productDetailController.productInfo.images),
                  SizedBox(height: 10 * Scale.height),
                  _buildShortProductInfo(),
                  SizedBox(height: 14 * Scale.height),
                  _buildProductInfo(),
                  _buildDiscountPriceArea(),
                  _buildDivider(),
                  _buildSatisfaction(),
                  _buildDivider(),
                  _buildSampleReivew(),
                  productQnA(),
                  recommandProductArea(),
                ],
              ),
            );
          } else {
            return Container(
              width: 414 * Scale.width,
              height: 896 * Scale.height,
              child: Center(child: ErrorCard()),
            );
          }
        } else
          return Container(
            width: 414 * Scale.width,
            height: 896 * Scale.height,
            child: progressBar(),
          );
      },
    );
  }

  Widget _buildShortProductInfo() {
    return Center(
      child: Container(
        width: 391 * Scale.width,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16 * Scale.width, vertical: 20 * Scale.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "카테고리",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0 * Scale.width),
                    child:
                        SvgPicture.asset("assets/images/svg/categoryArrow.svg"),
                  ),
                  Text(
                    productDetailController.productInfo.mainCategory['name'],
                    style: textStyle(const Color(0xff555555), FontWeight.w500,
                        "NotoSansKR", 13.0),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0 * Scale.width),
                    child:
                        SvgPicture.asset("assets/images/svg/categoryArrow.svg"),
                  ),
                  Text(
                    productDetailController.productInfo.subCategory['name'],
                    style: textStyle(const Color(0xff555555), FontWeight.w500,
                        "NotoSansKR", 13.0),
                  )
                ],
              ),
              SizedBox(height: 13.5 * Scale.height),
              Text(
                "${productDetailController.productInfo.name}",
                style: textStyle(const Color(0xff555555), FontWeight.w500,
                    "NotoSansKR", 20.0),
              ),
              SizedBox(height: 13 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${productDetailController.productInfo.baseDiscountRate}%",
                        style: textStyle(const Color(0xffec5363),
                            FontWeight.w500, "NotoSansKR", 20.0),
                      ),
                      SizedBox(width: 5 * Scale.width),
                      Text(
                        "${setPriceFormat(productDetailController.productInfo.baseDiscountedPrice)}원",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w700, "NotoSansKR", 20.0),
                      ),
                      SizedBox(width: 10 * Scale.width),
                      Text(
                        "${setPriceFormat(productDetailController.productInfo.salePrice)}원",
                        style: TextStyle(
                            color: const Color(0xff797979),
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSansKR",
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                  Text(
                    "(200원 적립)",
                    style: textStyle(const Color(0xff797979), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12 * Scale.height),
                child: Divider(
                  thickness: 1,
                  color: const Color(0xffeeeeee),
                ),
              ),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "(회원가)",
                        style: textStyle(const Color(0xffec5363),
                            FontWeight.w400, "NotoSansKR", 15.0),
                      ),
                      SizedBox(width: 5 * Scale.width),
                      Text(
                        "${setPriceFormat(12660)}~${setPriceFormat(24690)}원",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w700, "NotoSansKR", 18.0),
                      ),
                    ],
                  ),
                  SizedBox(width: 8 * Scale.width),
                  SvgPicture.asset("assets/images/svg/triangleDropdown.svg"),
                ],
              ),
              SizedBox(height: 10 * Scale.height),
              _buildHashTag(),
              SizedBox(height: 10 * Scale.height),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildRatingBar(16, 4.5),
                  SizedBox(width: 10 * Scale.width),
                  Row(
                    children: [
                      Text(
                        "17개 리뷰보기",
                        style: textStyle(const Color(0xff999999),
                            FontWeight.w400, "NotoSansKR", 13.0),
                      ),
                      SvgPicture.asset("assets/images/svg/categoryArrow.svg")
                    ],
                  )
                ],
              ),
              SizedBox(height: 22 * Scale.height),
              Container(
                width: 560 * Scale.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/svg/coupon.svg"),
                    SizedBox(width: 13 * Scale.width),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              style: textStyle(Color(0xffec5363),
                                  FontWeight.w400, "NotoSansKR", 12.0),
                              text: "최대 "),
                          TextSpan(
                              style: textStyle(const Color(0xffec5363),
                                  FontWeight.w500, "NotoSansKR", 14.0),
                              text: "4000원 할인 "),
                          TextSpan(
                              style: textStyle(const Color(0xffec5363),
                                  FontWeight.w400, "NotoSansKR", 12.0),
                              text: "쿠폰 받기")
                        ],
                      ),
                    ),
                  ],
                ),
                height: 50 * Scale.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: const Color(0xffffe4e7), width: 1),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x1ab57878),
                        offset: Offset(0, 2),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                  color: const Color(0xfffff7f8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountPriceArea() {
    return Padding(
      padding: EdgeInsets.only(
          top: 33 * Scale.height,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "최대 할인가",
                style: textStyle(const Color(0xff555555), FontWeight.w700,
                    "NotoSansKR", 14.0),
              ),
              Text(
                "${setPriceFormat(16000)}원",
                style: textStyle(const Color(0xff555555), FontWeight.w700,
                    "NotoSansKR", 14.0),
              ),
            ],
          ),
          SizedBox(height: 13 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "쿠폰 할인",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
              Text(
                "-${setPriceFormat(1000)}원",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ],
          ),
          SizedBox(height: 13 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "적립금 사용",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
              Text(
                "-${setPriceFormat(6000)}원",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ],
          ),
          SizedBox(height: 13 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "맴버십 할인 (골드 : 2%)",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
              Text(
                "-${setPriceFormat(350)}원",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ],
          ),
          SizedBox(height: 40 * Scale.height),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/svg/parcel.svg"),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          style: textStyle(const Color(0xff666666),
                              FontWeight.w400, "NotoSansKR", 14.0),
                          text: "전 상품 모두 "),
                      TextSpan(
                          style: textStyle(Color(0xff333333), FontWeight.w500,
                              "NotoSansKR", 14.0),
                          text: "무료배송, 무료반품")
                    ],
                  ),
                ),
              ],
            ),
            width: 560 * Scale.width,
            height: 40 * Scale.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: const Color(0xfffafafa),
            ),
          ),
          SizedBox(height: 13 * Scale.height),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 13.0),
                    text: "배송:일반배송 "),
                TextSpan(
                    style: textStyle(
                        Color(0xff333333), FontWeight.w500, "NotoSansKR", 12.0),
                    text: " (영업일 기준 3~7일)"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      children: [
        _buildProductImages(),
        SizedBox(height: 24 * Scale.height),
        _buildDetailInfoButton(),
      ],
    );
  }

  Widget _buildProductImages() {
    return Padding(
      padding: EdgeInsets.only(left: 22 * Scale.width),
      child: Container(
        width: 414 * Scale.width,
        height: 140 * Scale.height,
        child: ListView.builder(
          itemCount: productDetailController.productInfo.images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3 * Scale.width),
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.0),
                  ),
                  child: CachedNetworkImage(
                    width: 140 * 3 / 4 * Scale.height,
                    fit: BoxFit.fill,
                    imageUrl:
                        "${productDetailController.productInfo.images[index]['image_url']}",
                  ),
                ),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _buildHashTag() {
    return Container(
      height: 25 * Scale.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: productDetailController.productInfo.tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 4 * Scale.width),
            child: GestureDetector(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5 * Scale.width),
                    child: Text(
                        "#" +
                            "${productDetailController.productInfo.tags[index]['name']} ",
                        style: textStyle(const Color(0xff0090ff),
                            FontWeight.w400, "NotoSansKR", 14.0)),
                  ),
                ),
              ),
              onTap: () {
                Get.to(() => SearchByText(
                    productDetailController.productInfo.tags[index]['name']));
              },
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildDetailInfoButton() {
    return Center(
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "상품 상세 펼치기 ",
              style: textStyle(
                  Color(0xff555555), FontWeight.w500, "NotoSansKR", 15.0),
            ),
            SvgPicture.asset("assets/images/svg/unfoldInfo.svg")
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(color: const Color(0xffeaedf0), width: 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
              Size(370 * Scale.width, 44 * Scale.height)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xfffafafa)),
        ),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              context: context,
              builder: productDetailBottomSheetArea);
        },
      ),
    );
  }

  Widget productDetailBottomSheetArea(BuildContext context) {
    final productInfo = productDetailController.productInfo;
    return Container(
      height: 565 * Scale.height,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 25 * Scale.height, bottom: 30 * Scale.height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "상품 상세 설명",
                    style: textStyle(
                        Color(0xff333333), FontWeight.w500, "NotoSansKR", 18.0),
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      "assets/images/svg/close.svg",
                      width: 22 * Scale.width,
                      height: 22 * Scale.width,
                      fit: BoxFit.scaleDown,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            showdetailInfo("스타일", productInfo.style['name']),
            showdetailInfo("테마", productInfo.theme['name']),
            showdetailInfo("제조국", productInfo.manufacturingCountry),
            showdetailInfo("두께감", productInfo.thickness['name']),
            showdetailInfo("비침", productInfo.seeThrough['name']),
            showdetailInfo("신축성", productInfo.flexibility['name']),
            showdetailInfo("안감", productInfo.lining ? "존재" : "없음"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: productInfo.materials.length,
                itemBuilder: ((context, index) {
                  return showdetailInfo(
                      productInfo.materials[index]['material'],
                      productInfo.materials[index]['mixing_rate'].toString());
                })),
          ],
        ),
      ),
    );
  }

  Widget showdetailInfo(String subject, String info) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14 * Scale.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$subject",
              style: textStyle(
                  Color(0xff999999), FontWeight.w400, "NotoSansKR", 16.0)),
          Text("$info",
              style: textStyle(
                  Color(0xff333333), FontWeight.w400, "NotoSansKR", 16.0))
        ],
      ),
    );
  }

  Widget _buildSatisfaction() {
    return Padding(
      padding: EdgeInsets.only(
          left: 22 * Scale.width,
          right: 22 * Scale.width,
          top: 25 * Scale.height),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "구매 만족도",
              style: textStyle(
                  const Color(0xff333333), FontWeight.w500, "NotoSansKR", 18.0),
            ),
            SizedBox(height: 12 * Scale.height),
            Container(
              height: 55 * Scale.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: const Color(0xfff9fcff),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14 * Scale.width),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildRatingBar(24, 4.8),
                    RichText(
                      text: TextSpan(
                        text: "4.8",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w700, "NotoSansKR", 24.0),
                        children: [
                          TextSpan(
                            text: " / 5",
                            style: textStyle(const Color(0xffcccccc),
                                FontWeight.w700, "NotoSansKR", 24.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("사이즈",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.0)),
                Text("딱 맞았어요(71%)",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 14.0)),
              ],
            ),
            SizedBox(height: 6 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("색감",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.0)),
                Text("화면과 같아요(87%)",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 14.0)),
              ],
            ),
            SizedBox(height: 6 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("퀄리티",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.0)),
                Text("괜찮아요(87%)",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 14.0)),
              ],
            ),
            SizedBox(height: 20 * Scale.height),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleReivew() {
    var tabList = [ReviewBox(), Text("1"), Text("2"), Text("3")];
    return Column(
      children: [
        SizedBox(height: 25 * Scale.height),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "리뷰",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 18.0),
                  children: [
                    TextSpan(
                      text: "(999+)",
                      style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                          "NotoSansKR", 16.0),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "포토 리뷰만 보기",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 14.0),
                  children: [
                    TextSpan(
                      text: " (999+)",
                      style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                          "NotoSansKR", 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16 * Scale.height),
        Container(
          width: 414 * Scale.width,
          height: 44 * Scale.height,
          child: Material(
            color: const Color(0xfff8f9fb),
            child: TabBar(
              controller: _controller,
              indicatorWeight: 3.0,
              indicatorColor: const Color(0xffec5363),
              labelColor: const Color(0xffec5363),
              labelStyle: textStyle(
                  const Color(0xff999999), FontWeight.w500, "NotoSansKR", 14.0),
              unselectedLabelColor: const Color(0xff999999),
              tabs: [
                Tab(
                  child: Text(
                    "베스트",
                  ),
                ),
                Tab(
                  child: Text(
                    "별점높은순",
                  ),
                ),
                Tab(
                  child: Text(
                    "별점낮은순",
                  ),
                ),
                Tab(
                  child: Text(
                    "최신순",
                  ),
                ),
              ],
              onTap: (index) {
                productDetailController.reviewTabClicked(index);
              },
            ),
          ),
        ),
        GetBuilder<ProductDetailController>(
          id: 'review',
          init: productDetailController,
          builder: (controller) {
            return tabList[productDetailController.reviewTabIndex];
          },
        )
      ],
    );
  }

  Widget _buildBottomNaviagationBar() {
    bool isLike = productDetailController.productInfo.shopperLike;
    return BlocProvider<LikeBloc>(
      create: (context) => LikeBloc(),
      child: Container(
        height: 120 * Scale.height,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(offset: Offset(0, 2), blurRadius: 3, spreadRadius: 0)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LikeBloc, LikeState>(
              builder: (context, state) {
                return StatefulBuilder(builder: (context, setState) {
                  return InkWell(
                    child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: const Color(0xffeeeeee),
                        ),
                        child: Center(
                          child: SvgPicture.asset(isLike
                              ? "assets/images/svg/bottomNavigationLike.svg"
                              : "assets/images/svg/bottomNavigationUnlike.svg"),
                        )),
                    onTap: () {
                      Vibrate.feedback(VIBRATETYPE);
                      setState(
                        () {
                          isLike = !isLike;
                        },
                      );
                      context.read<LikeBloc>().add(ClickLikeButtonEvent(
                          productId:
                              productDetailController.productInfo.id.toString(),
                          isLike: isLike));
                    },
                  );
                });
              },
            ),
            SizedBox(width: 8 * Scale.width),
            TextButton(
              child: Text("구매하기",
                  style: textStyle(const Color(0xffffffff), FontWeight.w500,
                      "NotoSansKR", 18.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(310 * Scale.width, 52)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xffec5363)),
              ),
              onPressed: () {
                Vibrate.feedback(VIBRATETYPE);
                showModalBottomSheet<void>(
                  isDismissible: false,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => Stack(
                    children: [
                      GestureDetector(
                        child: Container(
                            width: 414 * Scale.width,
                            height: 896 * Scale.height,
                            color: Colors.transparent),
                        onTap: Navigator.of(context).pop,
                      ),
                      Positioned(
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.6,
                          maxChildSize: 1.0,
                          builder: (_, controller) {
                            return BuyingBottomSheet(
                              productDetailController: productDetailController,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget productQnA() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => QnA(productId: widget.productId))));
      },
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20 * Scale.width, vertical: 15 * Scale.height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "상품문의",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 20.0),
                ),
                Icon(Icons.keyboard_arrow_right, size: 30),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget recommandProductArea() {
    return FutureBuilder(
        future: recommandProductFuture,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                    child: Text("다른상품은 어때요?",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w500, "NotoSansKR", 18.0)),
                  ),
                  SizedBox(height: 22 * Scale.height),
                  Container(
                    height: 300 * Scale.height,
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5 * Scale.width),
                            child: ProductCard(
                                product: Product.fromJson(snapshot.data[index]),
                                imageWidth: 100),
                          );
                        }),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return ErrorCard();
            } else {
              return progressBar();
            }
          } else {
            return progressBar();
          }
        });
  }
}

class BuyingBottomSheet extends StatefulWidget {
  final ProductDetailController productDetailController;
  BuyingBottomSheet({required this.productDetailController});

  @override
  _BuyingBottomSheetState createState() => _BuyingBottomSheetState();
}

class _BuyingBottomSheetState extends State<BuyingBottomSheet> {
  OrderBloc orderBloc = OrderBloc();
  late CartBloc cartBloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedShow = 1;

  @override
  void initState() {
    super.initState();
    widget.productDetailController.initController();
  }

  @override
  Widget build(BuildContext context) {
    cartBloc = CartBloc(orderBloc: orderBloc);
    var bottomSheetView = [selectedOptionArea(), buyingBottomSheetArea()];
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => orderBloc),
        BlocProvider(create: (context) => cartBloc)
      ],
      child: Container(
        child: bottomSheetView[selectedShow],
      ),
    );
  }

  Widget selectedOptionArea() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Stack(children: [
          Container(
            width: 414 * Scale.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 25 * Scale.height, bottom: 30 * Scale.height),
                    child: Text("옵션 선택하기",
                        style: textStyle(Color(0xff333333), FontWeight.w700,
                            "NotoSansKR", 18.0)),
                  ),
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              colorOptionButtonArea(),
                              sizeOptionButtonArea(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 35 * Scale.height),
                    child: TextButton(
                      child: Text("선택완료",
                          style: textStyle(Color(0xff333333), FontWeight.w500,
                              "NotoSansKR", 16.0)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: const Color(0xffcccccc), width: 1),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(370 * Scale.width, 52 * Scale.height)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xfff0f5f9)),
                      ),
                      onPressed: () {
                        selectedShow = 1;
                        widget.productDetailController.pushProduct();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15 * Scale.width,
            right: 15 * Scale.width,
            child: GestureDetector(
              child: SvgPicture.asset("assets/images/svg/close.svg",
                  width: 22 * Scale.width,
                  height: 22 * Scale.width,
                  fit: BoxFit.scaleDown),
              onTap: () {
                selectedShow = 1;
                widget.productDetailController.selectedSizeIndex = -1;
                widget.productDetailController.selectedColorIndex = -1;
                setState(() {});
              },
            ),
          )
        ]);
      },
    );
  }

  Widget colorOptionButtonArea() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: GetBuilder<ProductDetailController>(
              init: widget.productDetailController,
              builder: (controller) => GestureDetector(
                child: Container(
                  width: 370 * Scale.width,
                  height: 52 * Scale.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffcccccc)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.selectedColorIndex == -1
                            ? Text("색상 선택",
                                style: textStyle(const Color(0xffcccccc),
                                    FontWeight.w400, "NotoSansKR", 16.0))
                            : Text(
                                "${controller.colorData[controller.selectedColorIndex]['display_color_name']}",
                                style: textStyle(const Color(0xff333333),
                                    FontWeight.w500, "NotoSansKR", 16.0)),
                        SvgPicture.asset(controller.isColorButtonClicked
                            ? "assets/images/svg/dropUp.svg"
                            : "assets/images/svg/dropdown.svg")
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  controller.clickedColorButton();
                },
              ),
            ),
          ),
          GetBuilder<ProductDetailController>(
            init: widget.productDetailController,
            builder: (controller) => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.colorCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8 * Scale.height),
                  child: GestureDetector(
                    child: Container(
                      width: 370 * Scale.width,
                      height: 52 * Scale.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: controller.selectedColorIndex == index
                            ? Color(0xffebf7f1)
                            : Color(0xfffafafa),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14 * Scale.width),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${controller.colorData[index]["display_color_name"]}",
                              style: textStyle(Color(0xff333333),
                                  FontWeight.w500, "NotoSansKR", 16.0),
                            ),
                            SvgPicture.asset(
                                controller.selectedColorIndex == index
                                    ? "assets/images/svg/termaccept.svg"
                                    : "assets/images/svg/termcheck.svg",
                                width: 20 * Scale.width,
                                height: 20 * Scale.width,
                                fit: BoxFit.scaleDown)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      controller.selectColor(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sizeOptionButtonArea() {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: GetBuilder<ProductDetailController>(
            init: widget.productDetailController,
            builder: (controller) => GestureDetector(
              child: Container(
                width: 370 * Scale.width,
                height: 52 * Scale.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xffcccccc)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.selectedSizeIndex == -1
                          ? Text("사이즈 선택",
                              style: textStyle(const Color(0xffcccccc),
                                  FontWeight.w400, "NotoSansKR", 16.0))
                          : Text(
                              "${controller.sizeData[controller.selectedSizeIndex]}",
                              style: textStyle(const Color(0xff333333),
                                  FontWeight.w500, "NotoSansKR", 16.0)),
                      SvgPicture.asset(controller.isSizeButtonClicked
                          ? "assets/images/svg/dropUp.svg"
                          : "assets/images/svg/dropdown.svg")
                    ],
                  ),
                ),
              ),
              onTap: () {
                controller.clickedSizeButton();
              },
            ),
          ),
        ),
        GetBuilder<ProductDetailController>(
          init: widget.productDetailController,
          builder: (controller) => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.sizeCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8 * Scale.height),
                child: GestureDetector(
                  child: Container(
                    width: 370 * Scale.width,
                    height: 52 * Scale.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.selectedSizeIndex == index
                          ? Color(0xffebf7f1)
                          : Color(0xfffafafa),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14 * Scale.width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${controller.sizeData[index]}",
                            style: textStyle(Color(0xff333333), FontWeight.w500,
                                "NotoSansKR", 16.0),
                          ),
                          SvgPicture.asset(
                              controller.selectedSizeIndex == index
                                  ? "assets/images/svg/termaccept.svg"
                                  : "assets/images/svg/termcheck.svg",
                              width: 20 * Scale.width,
                              height: 20 * Scale.width,
                              fit: BoxFit.scaleDown)
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.selectSize(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget buyingBottomSheetArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 25 * Scale.height, bottom: 20 * Scale.height),
            child: TextButton(
              child: Text("옵션 선택하기",
                  style: textStyle(
                      Color(0xff333333), FontWeight.w500, "NotoSansKR", 16.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: const Color(0xffcccccc)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(370 * Scale.width, 60 * Scale.height)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xffffffff)),
              ),
              onPressed: () {
                selectedShow = 0;
                setState(() {});
              },
            ),
          ),
          GetBuilder<ProductDetailController>(
            init: widget.productDetailController,
            builder: (controller) {
              return Expanded(
                child: Center(
                  child: ListView.builder(
                      itemCount: controller.productCart.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            selectedProductBox(index),
                            SizedBox(height: 8 * Scale.height),
                          ],
                        );
                      }),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 13 * Scale.height, bottom: 26 * Scale.height),
                  child: GetBuilder<ProductDetailController>(
                    init: widget.productDetailController,
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${widget.productDetailController.totalProductCount}개 상품 금액",
                              style: textStyle(const Color(0xff999999),
                                  FontWeight.w400, "NotoSansKR", 14.0)),
                          Text("${setPriceFormat(controller.totalPrice)}원",
                              style: textStyle(const Color(0xffec5363),
                                  FontWeight.w400, "NotoSansKR", 16.0))
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35 * Scale.height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10 * Scale.height),
                          BlocConsumer<CartBloc, CartState>(
                            listener: ((context, state) {
                              if (state.registToCartState == ApiState.success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('장바구니에 등록되었습니다.'),
                                  ),
                                );
                              }
                            }),
                            builder: (context, state) {
                              return TextButton(
                                child: Text("장바구니",
                                    style: textStyle(Color(0xff333333),
                                        FontWeight.w500, "NotoSansKR", 16.0)),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size(118 * Scale.width,
                                          52 * Scale.height)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xfff0f5f9)),
                                ),
                                onPressed: () {
                                  if (widget.productDetailController.productCart
                                      .isNotEmpty) {
                                    context.read<CartBloc>().add(
                                        ClickShoppingBasketEvent(
                                            cart: widget.productDetailController
                                                .productCart));
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: 8 * Scale.width),
                      Column(
                        children: [
                          SizedBox(height: 10 * Scale.height),
                          BlocBuilder<OrderBloc, OrderState>(
                            builder: (context, state) {
                              return TextButton(
                                child: Text("바로구매",
                                    style: textStyle(const Color(0xffffffff),
                                        FontWeight.w500, "NotoSansKR", 16.0)),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size(118 * Scale.width,
                                          52 * Scale.height)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff333333)),
                                ),
                                onPressed: () {
                                  context.read<OrderBloc>().add(
                                      AddProductToCartEvent(
                                          orderProduct: widget
                                              .productDetailController
                                              .productCart));

                                  if (widget.productDetailController.productCart
                                      .isNotEmpty) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: ((context) => Order(
                                                  orderBloc: orderBloc,
                                                ))));
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: 8 * Scale.width),
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(height: 10 * Scale.height),
                              TextButton(
                                child: Text("0원 배송",
                                    style: textStyle(const Color(0xffffffff),
                                        FontWeight.w500, "NotoSansKR", 16.0)),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size(118 * Scale.width,
                                          52 * Scale.height)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xffec5363)),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Positioned(
                              top: -5 * Scale.height,
                              left: -5 * Scale.width,
                              child: SvgPicture.asset(
                                  "assets/images/svg/crown.svg")),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedProductBox(int index) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 370 * Scale.width,
            height: 102 * Scale.height,
            color: const Color(0xfffafafa),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14 * Scale.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14 * Scale.height),
                  Text(
                    "${widget.productDetailController.productCart[index].color} / ${widget.productDetailController.productCart[index].size}",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8 * Scale.height),
                    child: Text(
                      "kinds of delivery",
                      style: textStyle(const Color(0xff333333), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              child: SvgPicture.asset(
                                  "assets/images/svg/minus.svg",
                                  width: 18 * Scale.width,
                                  height: 18,
                                  fit: BoxFit.scaleDown),
                              onTap: () {
                                widget.productDetailController
                                    .substractProductCount(index);
                              }),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8 * Scale.width),
                            child: Text(
                              "${widget.productDetailController.productCart[index].count}",
                              style: textStyle(const Color(0xff444444),
                                  FontWeight.w400, "NotoSansKR", 14.0),
                            ),
                          ),
                          GestureDetector(
                              child: SvgPicture.asset(
                                  "assets/images/svg/plus.svg",
                                  width: 18 * Scale.width,
                                  height: 18,
                                  fit: BoxFit.scaleDown),
                              onTap: () {
                                widget.productDetailController
                                    .addProductCount(index);
                              }),
                        ],
                      ),
                      Text(
                        "${setPriceFormat(widget.productDetailController.productCart[index].count * widget.productDetailController.productCart[index].baseDiscountedPrice)}원",
                        style: textStyle(Color(0xff333333), FontWeight.w500,
                            "NotoSansKR", 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12 * Scale.width,
            right: 12 * Scale.width,
            child: GestureDetector(
                child: SvgPicture.asset("assets/images/svg/productCancel.svg"),
                onTap: () {
                  widget.productDetailController.popProduct(index);
                }),
          ),
        ],
      ),
    );
  }
}

Widget _buildDivider() {
  return Divider(
      thickness: 7, indent: 0, endIndent: 0, color: Colors.grey[100]);
}
