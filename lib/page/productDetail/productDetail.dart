import 'package:cloth_collection/controller/recentViewController.dart';
import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/page/productDetail/widget/productRecommentcard.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  final DBHelper _dbHelper = DBHelper();
  final RecentViewController recentViewController = RecentViewController();
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    recentViewController.dataInit(_dbHelper);
    recentViewController.insertRecentView(
        widget.product.productCode, _dbHelper);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: _buildAppBar(),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [_buildScroll()],
          ),
        ),
        bottomNavigationBar: _buildBottomNaviagationBar(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left, size: 35.0),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 22 * Scale.width),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset("assets/images/svg/shopping_basket.svg"),
          ),
        )
      ],
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget _buildScroll() {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xffffffff),
        child: Column(
          children: [
            ImageSlideHasDot(),
            SizedBox(height: 10 * Scale.height),
            _buildShortProductInfo(),
            SizedBox(height: 14 * Scale.height),
            _buildProductInfo(),
            _buildDivider(),
            _buildSatisfaction(),
            _buildDivider(),
            _buildSampleReivew(),
            _buildProductRecommend(),
          ],
        ),
      ),
    );
  }

  Widget _buildShortProductInfo() {
    return Center(
      child: Container(
        width: 391 * Scale.width,
        height: 122 * Scale.height,
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
          padding: EdgeInsets.only(
              left: 16 * Scale.width,
              right: 16 * Scale.width,
              top: 20 * Scale.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [],
              ),
              Text(
                "${widget.product.name}",
                style: textStyle(const Color(0xff333333), FontWeight.w500,
                    "NotoSansKR", 18.sp),
              ),
              SizedBox(height: 3 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    setPriceFormat(widget.product.price),
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 20.sp),
                  ),
                  Row(
                    children: [
                      _buildRatingBar(14),
                      SizedBox(width: 3 * Scale.width),
                      Text(
                        "(17)",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w500, "NotoSansKR", 13.0),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      children: [
        _buildProductCardByColor(),
        SizedBox(height: 24 * Scale.height),
        _buildHashTag(),
        SizedBox(height: 32 * Scale.height),
        _buildDetailInfoButton(),
      ],
    );
  }

  Widget _buildProductCardByColor() {
    return Padding(
      padding: EdgeInsets.only(left: 22 * Scale.width),
      child: Container(
        width: 414 * Scale.width,
        height: 140 * Scale.height,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Column(
                children: [
                  Card(
                    child: new Container(
                      width: 70 * Scale.width,
                      height: 90 * Scale.height,
                      child: new Text('Product\n Image'),
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    "color",
                    style: textStyle(Color.fromRGBO(153, 153, 153, 1),
                        FontWeight.w500, "NotoSansKR", 14.0),
                  )
                ],
              ),
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _buildHashTag() {
    return Padding(
      padding: EdgeInsets.only(left: 22 * Scale.width),
      child: Container(
        height: 30 * Scale.height,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 4 * Scale.width),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Color.fromRGBO(234, 237, 240, 1),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5 * Scale.width),
                    child: Text("#" + "HashTag ",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w500, "NotoSansKR", 13.sp)),
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

  Widget _buildDetailInfoButton() {
    return Center(
      child: OutlinedButton(
        child: Text("상품 상세 펼치기",
            style: TextStyle(color: Color(0xff555555), fontSize: 16.sp)),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(color: const Color(0xffeaedf0), width: 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
              Size(370 * Scale.width, 44 * Scale.height)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xfffafafa)),
        ),
        onPressed: () {},
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
              style: textStyle(const Color(0xff333333), FontWeight.w500,
                  "NotoSansKR", 18.sp),
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
                    _buildRatingBar(24),
                    RichText(
                      text: TextSpan(
                        text: "4.8",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w700, "NotoSansKR", 24.sp),
                        children: [
                          TextSpan(
                            text: " / 5",
                            style: textStyle(const Color(0xffcccccc),
                                FontWeight.w700, "NotoSansKR", 24.sp),
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
                        "NotoSansKR", 14.sp)),
                Text("딱 맞았어요(71%)",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 14.sp)),
              ],
            ),
            SizedBox(height: 6 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("색감",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.sp)),
                Text("화면과 같아요(87%)",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 14.sp)),
              ],
            ),
            SizedBox(height: 6 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("퀄리티",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.sp)),
                Text("괜찮아요(87%)",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 14.sp)),
              ],
            ),
            SizedBox(height: 20 * Scale.height),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleReivew() {
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
                      "NotoSansKR", 18.sp),
                  children: [
                    TextSpan(
                      text: "(999+))",
                      style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                          "NotoSansKR", 16.sp),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "포토 리뷰만 보기",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 14.sp),
                  children: [
                    TextSpan(
                      text: " (999+)",
                      style: textStyle(const Color(0xffcccccc), FontWeight.w400,
                          "NotoSansKR", 14.sp),
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
          child: TabBar(
            controller: _controller,
            tabs: [
              Container(
                color: const Color(0xfff8f9fb),
                child: Text("베스트",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 14.sp)),
              ),
              Container(
                color: const Color(0xfff8f9fb),
                child: Text("별점높은순",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 14.sp)),
              ),
              Container(
                color: const Color(0xfff8f9fb),
                child: Text("별점낮은순",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 14.sp)),
              ),
              Container(
                color: const Color(0xfff8f9fb),
                child: Text("최신순",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 14.sp)),
              ),
            ],
          ),
        ),
        Container(
          width: 414 * Scale.width,
          height: 50,
          child: TabBarView(
            controller: _controller,
            children: [
              Container(height: 15, child: Text("1")),
              Container(height: 15, child: Text("1")),
              Container(height: 15, child: Text("1")),
              Container(height: 15, child: Text("1")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductRecommend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
          child: Text("여기 마켓의\n다른상품은 어때요?",
              style: textStyle(const Color(0xff333333), FontWeight.w500,
                  "NotoSansKR", 18.0)),
        ),
        SizedBox(height: 22),
        Container(
          height: 300,
          child: ListView(
            // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
            scrollDirection: Axis.horizontal,
            // 컨테이너들을 ListView의 자식들로 추가
            children: <Widget>[
              SizedBox(width: 22 * Scale.width),
              ProductRecommentCard(widget.product),
              SizedBox(width: 22 * Scale.width),
              ProductRecommentCard(widget.product),
              SizedBox(width: 22 * Scale.width),
              ProductRecommentCard(widget.product),
              SizedBox(width: 22 * Scale.width),
              ProductRecommentCard(widget.product),
              SizedBox(width: 22 * Scale.width),
              ProductRecommentCard(widget.product),
            ],
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }

  Widget _buildBottomNaviagationBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(offset: Offset(0, 2), blurRadius: 3, spreadRadius: 0)
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
            child: InkWell(
              child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: const Color(0xffeeeeee),
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/images/svg/heart.svg"),
                  )),
              onTap: () {
                Vibrate.feedback(VIBRATETYPE);
              },
            ),
          ),
          TextButton(
              child: Text("매장과 채팅",
                  style: textStyle(const Color(0xffec5363), FontWeight.w500,
                      "NotoSansKR", 16.0)),
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: const Color(0xffec5363), width: 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(144 * Scale.width, 52)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {}),
          SizedBox(width: 8 * Scale.width),
          TextButton(
              child: Text("구매하기",
                  style: textStyle(const Color(0xffffffff), FontWeight.w500,
                      "NotoSansKR", 16.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(144 * Scale.width, 52)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xffec5363)),
              ),
              onPressed: () {
                Vibrate.feedback(VIBRATETYPE);
              }),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int size) {
    return RatingBarIndicator(
      rating: 4.8, // 상품 평점
      itemCount: 5,
      itemSize: size * Scale.width,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: const Color(0xffffbe3f),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
        thickness: 7, indent: 0, endIndent: 0, color: Colors.grey[100]);
  }
}
