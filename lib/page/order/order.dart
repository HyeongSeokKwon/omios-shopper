import 'package:cloth_collection/page/order/changeShippingAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../util/util.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
              "주문/결제",
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
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
      child: Column(
        children: [
          orderProduct(),
          divider(),
          shippingAddressArea(),
        ],
      ),
    );
  }

  Widget orderProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20 * Scale.height),
            child: Text("주문상품",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 21.0)),
          ),
          productInfo(),
          SizedBox(
            height: 14 * Scale.height,
          ),
          usingCoupon(),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0 * Scale.height),
      child:
          Divider(thickness: 10 * Scale.height, color: const Color(0xfffbfcfe)),
    );
  }

  Widget productInfo() {
    return Row(
      children: [
        Container(
          width: 80 * Scale.width,
          height: 80 * Scale.width * 4 / 3,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset("assets/images/임시상품1.png")),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
        SizedBox(
          width: 20 * Scale.width,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "킹 갓 가성비 슬렉스",
              style: textStyle(
                  const Color(0xff333333), FontWeight.w500, "NotoSansKR", 16.0),
            ),
            SizedBox(height: 5 * Scale.height),
            Text(
              "블랙 / L  |  수량 : 1개",
              style: textStyle(
                  const Color(0xff797979), FontWeight.w400, "NotoSansKR", 13.0),
            ),
            SizedBox(height: 12 * Scale.height),
            Text(
              "${setPriceFormat(28900)}원",
              style: textStyle(
                  const Color(0xff333333), FontWeight.w400, "NotoSansKR", 15.0),
            ),
          ],
        )
      ],
    );
  }

  Widget usingCoupon() {
    return Row(
      children: [
        Text(
          "쿠폰 사용: ",
          style: textStyle(
              const Color(0xff777777), FontWeight.w400, 'NotoSansKR', 13.0),
        ),
        SizedBox(
          width: 6 * Scale.width,
        ),
        InkWell(
          child: Container(
            width: 127 * Scale.width,
            height: 35 * Scale.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: const Color(0xffe2e2e2), width: 1),
                color: const Color(0xffffffff)),
            child: Center(
                child: Text(
              "적용가능 쿠폰 N장",
              style: textStyle(
                  const Color(0xff555555), FontWeight.w400, 'NotoSansKR', 13.0),
            )),
          ),
        ),
        SizedBox(width: 6 * Scale.width),
        Container(
          width: 112 * Scale.width,
          height: 35 * Scale.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: const Color(0xfff8f8f8)),
          child: Center(
            child: Text(
              "적립금 : 589원",
              style: textStyle(
                  const Color(0xff777777), FontWeight.w400, 'NotoSansKR', 13.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget shippingAddressArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "배송지",
                style:
                    textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangeShippingAddress()));
                },
                child: SizedBox(
                  width: 40 * Scale.width,
                  child: Text(
                    "변경",
                    style: textStyle(const Color(0xff888888), FontWeight.w400,
                        'NotoSansKR', 13.0),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16 * Scale.height),
            child: Divider(
                thickness: 1 * Scale.height, color: const Color(0xffeeeeee)),
          ),
          userInfo(),
          SizedBox(height: 10 * Scale.height),
          SizedBox(
            height: 40 * Scale.height,
            child: DropdownButtonFormField(
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Container(
                    width: 100,
                    child: Text(
                      "a",
                    ),
                  ),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Container(
                    width: 100,
                    child: Text(
                      "b",
                    ),
                  ),
                ),
              ],
              hint: Text(
                "배송시 요청사항을 선택하세요",
                style: textStyle(const Color(0xff555555), FontWeight.w400,
                    'NotoSansKR', 14.0),
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12 * Scale.width, vertical: 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xffe2e2e2)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xffe2e2e2)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xffe2e2e2)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              onChanged: (value) {},
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ],
      ),
    );
  }

  Widget userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "권형석",
          style: textStyle(
              const Color(0xff333333), FontWeight.w500, 'NotoSansKR', 16.0),
        ),
        SizedBox(height: 8 * Scale.height),
        Text(
          "인천광역시 서구 청라푸르지오 364동 3603호",
          style: textStyle(
              const Color(0xff555555), FontWeight.w400, 'NotoSansKR', 16.0),
        ),
        SizedBox(height: 4 * Scale.height),
        Text(
          "권형석 010-6651-7392",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, 'NotoSansKR', 14.0),
        ),
      ],
    );
  }
}
