import 'package:cloth_collection/controller/recentViewController.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../model/productModel.dart';
import 'productDetail/productDetail.dart';

class RecentviewProduct extends StatefulWidget {
  const RecentviewProduct({Key? key}) : super(key: key);

  @override
  State<RecentviewProduct> createState() => _RecentviewProductState();
}

class _RecentviewProductState extends State<RecentviewProduct> {
  RecentViewController recentViewController =
      Get.put<RecentViewController>(RecentViewController());

  late Future recentProductList;
  @override
  void initState() {
    super.initState();
    recentProductList = recentViewController.getRecentViewProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leadingWidth: 200 * Scale.width,
        leading: Container(
          child: Center(
            child: Row(
              children: [
                SizedBox(width: 22 * Scale.width),
                Text("최근 본 상품",
                    style: textStyle(const Color(0xff333333), FontWeight.w700,
                        "NotoSansKR", 22.0)),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15 * Scale.width),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Vibrate.feedback(VIBRATETYPE);
                    recentViewController.editProductsClicked();
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            recentProductArea(),
            Positioned(
              bottom: 0,
              child: GetBuilder<RecentViewController>(
                init: recentViewController,
                builder: (controller) {
                  return controller.edit == true ? optionArea() : SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentProductArea() {
    return Container(
      child: FutureBuilder(
        future: recentProductList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GetBuilder<RecentViewController>(
                init: recentViewController,
                builder: (controller) {
                  return GridView.builder(
                    itemCount: controller.recentViewProductList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.6),
                    itemBuilder: (context, int index) {
                      return Stack(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (controller.edit) {
                                  controller.productClicked(index);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                          productId: controller
                                                  .recentViewProductList[index]
                                              ['id'],
                                        ),
                                      ));
                                }
                              },
                              child: ProductCard(
                                  product:
                                      Product.fromJson(snapshot.data[index]),
                                  imageWidth: 115 * Scale.width),
                            ),
                          ),
                          controller.edit == true
                              ? Positioned(
                                  top: 8 * Scale.height,
                                  right: 20 * Scale.width,
                                  child: controller.selectProductList.contains(
                                              controller.recentViewProductList[
                                                  index]['id']) ==
                                          false
                                      ? SvgPicture.asset(
                                          "assets/images/svg/cartUnCheck.svg",
                                          width: 10,
                                          height: 17)
                                      : SvgPicture.asset(
                                          "assets/images/svg/cartCheck.svg",
                                          width: 10,
                                          height: 17),
                                )
                              : Container(),
                        ],
                      );

                      // Stack(
                      //   children: [
                      //     ProductCard(
                      //         product: Product.fromJson(snapshot.data[index]),
                      //         imageWidth: 115 * Scale.width),
                      //   ],
                      // );
                    },
                  );
                },
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

  Widget optionArea() {
    return Container(
      height: 80 * Scale.height,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 207 * Scale.width,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/svg/cartUnCheck.svg"),
                  SizedBox(height: 5 * Scale.height),
                  Text(
                    "전체 선택",
                    style: textStyle(
                        Colors.white, FontWeight.w600, "NotosansKR", 16.0),
                  )
                ],
              ),
            ),
            onTap: () {
              recentViewController.selectAllProduct();
            },
          ),
          GestureDetector(
            child: Container(
              width: 207 * Scale.width,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/svg/cartCheck.svg"),
                  SizedBox(height: 5 * Scale.height),
                  Text(
                    "삭제",
                    style: textStyle(
                        Colors.white, FontWeight.w600, "NotosansKR", 16.0),
                  ),
                ],
              ),
            ),
            onTap: () {
              recentViewController.deleteProduct();
            },
          ),
        ],
      ),
    );
  }
}
