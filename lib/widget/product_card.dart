import 'package:cloth_collection/data/exampleProduct.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Vibrate.feedback(VIBRATETYPE);

        Get.to(() => ProductDetail(product));
      },
      child: Container(
        child: Column(
          children: [
            _buildProductImage(),
            _buildProductInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 176 * Scale.width,
      height: 176 * Scale.width * (4 / 3),
      child: ClipRRect(
        child: Image.asset("${product.image}", fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8.0),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      width: 176 * Scale.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12 * Scale.height),
          Text(
            "${product.name}",
            style: textStyle(
                const Color(0xff999999), FontWeight.w400, "NotoSansKR", 12.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4 * Scale.height),
          Text(
            setPriceFormat(product.price),
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 17.0),
          ),
          SizedBox(height: 4 * Scale.height),
        ],
      ),
    );
  }
}
