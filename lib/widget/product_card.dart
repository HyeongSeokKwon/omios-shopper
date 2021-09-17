import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  late Product product;
  ProductCard(this.product);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Get.to(ProductDetail());
      },
      child: Container(
        child: Column(
          children: [
            Container(
              width: width * 0.425,
              height: width * 0.425,
              child: Image.asset("${product.image}", fit: BoxFit.fill),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
            ),
            Container(
              width: width * 0.425,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.01),
                  Text(
                    "${product.name}",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 14.0),
                    maxLines: 1,
                  ),
                  SizedBox(height: height * 0.003),
                  Text(
                    "${product.price}",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                  SizedBox(height: height * 0.003),
                  Row(
                    children: [
                      Image.asset("assets/images/location.png"),
                      SizedBox(width: width * 0.01),
                      Text(
                        "${product.location}",
                        style: textStyle(const Color(0xff999999),
                            FontWeight.w400, "NotoSansKR", 12.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
