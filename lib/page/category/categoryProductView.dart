import 'dart:io';

import 'package:cloth_collection/controller/categoryController.dart';
import 'package:cloth_collection/controller/productController.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 22.0)),
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
                  },
                  child: SvgPicture.asset("assets/images/svg/search.svg",
                      width: 26 * Scale.width, height: 26 * Scale.width),
                ),
                SizedBox(width: 13 * Scale.width),
                GestureDetector(
                  onTap: () {
                    Vibrate.feedback(VIBRATETYPE);
                  },
                  child: SvgPicture.asset("assets/images/svg/cart.svg",
                      width: 26 * Scale.width, height: 26 * Scale.width),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: widget.categoryController
            .getSubCategory(widget.categoryController.mainCategory.id)
            .catchError((e) {
          if (Platform.isIOS) {
            CupertinoAlertDialog(
              content: Text(
                e.toString(),
                style: textStyle(
                    Colors.black, FontWeight.w500, "NotoSansKR", 16.0),
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            showAlertDialog(context, e);
          }
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Tab> tabs = [];
              List<Widget> tabBarViewList = [];
              print(snapshot.data);
              for (int i = 0; i <= snapshot.data.length; i++) {
                i == 0
                    ? tabs.add(Tab(text: '전체'))
                    : tabs.add(Tab(text: snapshot.data[i - 1]['name']));
                i == 0
                    ? tabBarViewList.add(ProductViewArea(
                        subCategoryId: 0,
                        categoryController: widget.categoryController))
                    : tabBarViewList.add(
                        ProductViewArea(
                          subCategoryId: snapshot.data[i - 1]['id'],
                          categoryController: widget.categoryController,
                        ),
                      );
              }
              return DefaultTabController(
                length: snapshot.data.length + 1,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: TabBar(
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 2.0),
                              insets: EdgeInsets.symmetric(horizontal: 16.0)),
                          tabs: tabs,
                          labelStyle: textStyle(const Color(0xff333333),
                              FontWeight.w400, "NotoSansKR", 16.0),
                          unselectedLabelStyle: textStyle(
                              const Color(0xffcccccc),
                              FontWeight.w400,
                              "NotoSansKR",
                              16.0),
                          onTap: (index) {}),
                    ),
                    Expanded(child: TabBarView(children: tabBarViewList)),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "네트워크에 연결하지 못했어요",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "NotoSansKR", 20.0),
                    ),
                    Text(
                      "네트워크 연결상태를 확인하고",
                      style: textStyle(
                          Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
                    ),
                    Text(
                      "다시 시도해 주세요",
                      style: textStyle(
                          Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
                    ),
                    SizedBox(height: 15 * Scale.height),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(19))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 17 * Scale.width,
                              vertical: 14 * Scale.height),
                          child: Text("다시 시도하기",
                              style: textStyle(Colors.black, FontWeight.w700,
                                  'NotoSansKR', 15.0)),
                        ),
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            } else {
              return progressBar();
            }
          } else {
            return progressBar();
          }
        },
      ),
    );
  }
}

class ProductViewArea extends StatefulWidget {
  final int subCategoryId;
  final CategoryController categoryController;
  ProductViewArea(
      {Key? key, required this.subCategoryId, required this.categoryController})
      : super(key: key);

  @override
  _ProductViewAreaState createState() => _ProductViewAreaState();
}

class _ProductViewAreaState extends State<ProductViewArea>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  ProductController productController = ProductController();

  late TabController optionTabController;

  @override
  void initState() {
    super.initState();
    productController.subCategoryId = widget.subCategoryId;
    productController.mainCategoryId =
        widget.categoryController.mainCategory.id;

    optionTabController = TabController(length: 4, vsync: this);
    scrollController.addListener(() {
      //subCategory 상품
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          productController.nextDataLink != "") {
        productController.getProducts().catchError((e) {
          setState(() {});
          return showAlertDialog(context, e);
        });
      }
    });
  }

  @override
  void dispose() {
    optionTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filterBarArea(context),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                productController.initGetProducts().catchError((e) {
              // print('err');
              // showAlertDialog(context, e);
              setState(() {});
            }),
            color: Colors.black,
            child: FutureBuilder(
                future: productController.initGetProducts().catchError((e) {
                  showAlertDialog(context, e);
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.white,
                        child: GetBuilder<ProductController>(
                            global: false,
                            init: productController,
                            builder: (controller) {
                              return GridView.builder(
                                controller: scrollController,
                                itemCount: controller.productData.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.6),
                                itemBuilder: (context, int index) {
                                  return ProductCard(
                                      product: Product.fromJson(
                                          controller.productData[index]),
                                      imageWidth: 170 * Scale.width);
                                },
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "네트워크에 연결하지 못했어요",
                              style: textStyle(Colors.black, FontWeight.w700,
                                  "NotoSansKR", 20.0),
                            ),
                            Text(
                              "네트워크 연결상태를 확인하고",
                              style: textStyle(Colors.grey, FontWeight.w500,
                                  "NotoSansKR", 13.0),
                            ),
                            Text(
                              "다시 시도해 주세요",
                              style: textStyle(Colors.grey, FontWeight.w500,
                                  "NotoSansKR", 13.0),
                            ),
                            SizedBox(height: 15 * Scale.height),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(19))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17 * Scale.width,
                                      vertical: 14 * Scale.height),
                                  child: Text("다시 시도하기",
                                      style: textStyle(Colors.black,
                                          FontWeight.w700, 'NotoSansKR', 15.0)),
                                ),
                              ),
                              onTap: () {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    print("loading");
                    return progressBar();
                  }
                }),
          ),
        ),
      ],
    );
  }

  Widget sortButton() {
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
                GetBuilder<ProductController>(
                    init: productController,
                    builder: (controller) {
                      return Text(
                        "${controller.sortTypes[controller.sortType]}",
                        style: textStyle(const Color(0xff444444),
                            FontWeight.w700, "NotoSansKR", 14.0),
                      );
                    }),
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
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (_) => Container(
            height: 400 * Scale.height,
            child: GetBuilder<ProductController>(
              init: productController,
              builder: (controller) {
                return Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.sortTypes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * Scale.width,
                            vertical: 10 * Scale.height),
                        child: GestureDetector(
                          child: Container(
                            child: Text(
                              "${controller.sortTypes[index]}",
                              style: textStyle(
                                  controller.sortType == index
                                      ? Colors.black
                                      : Colors.grey,
                                  FontWeight.w700,
                                  "NotosansKR",
                                  20.0),
                            ),
                          ),
                          onTap: () {
                            scrollController.animateTo(
                                scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                            controller.sortClicked(index).catchError((e) {
                              showAlertDialog(context, e);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                        child: Divider(color: Colors.grey[400]),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
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
                Text(
                  "$type",
                  style: textStyle(const Color(0xff444444), FontWeight.w700,
                      "NotoSansKR", 14.0),
                ),
                SizedBox(width: 6 * Scale.width),
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
                    return optionArea(type);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget filterBarArea(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: widget.categoryController,
        builder: (controller) {
          return Container(
            color: Colors.white,
            height: 52 * Scale.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        right: 8 * Scale.width, left: 22 * Scale.width),
                    child: GestureDetector(
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
                                      FontWeight.w700, "NotoSansKR", 14.0))
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        productController.initGetProducts().catchError((e) {
                          showAlertDialog(context, e);
                        });
                      },
                    ),
                  ),
                  sortButton(),
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

  Widget optionArea(String type) {
    switch (type) {
      case "색상":
        optionTabController.index = 0;
        break;
      case "가격":
        optionTabController.index = 1;
        break;
      default:
    }
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
                      onPressed: () {},
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
                      onPressed: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut);
                        productController.searchClicked().catchError((e) {
                          showAlertDialog(context, e);
                        });
                        Navigator.of(context).pop();
                      },
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
          future: widget.categoryController.getColorImage().catchError((e) {
            showAlertDialog(context, e);
          }),
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
                          productController.selectColor(index);
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          SvgPicture.network(
                              "${snapshot.data[index]['image_url']}"),
                          Positioned(
                              child: GetBuilder<ProductController>(
                                  init: productController,
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
      child: GetBuilder<ProductController>(
        id: "priceOption",
        init: productController,
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
