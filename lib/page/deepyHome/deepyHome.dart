import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeepyHome extends StatefulWidget {
  final ScrollController scrollController;

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              ImageSlideHasNum(),
              SizedBox(height: 30 * Scale.height),
              _buildRecommendComment(),
              SizedBox(height: 22 * Scale.height),
              _buildProduct(),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildProduct() {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard(products[0]),
                  SizedBox(width: 18 * Scale.width),
                  ProductCard((products[1])),
                ],
              ),
              SizedBox(height: 34 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard((products[2])),
                  SizedBox(width: 18 * Scale.width),
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
