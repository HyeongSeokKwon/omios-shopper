import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset("assets/images/svg/cart.svg"),
            SizedBox(height: 20 * Scale.height),
            Text('장바구니에 담은 상품이 없어요.',
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 17.0)),
            SizedBox(height: 10 * Scale.height),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute<dynamic>(
                //       builder: (BuildContext context) => HomePage(),
                //     ),
                //     (route) => false);
              },
              child: Container(
                width: 150 * Scale.height,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '상품 담으러 가기',
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
