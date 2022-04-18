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
        ],
      ),
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
}
