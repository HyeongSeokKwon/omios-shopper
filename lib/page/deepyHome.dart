import 'package:cloth_collection/widget/image_slide.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeepyHome extends StatefulWidget {
  @override
  _DeepyHomeState createState() => _DeepyHomeState();
}

class _DeepyHomeState extends State<DeepyHome> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ImageSlideHasNum(width / 1.618, width), //배너 호출
            _buildRecommend(), _buildRecommend(), _buildRecommend(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommend() {
    String recommendText = "Deepy님의 쇼핑몰에 가장 잘 어울리는 옷";
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                recommendText,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductCard(),
                SizedBox(width: 25),
                ProductCard(),
                SizedBox(width: 25),
                ProductCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
