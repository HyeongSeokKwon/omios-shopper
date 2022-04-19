import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
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
              "주문 내역",
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
          summaryInfoArea(),
          filteringArea(),
          purchaseConfirmationArea(),
          shippingCompletedArea(),
          preparingShippingArea(),
          shippingInProgressArea(),
          paymentCompletedArea(),
          waitingDepositArea(),
        ],
      ),
    );
  }

  Widget productInfoArea() {
    return Row(
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
              style: textStyle(
                  const Color(0xff333333), FontWeight.w500, "NotoSansKR", 16.0),
            ),
            SizedBox(height: 12 * Scale.height),
            Text(
              "블랙 / L | 수량 : 1",
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

  Widget summaryInfoArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xfff2f4f9), width: 1),
          color: const Color(0xfffbfcfe),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 19.5 * Scale.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              summaryInfoColumn("입금대기", 0),
              summaryInfoColumn("결제완료", 0),
              summaryInfoColumn("배송준비", 0),
              summaryInfoColumn("배송중", 0),
              summaryInfoColumn("배송완료", 0),
              summaryInfoColumn("구매확정", 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryInfoColumn(String title, int num) {
    return Column(
      children: [
        Text(
          title,
          style: textStyle(
              const Color(0xff666666), FontWeight.w400, "NotoSansKR", 13.0),
        ),
        Text(
          "$num",
          style: textStyle(
              title == "구매확정"
                  ? const Color(0xffec5363)
                  : const Color(0xff333333),
              FontWeight.w500,
              "NotoSansKR",
              20.0),
        )
      ],
    );
  }

  Widget filteringArea() {
    return Padding(
      padding: EdgeInsets.only(left: 20 * Scale.width, top: 30 * Scale.height),
      child: Column(
        children: [
          Row(
            children: [
              periodFilterButton("1주일"),
              SizedBox(width: 6 * Scale.width),
              periodFilterButton("1개월"),
              SizedBox(width: 6 * Scale.width),
              periodFilterButton("3개월"),
              SizedBox(width: 6 * Scale.width),
              periodFilterButton("전체시기"),
            ],
          ),
          SizedBox(
            height: 9 * Scale.height,
          ),
          Row(
            children: [
              Container(
                  width: 90 * Scale.width,
                  height: 32,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8 * Scale.width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "선택",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 13.0),
                        ),
                        SvgPicture.asset("assets/images/svg/calendar.svg")
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffe2e2e2), width: 1),
                      color: const Color(0xffffffff))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6 * Scale.width),
                child: Container(
                    width: 8 * Scale.width,
                    height: 1,
                    decoration: BoxDecoration(color: const Color(0xffaaaaaa))),
              ),
              Container(
                  width: 90 * Scale.width,
                  height: 32,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8 * Scale.width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "선택",
                          style: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 13.0),
                        ),
                        SvgPicture.asset("assets/images/svg/calendar.svg")
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffe2e2e2), width: 1),
                      color: const Color(0xffffffff))),
            ],
          ),
        ],
      ),
    );
  }

  Widget periodFilterButton(String period) {
    return Container(
      width: 70 * Scale.width,
      height: 32 * Scale.height,
      child: Center(
        child: Text(
          period,
          style: textStyle(
              const Color(0xff555555), FontWeight.w400, "NotoSansKR", 13.0),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe2e2e2), width: 1),
        color: const Color(0xffffffff),
      ),
    );
  }

  Widget orderStatusWidgetStructure(Widget buttonWidgets, String status) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20.0 * Scale.width,
          right: 20.0 * Scale.width,
          top: 10 * Scale.height,
          bottom: 10 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderStatusText(status),
          SizedBox(height: 10 * Scale.height),
          productInfoArea(),
          SizedBox(height: 10 * Scale.height),
          buttonWidgets,
        ],
      ),
    );
  }

  Widget orderStatusText(String status) {
    switch (status) {
      case "구매확정":
        return Text(
          status,
          style: textStyle(
              const Color(0xffec5363), FontWeight.w400, "NotoSansKR", 16.0),
        );
      case "배송완료":
        return Text(
          status,
          style: textStyle(
              const Color(0xffec5363), FontWeight.w400, "NotoSansKR", 16.0),
        );
      case "배송 준비 중":
        return Text(
          status,
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 16.0),
        );
      case "배송 중":
        return Text(
          status,
          style: textStyle(
              const Color(0xff3ca4ff), FontWeight.w400, "NotoSansKR", 16.0),
        );
      case "결제 완료":
        return Text(
          status,
          style: textStyle(
              const Color(0xff3ca4ff), FontWeight.w400, "NotoSansKR", 16.0),
        );
      case "입금 대기":
        return Text(
          "배송 조회",
          style: textStyle(
              const Color(0xffff5548), FontWeight.w400, "NotoSansKR", 16.0),
        );
      default:
        return SizedBox();
    }
  }

  Widget purchaseConfirmationButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 34 * Scale.width,
              child: Center(
                child: Text(
                  "배송 조회",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        ),
        SizedBox(width: 6 * Scale.width),
        Expanded(
          child: Container(
              height: 34 * Scale.width,
              child: Center(
                child: Text(
                  "리뷰 작성",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        )
      ],
    );
  }

  Widget purchaseConfirmationArea() {
    return orderStatusWidgetStructure(purchaseConfirmationButtons(), "구매확정");
  }

  Widget shippingCompletedButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "구매 확정",
                  style: textStyle(const Color(0xffffffff), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  color: const Color(0xffec5363),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        ),
        SizedBox(
          width: 6 * Scale.width,
        ),
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "교환하기",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        ),
        SizedBox(
          width: 6 * Scale.width,
        ),
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "배송 조회",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        ),
        SizedBox(width: 6 * Scale.width),
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "반품 조회",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        )
      ],
    );
  }

  Widget shippingCompletedArea() {
    return orderStatusWidgetStructure(shippingCompletedButtons(), "배송완료");
  }

  Widget preparingShippingButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 34 * Scale.height,
            child: Center(
              child: Text(
                "배송 조회",
                style: textStyle(const Color(0xff666666), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: const Color(0xffe2e2e2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget preparingShippingArea() {
    return orderStatusWidgetStructure(preparingShippingButtons(), "배송 준비 중");
  }

  Widget shippingInProgressButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 34 * Scale.height,
            child: Center(
              child: Text(
                "주문 취소",
                style: textStyle(const Color(0xfff20000), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xfffff2f2),
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: const Color(0xffffe6e6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shippingInProgressArea() {
    return orderStatusWidgetStructure(shippingInProgressButtons(), "배송 중");
  }

  Widget paymentCompletedButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 34 * Scale.height,
            child: Center(
              child: Text(
                "주문 취소",
                style: textStyle(const Color(0xfff20000), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xfffff2f2),
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: const Color(0xffffe6e6),
              ),
            ),
          ),
        ),
        SizedBox(width: 6 * Scale.width),
        Expanded(
          child: Container(
            height: 34 * Scale.height,
            child: Center(
              child: Text(
                "배송지 변경",
                style: textStyle(const Color(0xff666666), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: const Color(0xffe2e2e2),
              ),
            ),
          ),
        ),
        SizedBox(width: 6 * Scale.width),
        Expanded(
          child: Container(
            height: 34 * Scale.height,
            child: Center(
              child: Text(
                "옵션 변경",
                style: textStyle(const Color(0xff666666), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: const Color(0xffe2e2e2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentCompletedArea() {
    return orderStatusWidgetStructure(paymentCompletedButtons(), "결제 완료");
  }

  Widget waitingDepositButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "주문 취소",
                  style: textStyle(const Color(0xfff20000), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  color: const Color(0xfffff2f2),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffffe6e6), width: 1))),
        ),
        SizedBox(
          width: 6 * Scale.width,
        ),
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "계좌 조회",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        ),
        SizedBox(
          width: 6 * Scale.width,
        ),
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "배송지 변경",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        ),
        SizedBox(width: 6 * Scale.width),
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  "옵션 변경",
                  style: textStyle(const Color(0xff666666), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border:
                      Border.all(color: const Color(0xffe2e2e2), width: 1))),
        )
      ],
    );
  }

  Widget waitingDepositArea() {
    return Column(
      children: [
        orderStatusWidgetStructure(waitingDepositButtons(), "입금 대기"),
      ],
    );
  }
}
