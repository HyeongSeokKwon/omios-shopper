import 'package:cloth_collection/controller/productDetailController.dart';
import 'package:cloth_collection/controller/recentViewController.dart';
import 'package:cloth_collection/data/exampleProduct.dart';
import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/page/productDetail/widget/productRecommentcard.dart';
import 'package:cloth_collection/page/productDetail/widget/review.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/appbar/rating_bar.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

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
        body: SingleChildScrollView(child: _buildScroll()),
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
    return Container(
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
          _buildDivider(),
          _buildProductRecommend(),
        ],
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
                    "NotoSansKR", 18.0),
              ),
              SizedBox(height: 3 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    setPriceFormat(widget.product.price),
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 20.0),
                  ),
                  Row(
                    children: [
                      buildRatingBar(14, 4.8),
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
                            FontWeight.w500, "NotoSansKR", 13.0)),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "상품 상세 펼치기",
              style: textStyle(
                  Color(0xff555555), FontWeight.w400, "NotoSansKR", 16.0),
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
              borderRadius: BorderRadius.circular(14.r),
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
                      "assets/images/svg/closeProductDetail.svg",
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
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
            showdetailInfo("subject", "info"),
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
              onTap: (value) {
                setState(() {});
              },
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
            ),
          ),
        ),
        tabList[_controller.index]
      ],
    );
  }

  Widget _buildProductRecommend() {
    return Padding(
      padding: EdgeInsets.only(top: 25 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
            child: Text("여기 마켓의 다른상품은 어때요?",
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
      ),
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
            padding: EdgeInsets.only(left: 22 * Scale.width),
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
              fixedSize:
                  MaterialStateProperty.all<Size>(Size(310 * Scale.width, 52)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffec5363)),
            ),
            onPressed: () {
              Vibrate.feedback(VIBRATETYPE);
              showModalBottomSheet(
                isDismissible: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (context) => DraggableScrollableSheet(
                  expand: true,
                  initialChildSize: 0.6,
                  maxChildSize: 1.0,
                  builder: (_, controller) {
                    return BuyingBottomSheet();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BuyingBottomSheet extends StatefulWidget {
  const BuyingBottomSheet({Key? key}) : super(key: key);

  @override
  _BuyingBottomSheetState createState() => _BuyingBottomSheetState();
}

class _BuyingBottomSheetState extends State<BuyingBottomSheet> {
  ProductDetailController productDetailController = ProductDetailController();
  int selectedShow = 1;
  @override
  void initState() {
    super.initState();
    productDetailController.initController();
  }

  @override
  Widget build(BuildContext context) {
    var bottomSheetView = [selectedOptionArea(), buyingBottomSheetArea()];
    return Container(
      child: bottomSheetView[selectedShow],
    );
  }

  Widget selectedOptionArea() {
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
                    style: textStyle(Color(0xff333333), FontWeight.w500,
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
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 35 * Scale.height),
                child: TextButton(
                  child: Text("선택완료",
                      style: textStyle(Color(0xff333333), FontWeight.w500,
                          "NotoSansKR", 16.0)),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    productDetailController.pushProduct();
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
          child: SvgPicture.asset("assets/images/svg/closeProductDetail.svg",
              width: 22 * Scale.width,
              height: 22 * Scale.width,
              fit: BoxFit.scaleDown),
          onTap: () {
            selectedShow = 1;
            setState(() {});
          },
        ),
      )
    ]);
  }

  Widget colorOptionButtonArea() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: GetBuilder<ProductDetailController>(
              init: productDetailController,
              builder: (_) => GestureDetector(
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
                        productDetailController.selectedColorIndex == -1
                            ? Text("색상 선택",
                                style: textStyle(const Color(0xffcccccc),
                                    FontWeight.w400, "NotoSansKR", 16.0))
                            : Text(
                                "${productDetailController.colorData[productDetailController.selectedColorIndex]}",
                                style: textStyle(const Color(0xff333333),
                                    FontWeight.w500, "NotoSansKR", 16.0)),
                        SvgPicture.asset(
                            productDetailController.isColorButtonClicked
                                ? "assets/images/svg/dropUp.svg"
                                : "assets/images/svg/dropdown.svg")
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  productDetailController.clickedColorButton();
                },
              ),
            ),
          ),
          GetBuilder<ProductDetailController>(
            init: productDetailController,
            builder: (_) => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productDetailController.colorCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8 * Scale.height),
                  child: GestureDetector(
                    child: Container(
                      width: 370 * Scale.width,
                      height: 52 * Scale.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            productDetailController.selectedColorIndex == index
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
                              "${productDetailController.colorData[index]}",
                              style: textStyle(Color(0xff333333),
                                  FontWeight.w500, "NotoSansKR", 16.0),
                            ),
                            SvgPicture.asset(
                                productDetailController.selectedColorIndex ==
                                        index
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
                      productDetailController.selectColor(index);
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
            init: productDetailController,
            builder: (_) => GestureDetector(
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
                      productDetailController.selectedSizeIndex == -1
                          ? Text("사이즈 선택",
                              style: textStyle(const Color(0xffcccccc),
                                  FontWeight.w400, "NotoSansKR", 16.0))
                          : Text(
                              "${productDetailController.sizeData[productDetailController.selectedSizeIndex]}",
                              style: textStyle(const Color(0xff333333),
                                  FontWeight.w500, "NotoSansKR", 16.0)),
                      SvgPicture.asset(
                          productDetailController.isSizeButtonClicked
                              ? "assets/images/svg/dropUp.svg"
                              : "assets/images/svg/dropdown.svg")
                    ],
                  ),
                ),
              ),
              onTap: () {
                productDetailController.clickedSizeButton();
              },
            ),
          ),
        ),
        GetBuilder<ProductDetailController>(
          init: productDetailController,
          builder: (_) => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: productDetailController.sizeCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8 * Scale.height),
                child: GestureDetector(
                  child: Container(
                    width: 370 * Scale.width,
                    height: 52 * Scale.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: productDetailController.selectedSizeIndex == index
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
                            "${productDetailController.sizeData[index]}",
                            style: textStyle(Color(0xff333333), FontWeight.w500,
                                "NotoSansKR", 16.0),
                          ),
                          SvgPicture.asset(
                              productDetailController.selectedSizeIndex == index
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
                    productDetailController.selectSize(index);
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
              init: productDetailController,
              builder: (_) {
                return Expanded(
                  child: Center(
                    child: ListView.builder(
                        itemCount: productDetailController.productCart.length,
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
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 13 * Scale.height, bottom: 26 * Scale.height),
                  child: GetBuilder<ProductDetailController>(
                      init: productDetailController,
                      builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${productDetailController.productCart.length}개 상품 금액",
                                style: textStyle(const Color(0xff999999),
                                    FontWeight.w400, "NotoSansKR", 14.0)),
                            Text(
                                "${setPriceFormat(productDetailController.totalPrice)}",
                                style: textStyle(const Color(0xffec5363),
                                    FontWeight.w400, "NotoSansKR", 16.0))
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35 * Scale.height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10 * Scale.height),
                          TextButton(
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
                                  Size(118 * Scale.width, 52 * Scale.height)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xfff0f5f9)),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(width: 8 * Scale.width),
                      Column(
                        children: [
                          SizedBox(height: 10 * Scale.height),
                          TextButton(
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
                                  Size(118 * Scale.width, 52 * Scale.height)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff333333)),
                            ),
                            onPressed: () {},
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
                    "${productDetailController.productCart[index].color} / ${productDetailController.productCart[index].size}",
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
                                productDetailController
                                    .substractProductCount(index);
                              }),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8 * Scale.width),
                            child: Text(
                              "${productDetailController.productCart[index].count}",
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
                                productDetailController.addProductCount(index);
                              }),
                        ],
                      ),
                      Text(
                        "${setPriceFormat(productDetailController.productCart[index].count * productDetailController.productCart[index].price)}",
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
                  productDetailController.popProduct(index);
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
