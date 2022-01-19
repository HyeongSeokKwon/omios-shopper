import 'package:cloth_collection/controller/recentViewController.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class RecentviewProduct extends StatefulWidget {
  const RecentviewProduct({Key? key}) : super(key: key);

  @override
  State<RecentviewProduct> createState() => _RecentviewProductState();
}

class _RecentviewProductState extends State<RecentviewProduct> {
  RecentViewController recentViewController =
      Get.put<RecentViewController>(RecentViewController());
  @override
  void initState() {
    super.initState();
    recentViewController.getRecentViewProduct();
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard({required Product product}) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110 * (4 / 3),
            child: ClipRRect(
              child: Image.asset("${product.imageUrl}", fit: BoxFit.scaleDown),
              borderRadius: BorderRadius.circular(8.0),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
          ),
          Container(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12 * Scale.height),
                Text(
                  "${product.name}",
                  style: textStyle(const Color(0xff999999), FontWeight.w400,
                      "NotoSansKR", 12.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4 * Scale.height),
                Text(
                  setPriceFormat(product.price),
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 17.0),
                ),
                SizedBox(height: 4 * Scale.height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget recentProductArea() {
    return Container(
      child: GetBuilder<RecentViewController>(
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
                    child: Container(
                      child: GestureDetector(
                        child: productCard(
                          product: Product.fromJson(
                              controller.recentViewProductList[index]),
                        ),
                        onTap: () {
                          if (controller.edit) {
                            controller.productClicked(index);
                          } else {
                            Get.to(() => ProductDetail(Product.fromJson(
                                controller.recentViewProductList[index])));
                          }
                        },
                      ),
                    ),
                  ),
                  controller.edit == true
                      ? Positioned(
                          top: 8 * Scale.height,
                          right: 20 * Scale.width,
                          child: controller.selectProductList.contains(
                                      controller.recentViewProductList[index]
                                          ['id']) ==
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
            },
          );
        },
      ),
    );
  }

// controller.isSelected(index)
//                                   ? "assets/images/svg/cartCheck.svg"
//                                   :
  Widget optionArea() {
    return Container(
      height: 80 * Scale.height,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 207 * Scale.width,
              color: Colors.grey[400],
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
          ),
          GestureDetector(
            child: Container(
              width: 207 * Scale.width,
              color: Colors.grey[400],
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
          ),
        ],
      ),
    );
  }
}
