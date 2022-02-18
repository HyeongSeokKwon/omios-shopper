import 'package:cloth_collection/controller/homeController.dart';
import 'package:cloth_collection/data/exampleProduct.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';

class DeepyHome extends StatefulWidget {
  final ScrollController scrollController;

  DeepyHome(this.scrollController);
  @override
  _DeepyHomeState createState() => _DeepyHomeState();
}

class _DeepyHomeState extends State<DeepyHome>
    with SingleTickerProviderStateMixin {
  late List<Product> products;
  late TabController categoryTabController;
  HomeController homeController = HomeController();
  List<Tab> tabList = [];
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    products = getProduct();
    categoryTabController = TabController(length: 6, vsync: this);
    tabList.add(
      Tab(
        text: "홈",
      ),
    );
    tabList.add(
      Tab(text: "당일발송"),
    );
    tabList.add(
      Tab(text: "타임세일"),
    );
    tabList.add(
      Tab(text: "Best"),
    );
    tabList.add(
      Tab(text: "신상품"),
    );
    tabList.add(
      Tab(text: "이벤트"),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        child: Column(
          children: [
            categoryBarArea(),
            Expanded(
              child: TabBarView(
                controller: categoryTabController,
                children: [
                  homeArea(),
                  a(),
                  a(),
                  a(),
                  a(),
                  a(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget a() {
    return Column();
  }

  Widget b() {
    return Column();
  }

  Widget c() {
    return Column();
  }

  Widget d() {
    return Column();
  }

  Widget e() {
    return Column();
  }

  Widget categoryBarArea() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 40 * Scale.height,
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 5 * Scale.width),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.5),
            insets: EdgeInsets.symmetric(horizontal: 0.0)),
        labelStyle:
            textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 14.0),
        unselectedLabelColor: const Color(0xffcccccc),
        unselectedLabelStyle:
            textStyle(Colors.black, FontWeight.w400, "NotoSansKR", 14.0),
        tabs: tabList,
        controller: categoryTabController,
      ),
    );
  }

  Widget homeArea() {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: [
          ImageSlideHasNum(),
          SizedBox(height: 30 * Scale.height),
          showMenual(),
          SizedBox(height: 15 * Scale.height),
          iconButtonArea(),
          divider(),
          todaysPickProduct(),
          divider(),
          totalBestProduct(),
          divider(),
          eventBannerArea(),
          todaySpecialPrice(),
          divider(),
          specialExhibitionArea(),
          divider(),
          _buildRecommendComment(),
          _buildProduct(),
        ],
      ),
    );
  }

  Widget showMenual() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20 * Scale.height),
            child: Text("0원 배송 방법 및 메뉴얼",
                style: textStyle(
                    Colors.black, FontWeight.w500, "NotoSansKR", 16.0)),
          ),
        ),
      ),
    );
  }

  Widget todaysPickProduct() {
    return FutureBuilder(
        future: homeController.getTodaysProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                child: Column(
                  children: [
                    Align(
                        child: Text(
                          "오늘의 PICK 상품",
                          style: textStyle(Colors.black, FontWeight.w500,
                              "NotoSansKR", 18.0),
                        ),
                        alignment: Alignment.centerLeft),
                    SizedBox(height: 14 * Scale.height),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.55,
                            mainAxisSpacing: 10 * Scale.height),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return ProductCard(
                              product: Product.fromJson(snapshot.data[index]),
                              imageWidth: 115 * Scale.width);
                        }),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return progressBar();
            }
          } else {
            return progressBar();
          }
        });
  }

  Widget totalBestProduct() {
    return FutureBuilder(
        future: homeController.getTodaysProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15 * Scale.width),
                child: Column(
                  children: [
                    Align(
                        child: Text(
                          "전체 BEST 상품",
                          style: textStyle(Colors.black, FontWeight.w500,
                              "NotoSansKR", 18.0),
                        ),
                        alignment: Alignment.centerLeft),
                    SizedBox(height: 14 * Scale.height),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ProductCard(
                              product: Product.fromJson(snapshot.data[index]),
                              imageWidth: 176 * Scale.width);
                        }),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10 * Scale.height,
                              horizontal: 50 * Scale.width),
                          child: Text(
                            "BEST 상품 더보기",
                            style: textStyle(Colors.grey[600]!, FontWeight.w500,
                                "NotoSansKR", 13.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          categoryTabController.index = 3;
                        });
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return progressBar();
            }
          } else {
            return progressBar();
          }
        });
  }

  Widget _buildRecommendComment() {
    String id = "Deepy";
    String recommendText = "님!\n쇼핑몰에 이 상품은 어때요?";
    return Padding(
      padding: EdgeInsets.only(left: 22 * Scale.width),
      child: Container(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  style: textStyle(const Color(0xffec5363), FontWeight.w700,
                      "NotoSansKR", 18.0),
                  text: id),
              TextSpan(
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 18.0),
                  text: recommendText),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconButtonArea() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
          horizontal: 22 * Scale.width, vertical: 25 * Scale.height),
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 30 * Scale.height,
      ),
      itemBuilder: (BuildContext context, int index) {
        List<String> itemName = [
          "친구초대",
          "당일발송",
          "추천상품",
          "특가",
          "이벤트",
          "OO",
          "OO",
          "OO"
        ];
        List<String> assets = [
          "assets/images/temporary/tItem1.jpg",
          "assets/images/temporary/tItem2.png",
          "assets/images/temporary/tItem3.jpg",
          "assets/images/temporary/tItem4.jpg",
          "assets/images/temporary/tItem5.jpg",
          "assets/images/temporary/tItem6.png",
          "assets/images/temporary/tItem7.jpg",
          "assets/images/temporary/tItem8.jpg",
        ];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * Scale.width),
          child: GestureDetector(
            child: Column(
              children: [
                Container(
                  width: 60 * Scale.width,
                  height: 60 * Scale.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(assets[index])),
                ),
                Text(
                  itemName[index],
                  style: textStyle(
                      Colors.black, FontWeight.w300, "NotoSansKR", 12.0),
                )
              ],
            ),
            onTap: () {
              switch (index) {
                case 1:
                  categoryTabController.index = 1;
                  setState(() {});
                  break;
                case 4:
                  categoryTabController.index = 5;
                  setState(() {});
                  break;
                default:
              }
            },
          ),
        );
      },
    );
  }

  Widget eventBannerArea() {
    return Padding(
      padding: EdgeInsets.only(
          left: 22 * Scale.width,
          right: 22 * Scale.width,
          bottom: 40 * Scale.height),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30 * Scale.height),
            child: Text("이벤트 배너",
                style: textStyle(
                    Colors.black, FontWeight.w500, "NotoSansKR", 16.0)),
          ),
        ),
      ),
    );
  }

  Widget todaySpecialPrice() {
    return FutureBuilder(
        future: homeController.getTodaysProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15 * Scale.width),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "오늘만 특가!",
                          style: textStyle(Colors.black, FontWeight.w500,
                              "NotoSansKR", 18.0),
                        ),
                        Text("더보기",
                            style: textStyle(Colors.grey[400]!, FontWeight.w500,
                                "NotoSansKR", 14.0))
                      ],
                    ),
                    SizedBox(height: 14 * Scale.height),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ProductCard(
                              product: Product.fromJson(snapshot.data[index]),
                              imageWidth: 176 * Scale.width);
                        }),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return progressBar();
            }
          } else {
            return progressBar();
          }
        });
  }

  Widget specialExhibitionArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "핫한 기획전(이벤트)",
                style: textStyle(
                    Colors.black, FontWeight.w500, "NotoSansKR", 18.0),
              ),
              Text("더보기",
                  style: textStyle(
                      Colors.grey[400]!, FontWeight.w500, "NotoSansKR", 14.0))
            ],
          ),
          SizedBox(height: 14 * Scale.height),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10 * Scale.height),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard(
                      product: products[0], imageWidth: 176 * Scale.width),
                  SizedBox(width: 18 * Scale.width),
                  ProductCard(
                      product: products[1], imageWidth: 176 * Scale.width),
                ],
              ),
              SizedBox(height: 34 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard(
                      product: products[2], imageWidth: 176 * Scale.width),
                  SizedBox(width: 18 * Scale.width),
                  ProductCard(
                      product: products[3], imageWidth: 176 * Scale.width),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30 * Scale.height),
        child: Divider(
          thickness: 10 * Scale.height,
          color: Colors.grey[50],
        ));
  }
}
