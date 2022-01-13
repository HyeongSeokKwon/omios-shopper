import 'dart:async';

import 'package:cloth_collection/controller/categoryController.dart';
import 'package:cloth_collection/controller/productController.dart';
import 'package:cloth_collection/data/exampleProduct.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class CategoryProductView extends StatefulWidget {
  final CategoryController categoryController;
  CategoryProductView({Key? key, required this.categoryController})
      : super(key: key);
  @override
  _CategoryProductViewState createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView>
    with SingleTickerProviderStateMixin {
  late TabController optionTabController;
  @override
  void initState() {
    super.initState();
    optionTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    optionTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.categoryController
          .getSubCategory(widget.categoryController.mainCategory.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Tab> tabs = [];
          List<Widget> tabBarViewList = [];
          for (int i = 0; i <= snapshot.data.length; i++) {
            i == 0
                ? tabs.add(Tab(text: '전체'))
                : tabs.add(Tab(text: snapshot.data[i - 1]['name']));
            tabBarViewList.add(ProductViewArea(
                mainCategoryId: widget.categoryController.mainCategory.id,
                subCategoryId: i));
          }
          return DefaultTabController(
            length: snapshot.data.length + 1,
            child: Scaffold(
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
                    Text("${widget.categoryController.mainCategory.name}",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w700, "NotoSansKR", 22.0)),
                  ],
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 22 * Scale.width),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Vibrate.feedback(VIBRATETYPE);
                            print(getCategoryList());
                          },
                          child:
                              SvgPicture.asset("assets/images/svg/search.svg"),
                        ),
                        SizedBox(width: 22 * Scale.width),
                        GestureDetector(
                          onTap: () {
                            Vibrate.feedback(VIBRATETYPE);
                          },
                          child: SvgPicture.asset("assets/images/svg/cart.svg"),
                        ),
                      ],
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(100 * Scale.height),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(width: 2.0),
                            insets: EdgeInsets.symmetric(horizontal: 16.0)),
                        tabs: tabs,
                        labelStyle: textStyle(const Color(0xff333333),
                            FontWeight.w400, "NotoSansKR", 16.0),
                        unselectedLabelStyle: textStyle(const Color(0xffcccccc),
                            FontWeight.w400, "NotoSansKR", 16.0),
                      ),
                      filterBarArea(),
                    ],
                  ),
                ),
              ),
              body: TabBarView(children: tabBarViewList),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget filterButton(String type) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(right: 8 * Scale.width),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(445)),
            border: Border.all(
              color: Color(0xffcccccc),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10 * Scale.width, vertical: 6 * Scale.height),
            child: Row(
              children: [
                Text("$type ",
                    style: textStyle(const Color(0xff444444), FontWeight.w400,
                        "NotoSansKR", 14.0)),
                SvgPicture.asset(
                  "assets/images/svg/dropdown.svg",
                  width: 10 * Scale.width,
                  height: 5 * Scale.height,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          context: context,
          builder: (_) => Stack(
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
                  expand: true,
                  initialChildSize: 0.7,
                  maxChildSize: 1.0,
                  builder: (_, controller) {
                    return optionArea();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget filterBarArea() {
    return GetBuilder<CategoryController>(
        init: widget.categoryController,
        builder: (context) {
          return Container(
            height: 52 * Scale.height,
            color: const Color(0xfffafafa),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        right: 8 * Scale.width, left: 22 * Scale.width),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(445)),
                        border: Border.all(
                          color: Color(0xffcccccc),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10 * Scale.width,
                          vertical: 6 * Scale.height,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/svg/refreshDark.svg",
                              width: 10 * Scale.width,
                              height: 10 * Scale.width,
                              fit: BoxFit.scaleDown,
                            ),
                            Text("  초기화",
                                style: textStyle(const Color(0xff444444),
                                    FontWeight.w400, "NotoSansKR", 14.0))
                          ],
                        ),
                      ),
                    ),
                  ),
                  filterButton("추천순"),
                  filterButton("색상"),
                  filterButton("가격"),
                  filterButton("연령"),
                  filterButton("스타일"),
                ],
              ),
            ),
          );
        });
  }

  Widget optionArea() {
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
          padding: EdgeInsets.only(top: 24 * Scale.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                child: TabBar(
                  controller: optionTabController,
                  tabs: [
                    Tab(text: "색상"),
                    Tab(text: "가격"),
                    Tab(text: "연령"),
                    Tab(text: "스타일"),
                  ],
                  labelPadding: EdgeInsets.only(right: 25 * Scale.width),
                  indicatorPadding: EdgeInsets.only(right: 25 * Scale.width),
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2.0, color: const Color(0xffec5363)),
                  ),
                  labelStyle: textStyle(const Color(0xff333333),
                      FontWeight.w500, "NotoSansKR", 18.0),
                  unselectedLabelStyle: textStyle(const Color(0xffcccccc),
                      FontWeight.w500, "NotoSansKR", 18.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                  child: TabBarView(controller: optionTabController, children: [
                    colorOptionArea(),
                    priceOptionArea(),
                    colorOptionArea(),
                    colorOptionArea(),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/svg/refreshDark.svg",
                            width: 14 * Scale.width,
                            height: 14 * Scale.width,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: 6 * Scale.width),
                          Text("초기화",
                              style: textStyle(Color(0xff333333),
                                  FontWeight.w500, "NotoSansKR", 16.0)),
                        ],
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(140 * Scale.width, 52 * Scale.height)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffeeeeee)),
                      ),
                      onPressed: () {
                        print("click");
                        print(optionTabController.index);
                        switch (optionTabController.index) {
                          case 0:
                            widget.categoryController.refreshColorOption();
                            break;
                          case 1:
                            widget.categoryController.refreshPriceOption();
                            break;
                          default:
                        }
                      },
                    ),
                    SizedBox(width: 8 * Scale.width),
                    TextButton(
                      child: Text("상품보기",
                          style: textStyle(const Color(0xffffffff),
                              FontWeight.w500, "NotoSansKR", 16.0)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(222 * Scale.width, 52 * Scale.height)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffec5363)),
                      ),
                      onPressed: () {},
                    ),
                  ],
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
            Navigator.of(context).pop();
          },
        ),
      )
    ]);
  }

  Widget colorOptionArea() {
    return Container(
      child: FutureBuilder(
          future: widget.categoryController.getColorImage(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 25 * Scale.height),
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 30 * Scale.height,
                    childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.categoryController.selectColor(index);
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          SvgPicture.network(
                              "${snapshot.data[index]['image_url']}"),
                          Positioned(
                              child: GetBuilder<CategoryController>(
                                  init: widget.categoryController,
                                  builder: (controller) {
                                    return SvgPicture.asset(
                                      index != 1
                                          ? "assets/images/svg/colorChecked.svg"
                                          : "assets/images/svg/colorWhiteChecked.svg",
                                      width:
                                          controller.isColorSelected(index) ==
                                                  false
                                              ? 0
                                              : 20,
                                      height:
                                          controller.isColorSelected(index) ==
                                                  false
                                              ? 0
                                              : 20,
                                    );
                                  }))
                        ]),
                      ),
                      SizedBox(height: 4 * Scale.height),
                      Text(
                        "${snapshot.data[index]['name']}",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w500, "NotoSansKR", 16.0),
                      )
                    ],
                  );
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget priceOptionArea() {
    return Container(
      child: GetBuilder<CategoryController>(
        init: widget.categoryController,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30 * Scale.height,
              ),
              Text("가격대",
                  style: textStyle(const Color(0xff797979), FontWeight.w400,
                      "NotoSans", 20.0)),
              Text(
                  "${(controller.priceRange.start).toInt()}원 ~ ${(controller.priceRange.end).toInt()}원",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 22.0)),
              SizedBox(
                height: 33 * Scale.height,
              ),
              SliderTheme(
                data: SliderThemeData(
                  inactiveTrackColor: const Color(0xffe2e2e2),
                  activeTrackColor: const Color(0xffec5363),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                  trackHeight: 18 * Scale.height,
                  thumbColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(),
                ),
                child: RangeSlider(
                    values: controller.priceRange,
                    min: 0.0,
                    max: 100000.0,
                    divisions: 100,
                    onChanged: (value) {
                      controller.priceRangeChange(value);
                    }),
              ),
              SizedBox(height: 16 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${controller.startPrice.toInt()}원",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 18.0),
                  ),
                  Text(
                    "${controller.endPrice.toInt()}원",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 18.0),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductViewArea extends StatefulWidget {
  final int mainCategoryId;
  final int subCategoryId;
  ProductViewArea(
      {Key? key, required this.mainCategoryId, required this.subCategoryId})
      : super(key: key);

  @override
  _ProductViewAreaState createState() => _ProductViewAreaState();
}

class _ProductViewAreaState extends State<ProductViewArea> {
  final productController = Get.put<ProductController>(ProductController());
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    productController.initGetProducts(
        widget.mainCategoryId, widget.subCategoryId); //첫 build시 데이터 초기화
    scrollController.addListener(() {
      //subCategory 상품
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          productController.nextDataLink != "") {
        productController.getSubCategoryProducts(
            widget.mainCategoryId, widget.subCategoryId);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: productController,
      global: false,
      builder: (controller) {
        if (!controller.isLoading) {
          return GridView.builder(
            controller: scrollController,
            itemCount: controller.productData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0 * Scale.height,
                childAspectRatio: 0.65),
            itemBuilder: (context, int index) {
              return ProductCard(
                  product: Product.fromJson(controller.productData[index]),
                  imageWidth: 110 * Scale.width);
            },
          );
        } else {
          return Transform.scale(
              scale: 0.1, child: CircularProgressIndicator());
        }
      },
    );
    // FutureBuilder(
    //   future: widget.subCategoryId != 0
    //       ? widget.categoryController
    //           .getSubCategoryProduct(widget.subCategoryId)
    //       : widget.categoryController.getAllProduct(),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData && snapshot.data.length >= 1) {
    //         return GridView.builder(
    //           itemCount: snapshot.data.length,
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 3,
    //               mainAxisSpacing: 10 * Scale.height,
    //               childAspectRatio: 0.65),
    //           itemBuilder: (context, int index) {
    //             return ProductCard(
    //                 product: Product.fromJson(snapshot.data[index]),
    //                 imageWidth: 110 * Scale.width);
    //           },
    //         );
    //       } else if (snapshot.hasData && snapshot.data.length == 0) {
    //         return Center(child: Text("상품이 존재하지 않습니다."));
    //       } else {
    //         return CircularProgressIndicator();
    //       }
    //     } else {
    //       return Transform.scale(
    //           scale: 0.1, child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}
