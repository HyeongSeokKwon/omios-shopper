import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard(this.product);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetail(product));
      },
      child: Container(
        child: Column(
          children: [
            _buildProductImage(width, height),
            _buildProductInfo(width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(double width, double height) {
    return Container(
      width: width * 0.425,
      height: width * 0.425 * (500 / 375),
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

  Widget _buildProductInfo(double width, double height) {
    return Container(
      width: width * 0.425,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          Text(
            "${product.name}",
            style: textStyle(
                const Color(0xff333333), FontWeight.w400, "NotoSansKR", 14.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: height * 0.003),
          Text(
            setPriceFormat(product.price),
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 16.0),
          ),
          SizedBox(height: height * 0.003),
          Row(
            children: [
              SvgPicture.asset("assets/images/svg/location.svg"),
              SizedBox(width: width * 0.01),
              Text(
                "${product.location}",
                style: textStyle(const Color(0xff999999), FontWeight.w400,
                    "NotoSansKR", 12.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
