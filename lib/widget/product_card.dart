import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            width: width * 0.425,
            height: width * 0.425,
            child: Image.asset("assets/images/temporary_product_image/다운로드.png",
                fit: BoxFit.fill),
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
                  "머슬 분또 잠바",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  "8,400원",
                  style: textStyle(const Color(0xff333333), FontWeight.w500,
                      "NotoSansKR", 16.0),
                ),
                SizedBox(height: height * 0.003),
                Row(
                  children: [
                    Image.asset("assets/images/location.png"),
                    SizedBox(width: width * 0.01),
                    Text(
                      "서울 중구 장충단로 263",
                      style: textStyle(const Color(0xff999999), FontWeight.w400,
                          "NotoSansKR", 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
