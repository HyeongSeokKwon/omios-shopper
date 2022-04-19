import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
              "주문상세정보",
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
        titleArea(),
        Divider(
          thickness: 1 * Scale.width,
          color: Colors.grey,
        ),
        purchaseConfirmationArea(),
        exchangeRequestArea(),
        discountInfoArea(),
        paymentInfoArea(),
        //htmlExample()
      ],
    ));
  }

  Widget titleArea() {
    return Padding(
      padding: EdgeInsets.only(
        left: 22 * Scale.width,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("주문번호 : 48131864",
                style: textStyle(const Color(0xff333333), FontWeight.w400,
                    "NotoSansKR", 13.0)),
            SizedBox(
              width: 40 * Scale.width,
            ),
            Text("주문일자 : 2022.01.28.15:32",
                style: textStyle(const Color(0xff333333), FontWeight.w400,
                    "NotoSansKR", 13.0)),
          ],
        ),
      ]),
    );
  }

  Widget purchaseConfirmationArea() {
    return Padding(
      padding: EdgeInsets.only(
        left: 22 * Scale.width,
        right: 22 * Scale.width,
        top: 15 * Scale.width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "구매확정",
            style: textStyle(
                const Color(0xffec5363), FontWeight.w500, "NotoSansKR", 16.0),
          ),
          SizedBox(height: 10 * Scale.height),
          Row(
            children: [
              Container(
                width: 74 * Scale.width,
                height: 74 * Scale.width * 4 / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
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
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                  SizedBox(height: 12 * Scale.height),
                  Text(
                    "블랙 / L | 수량 : 1",
                    style: textStyle(const Color(0xff797979), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 12 * Scale.height),
                  Text(
                    "${setPriceFormat(28900)}원",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 15.0),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10 * Scale.height),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: const Color(0xfffafafa)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "쿠폰할인:  -${setPriceFormat(1640)}원 (베이식 브랜드 10% 쿠폰)",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 4 * Scale.height),
                  Text(
                    "등급할인:  -${setPriceFormat(148)}원 (사파이어 3%)",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 4 * Scale.height),
                  Text(
                    "적립금:  +${setPriceFormat(1640)}원 ",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10 * Scale.height),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border:
                        Border.all(color: const Color(0xffec5363), width: 1),
                    color: const Color(0xffec5363),
                  ),
                  child: Center(
                    child: Text(
                      "구매 확정",
                      style: textStyle(const Color(0xffffffff), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6 * Scale.width),
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "교환하기",
                      style: textStyle(const Color(0xff666666), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6 * Scale.width),
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: const Color(0xffe2e2e2)),
                  ),
                  child: Center(
                    child: Text(
                      "배송 조회",
                      style: textStyle(const Color(0xff666666), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6 * Scale.width),
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "반품하기",
                      style: textStyle(const Color(0xff666666), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget exchangeRequestArea() {
    return Padding(
      padding: EdgeInsets.only(
        left: 22 * Scale.width,
        right: 22 * Scale.width,
        top: 15 * Scale.width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "교환요청",
            style: textStyle(
                const Color(0xff999999), FontWeight.w500, "NotoSansKR", 16.0),
          ),
          SizedBox(height: 10 * Scale.height),
          Row(
            children: [
              Container(
                width: 74 * Scale.width,
                height: 74 * Scale.width * 4 / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
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
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                  SizedBox(height: 12 * Scale.height),
                  Text(
                    "블랙 / L | 수량 : 1",
                    style: textStyle(const Color(0xff797979), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 12 * Scale.height),
                  Text(
                    "${setPriceFormat(28900)}원",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 15.0),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10 * Scale.height),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: const Color(0xfffafafa)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "쿠폰할인:  -${setPriceFormat(1640)}원 (베이식 브랜드 10% 쿠폰)",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 4 * Scale.height),
                  Text(
                    "등급할인:  -${setPriceFormat(148)}원 (사파이어 3%)",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 4 * Scale.height),
                  Text(
                    "적립금:  +${setPriceFormat(1640)}원 ",
                    style: textStyle(const Color(0xff999999), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10 * Scale.height),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border:
                        Border.all(color: const Color(0xffec5363), width: 1),
                    color: const Color(0xffec5363),
                  ),
                  child: Center(
                    child: Text(
                      "구매 확정",
                      style: textStyle(const Color(0xffffffff), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6 * Scale.width),
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border:
                          Border.all(color: const Color(0xff333333), width: 1),
                      color: const Color(0xff333333)),
                  child: Center(
                    child: Text(
                      "교환정보",
                      style: textStyle(const Color(0xffffffff), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6 * Scale.width),
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: const Color(0xffe2e2e2)),
                  ),
                  child: Center(
                    child: Text(
                      "배송 조회",
                      style: textStyle(const Color(0xff666666), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6 * Scale.width),
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "반품하기",
                      style: textStyle(const Color(0xff666666), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget htmlExample() {
  //   final _htmlContent = """
  //     <div>
  //   <h1>This is a title</h1>
  //   <p>This is a <strong>paragraph</strong>.</p>
  //   <p>I like <i>dogs</i></p>
  //   <p>Red text</p>
  //   <ul>
  //       <li>List item 1</li>
  //       <li>List item 2</li>
  //       <li>List item 3</li>
  //   </ul>
  //   <img src='https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg' />
  // </div>
  //   """;
  //   //return Html(data: _htmlContent);
  // }

  Widget exchangeInfoArea() {
    return Column(
      children: [Row()],
    );
  }

  Widget exchangeInfoRow(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [],
    );
  }

  Widget discountInfoRow(String title, int price) {
    return Row(
      children: [
        Container(
          width: 120 * Scale.width,
          child: Text(
            "$title",
            style: textStyle(
                const Color(0xff797979), FontWeight.w400, "NotoSansKR", 14.0),
          ),
        ),
        Text("${setPriceFormat(price)}원",
            style: textStyle(
                const Color(0xff797979), FontWeight.w400, "NotoSansKR", 14.0))
      ],
    );
  }

  Widget discountInfoArea() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20 * Scale.width, vertical: 40 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "할인 정보",
            style: textStyle(
                const Color(0xff333333), FontWeight.w500, "NotoSansKR", 18.0),
          ),
          SizedBox(height: 14 * Scale.height),
          Container(
            height: 162 * Scale.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xfff2f4f9), width: 1),
              color: const Color(0xfffbfcfe),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20 * Scale.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  discountInfoRow("상품 할인", -5400),
                  SizedBox(height: 14 * Scale.height),
                  discountInfoRow("등급 할인", -556),
                  SizedBox(height: 14 * Scale.height),
                  discountInfoRow("쿠폰 할인", -2500),
                  SizedBox(height: 14 * Scale.height),
                  Row(
                    children: [
                      Container(
                        width: 120 * Scale.width,
                        child: Text(
                          "총 할인 금액",
                          style: textStyle(const Color(0xff333333),
                              FontWeight.w500, "NotoSansKR", 14.0),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "-${setPriceFormat(8000)}원",
                            style: textStyle(const Color(0xff333333),
                                FontWeight.w700, "NotoSansKR", 14.0)),
                        TextSpan(
                            text: "(-12%)",
                            style: textStyle(const Color(0xffec5363),
                                FontWeight.w400, "NotoSansKR", 13.0)),
                      ]))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentInfoArea() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20 * Scale.width, 0, 20 * Scale.width, 55 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "결제 정보",
            style: textStyle(
                const Color(0xff333333), FontWeight.w500, "NotoSansKR", 18.0),
          ),
          SizedBox(height: 14 * Scale.height),
          Container(
            height: 162 * Scale.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xfff2f4f9), width: 1),
              color: const Color(0xfffbfcfe),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20 * Scale.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  discountInfoRow("상품 금액", 23280),
                  SizedBox(height: 14 * Scale.height),
                  discountInfoRow("총 할인금액", -8000),
                  SizedBox(height: 14 * Scale.height),
                  discountInfoRow("쿠폰 할인", -2500),
                  SizedBox(height: 14 * Scale.height),
                  Row(
                    children: [
                      Container(
                        width: 120 * Scale.width,
                        child: Text(
                          "결제 금액",
                          style: textStyle(const Color(0xff333333),
                              FontWeight.w500, "NotoSansKR", 14.0),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "${setPriceFormat(15820)}원 ",
                            style: textStyle(const Color(0xff333333),
                                FontWeight.w700, "NotoSansKR", 14.0)),
                        TextSpan(
                            text: " 카카오페이 결제",
                            style: textStyle(const Color(0xffec5363),
                                FontWeight.w400, "NotoSansKR", 13.0)),
                      ]))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
