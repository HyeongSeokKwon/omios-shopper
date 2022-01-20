import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class ProductRecommentCard extends StatelessWidget {
  final Product product;
  ProductRecommentCard(this.product);
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
      width: 156 * Scale.width,
      height: 156 * Scale.width * (500 / 375),
      child: ClipRRect(
        child: Image.network(
            "${product.mainImage == null ? product.defaultImage : product.mainImage}",
            fit: BoxFit.cover),
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
      width: 156 * Scale.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 9 * Scale.height),
          Text(
            "${product.name}",
            style: textStyle(
                const Color(0xff333333), FontWeight.w400, "NotoSansKR", 14.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10 * Scale.height),
          Text(
            setPriceFormat(product.price),
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 16.0),
          ),
          SizedBox(height: 27 * Scale.height),
        ],
      ),
    );
  }
}
