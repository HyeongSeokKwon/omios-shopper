import 'package:cloth_collection/data/product.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/image_slide.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildScroll(width, width * 0.82)],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left, size: 35.0),
          ),
          Text(
            "${widget.product.name}",
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 20.0),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Image.asset("assets/images/shopping_basket.png"),
        )
      ],
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildScroll(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageSlideHasDot(width, width * 0.82),
          _buildStoreInfo(width, height),
          Divider(
            color: const Color(0xffeeeeee),
            indent: 22,
            endIndent: 22,
          ),
          _buildProductDetailInfo(width, height),
        ],
      ),
    );
  }

  Widget _buildStoreInfo(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(top: 24, left: 22, bottom: 20),
      child: Row(
        children: [
          Container(
            width: width * 0.13,
            height: width * 0.13,
            child: ClipRRect(
              child: Image.asset(widget.product.image),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          SizedBox(width: width * 0.039),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.product.store}",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 16.0),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Image.asset("assets/images/location.png"),
                  SizedBox(width: width * 0.01),
                  Text(
                    "${widget.product.location}",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductDetailInfo(double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 22),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.product.category} > ${widget.product.subCategory}",
              style: textStyle(
                  const Color(0xffbbbbbb), FontWeight.w400, "NotoSansKR", 13.0),
            ),
            SizedBox(height: 8),
            Text(
              "${widget.product.name}",
              style: textStyle(
                  const Color(0xff333333), FontWeight.w700, "NotoSansKR", 20.0),
            ),
            SizedBox(height: 4),
            Text(setPriceFormat(widget.product.price),
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 18.0)),
          ],
        ),
      ),
    );
  }
  // Widget _buildScroll(double width, double height) {
  //   return FutureBuilder(
  //     future: widget.product;
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.hasData) {
  //           return SingleChildScrollView(
  //             child: Column(
  //               children: [ImageSlideHasDot(width, width * 0.82)],
  //             ),
  //           );
  //         }
  //       } else if (snapshot.hasError) {
  //         print(snapshot.data);
  //       }
  //       return Center(
  //         child: CircularProgressIndicator(
  //           valueColor: AlwaysStoppedAnimation<Color>(
  //             Colors.transparent,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
