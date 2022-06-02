import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
            ),
            Text(
              "장바구니",
              style: textStyle(
                  const Color(0xff333333), FontWeight.w700, "NotoSansKR", 24.0),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
      ),
      body: scrollArea(),
      bottomSheet: Container(
        height: 80,
        color: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5 * Scale.width),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Text(
                "Total개  xx,xxx원",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50 * Scale.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Colors.red[400],
                ),
                child: Center(
                  child: Text(
                    "바로구매",
                    style: textStyle(
                        Colors.white, FontWeight.w400, 'NotoSansKR', 17.0),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
      child: Column(
        children: [
          productInfoArea(),
          productInfoArea(),
          productInfoArea(),
          productInfoArea(),
          productInfoArea(),
          productInfoArea(),
        ],
      ),
    );
  }

  Widget productInfoArea() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
              child: SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  activeColor: Colors.grey[500],
                  side: BorderSide(
                      color: Colors.grey[500]!, width: 1 * Scale.width),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20 * Scale.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productPicture(),
                        SizedBox(width: 10 * Scale.width),
                        Text(
                          "상품 이름",
                          style: textStyle(Colors.black, FontWeight.w500,
                              'NotoSansKR', 17.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 15 * Scale.height),
                    optionArea(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
          child: Divider(
            thickness: 1,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Total Price",
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 18)),
            ],
          ),
        )
      ],
    );
  }

  Widget productPicture() {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            width: 75 * Scale.width,
            height: 75 * (4 / 3) * Scale.width,
            fit: BoxFit.fill,
            imageUrl:
                "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/sample/product_21.jpg",
            fadeInDuration: Duration(milliseconds: 0),
            placeholder: (context, url) {
              return Container(
                  color: Colors.grey[200], width: 30, height: 30 * (4 / 3));
            },
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
    );
  }

  Widget optionArea() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
              color: Colors.grey[100]),
          child: Padding(
            padding: EdgeInsets.all(10.0 * Scale.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "display_color_name / size",
                  style: textStyle(const Color(0xff333333), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
                SizedBox(
                  height: 10 * Scale.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            child: SvgPicture.asset(
                                "assets/images/svg/minus.svg",
                                width: 18 * Scale.width,
                                height: 18,
                                fit: BoxFit.scaleDown),
                            onTap: () {}),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8 * Scale.width),
                          child: Text(
                            "xxx개",
                            style: textStyle(const Color(0xff444444),
                                FontWeight.w400, "NotoSansKR", 14.0),
                          ),
                        ),
                        GestureDetector(
                            child: SvgPicture.asset(
                                "assets/images/svg/plus.svg",
                                width: 18 * Scale.width,
                                height: 18,
                                fit: BoxFit.scaleDown),
                            onTap: () {}),
                      ],
                    ),
                    Text(
                      "xxxxxxxxx원",
                      style: textStyle(Color(0xff333333), FontWeight.w500,
                          "NotoSansKR", 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 12 * Scale.width,
          right: 12 * Scale.width,
          child: GestureDetector(
              child: SvgPicture.asset("assets/images/svg/productCancel.svg"),
              onTap: () {}),
        ),
      ],
    );
  }
}
