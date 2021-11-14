import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/page/productDetail/widget/productRecommentcard.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: _buildAppBar(width),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [_buildScroll(width, height)],
          ),
        ),
        bottomNavigationBar: _buildBottomNaviagationBar(width, height),
      ),
    );
  }

  AppBar _buildAppBar(double width) {
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
          padding: EdgeInsets.only(right: width * 0.053),
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

  Widget _buildScroll(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageSlideHasDot(width, width * 0.82),
          _buildStoreInfo(width, height),
          Divider(
            thickness: 1.5,
            color: const Color(0xffeeeeee),
            indent: 22,
            endIndent: 22,
          ),
          _buildProductInfo(width, height),
          _buildProductRecommend(width, height),
        ],
      ),
    );
  }

  Widget _buildStoreInfo(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(top: 24, left: 22, bottom: 20),
      child: Row(
        children: [
          Container(
            width: width * 0.13,
            height: width * 0.13,
            child: ClipRRect(
              child: Image.asset(widget.product.image),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          SizedBox(width: width * 0.039),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.product.store}",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 16.0),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  SvgPicture.asset("assets/images/svg/location.svg"),
                  SizedBox(width: width * 0.01),
                  Text(
                    "${widget.product.location}",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductInfo(double width, double height) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //대표적인 정보
          _buildProductRepresentativeInfo(width, height),
          _buildDivider(),
          SizedBox(height: 14),
          _buildProductDetailInfo(width, "색상", "블랙 그레이 오트 바이올렛"),
          SizedBox(height: 14),
          _buildProductDetailInfo(width, "사이즈", "FREE"),
          SizedBox(height: 14),
          _buildProductDetailInfo(width, "혼용률", "해당 없음"),
          SizedBox(height: 14),
          _buildProductDetailInfo(width, "제조국", "대한민국"),
          SizedBox(height: 14),
          _buildProductDetailInfo(width, "상품등록정보", "2021년 8월 등록"),
          SizedBox(height: 20),
          _buildDivider(),
          SizedBox(height: 30),
          _buildProductDescription(width, height),
          SizedBox(height: 30),
          _buildDivider(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProductRepresentativeInfo(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.053),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.product.category} > ${widget.product.subCategory}",
            style: textStyle(
                const Color(0xffbbbbbb), FontWeight.w400, "NotoSansKR", 13.0),
          ),
          SizedBox(height: 8),
          Text(
            "${widget.product.name}",
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 20.0),
          ),
          SizedBox(height: 4),
          Text(setPriceFormat(widget.product.price),
              style: textStyle(const Color(0xff333333), FontWeight.w700,
                  "NotoSansKR", 18.0)),
          SizedBox(height: 10),
          // Row(
          //   children: [
          //     RatingBarIndicator(
          //       rating: 5, // 상품 평점
          //       itemCount: 5,
          //       itemSize: width * 0.035,
          //       itemBuilder: (context, index) => Icon(
          //         Icons.star,
          //         color: const Color(0xffffbe3f),
          //       ),
          //     ),
          //     SizedBox(width: width * 0.015),
          //     Text(
          //       "4.5",
          //       style: textStyle(const Color(0xff333333), FontWeight.w500,
          //           "NotoSansKR", 13.0),
          //     )
          //   ],
          // ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProductDetailInfo(double width, String subject, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.053),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$subject"),
          Text("$content"),
        ],
      ),
    );
  }

  Widget _buildProductDescription(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.053),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.007,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xff333333),
                ),
              ),
              SizedBox(width: width * 0.017),
              Text("상품 상세설명",
                  style: const TextStyle(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0),
                  textAlign: TextAlign.left)
            ],
          ),
          SizedBox(height: 20),
          Text(
            "굳세게 인간의 같이 끝에 것이 품고 불어 사라지지 바로 석가는 설레는 가슴에 이것이다.\n 발휘하기 동력은 우리 바로 무한한 간에 칼이다. 스며들어 풍부하게 찾아다녀도, 설레는 그들에게 있는가? 풍부하게 가장 뼈 얼음과 예가 때에, 못할 커다란 이는 봄바람이다. 악이며, 힘차게 보내는 청춘의 있으랴? 가는 되려니와, 못할 노년에게서 봄바람을 청춘의 우리의 관현악이며, 것이다.",
            style: const TextStyle(
                color: const Color(0xff555555),
                fontWeight: FontWeight.w400,
                fontFamily: "NotoSansKR",
                fontStyle: FontStyle.normal,
                height: 1.6,
                fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildProductRecommend(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.053),
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
              SizedBox(width: width * 0.053),
              ProductRecommentCard(widget.product),
              SizedBox(width: width * 0.053),
              ProductRecommentCard(widget.product),
              SizedBox(width: width * 0.053),
              ProductRecommentCard(widget.product),
              SizedBox(width: width * 0.053),
              ProductRecommentCard(widget.product),
              SizedBox(width: width * 0.053),
              ProductRecommentCard(widget.product),
            ],
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }

  Widget _buildBottomNaviagationBar(double width, double height) {
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
            padding: EdgeInsets.symmetric(horizontal: width * 0.053),
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
                fixedSize:
                    MaterialStateProperty.all<Size>(Size(width * 0.348, 52)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {}),
          SizedBox(width: width * 0.019),
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
                fixedSize:
                    MaterialStateProperty.all<Size>(Size(width * 0.348, 52)),
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

  Widget _buildDivider() {
    return Divider(
        thickness: 7, indent: 0, endIndent: 0, color: Colors.grey[100]);
  }
}
