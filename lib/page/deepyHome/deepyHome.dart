import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeepyHome extends StatefulWidget {
  ScrollController scrollController;

  DeepyHome(this.scrollController);
  @override
  _DeepyHomeState createState() => _DeepyHomeState();
}

class _DeepyHomeState extends State<DeepyHome> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = getProduct();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              ImageSlideHasNum(width * 0.62, width),
              SizedBox(height: height * 0.026),
              _buildRecommendComment(width),
              SizedBox(height: height * 0.019),
              _buildProduct(width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendComment(double width) {
    String id = "Deepy";
    String recommendText = "님!\n쇼핑몰에 이 상품은 어때요?";
    return Padding(
      padding: EdgeInsets.only(left: width * 0.053),
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

  Widget _buildProduct(double width, double height) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard(products[0]),
                  SizedBox(width: width * 0.043),
                  ProductCard((products[1])),
                ],
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard((products[2])),
                  SizedBox(width: width * 0.043),
                  ProductCard((products[3])),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
