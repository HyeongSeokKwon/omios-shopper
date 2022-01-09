import 'package:cloth_collection/page/category/categoryProductView.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Map<String, String>> categoryMap = [
    {"name": "아우터", "image": "assets/images/svg/outerCategory.svg"},
    {"name": "상의", "image": "assets/images/svg/topCategory.svg"},
    {"name": "원피스/세트", "image": "assets/images/svg/onepieceCategory.svg"},
    {"name": "바지", "image": "assets/images/svg/bottomCategory.svg"},
    {"name": "스커트", "image": "assets/images/svg/skirtCategory.svg"},
    {"name": "트레이닝복", "image": "assets/images/svg/trainingCategory.svg"},
    {"name": "비치웨어", "image": "assets/images/svg/beachwearCategory.svg"},
    {"name": "란제리/파자마", "image": "assets/images/svg/lingerieCategory.svg"},
    {"name": "빅사이즈", "image": "assets/images/svg/bigsizeCategory.svg"},
    {"name": "신발", "image": "assets/images/svg/shoesCategory.svg"},
    {"name": "악세서리", "image": "assets/images/svg/accessoriesCategory.svg"},
    {"name": "가방", "image": "assets/images/svg/bagCategory.svg"}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: 20 * Scale.width, vertical: 25 * Scale.height),
        itemCount: categoryMap.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 30 * Scale.height,
            childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index) {
          return categoryIconArea(index);
        },
      ),
    );
  }

  Widget categoryIconArea(int index) {
    return GestureDetector(
      child: Column(
        children: [
          SvgPicture.asset("${categoryMap[index]["image"]}",
              width: 81 * Scale.width, height: 81 * Scale.width),
          SizedBox(height: 3.8 * Scale.height),
          Text("${categoryMap[index]["name"]}",
              style: textStyle(const Color(0xff333333), FontWeight.w500,
                  "NotoSansKR", 14.0)),
        ],
      ),
      onTap: () {
        Get.to(CategoryProductView());
      },
    );
  }
}
