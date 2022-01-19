import 'package:cloth_collection/controller/categoryController.dart';
import 'package:cloth_collection/page/category/categoryProductView.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  CategoryController categoryController = CategoryController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      child: FutureBuilder(
        future: categoryController.getCategory().catchError((e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.toString()),
              );
            },
          );
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * Scale.width, vertical: 25 * Scale.height),
                itemCount: snapshot.data.length - 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 30 * Scale.height,
                    childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  return categoryIconArea(snapshot.data[index]);
                },
              );
            } else {
              return progressBar();
            }
          }
          return progressBar();
        },
      ),
    );
  }

  Widget categoryIconArea(Map<String, dynamic> category) {
    return GestureDetector(
      child: Column(
        children: [
          SvgPicture.network("${category["image_url"]}",
              width: 81 * Scale.width, height: 81 * Scale.width),
          SizedBox(height: 3.8 * Scale.height),
          Text("${category["name"]}",
              style: textStyle(const Color(0xff333333), FontWeight.w500,
                  "NotoSansKR", 14.0)),
        ],
      ),
      onTap: () {
        categoryController.selectMainCategory(category);
        Get.to(() => CategoryProductView(
              categoryController: categoryController,
            ));
      },
    );
  }
}
