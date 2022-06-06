import 'package:cloth_collection/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';
import '../shippingAddress/changeShippingAddress.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final ShippingAddressBloc shippingAddressBloc = ShippingAddressBloc();
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => shippingAddressBloc),
        ),
      ],
      child: Scaffold(
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
                "교환 신청",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: scrollArea(),
        bottomSheet: bottomBarArea(),
      ),
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 80 * Scale.height),
        child: Column(
          children: [
            exchangeProductArea(),
            widgetDivider(),
            exchangeReasonArea(),
            widgetDivider(),
            exchangeWay(),
            widgetDivider(),
            retrieveLocationArea(),
            widgetDivider(),
            precautionsArea(),
          ],
        ),
      ),
    );
  }

  Widget exchangeProductArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
            child: Text(
              "교환 상품",
              style:
                  textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: ((context, index) {
              return productInfoArea();
            }),
          ),
        ],
      ),
    );
  }

  Widget productInfoArea() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 74 * Scale.width,
                height: 74 * Scale.width * 4 / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset('assets/images/임시상품4.png')),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
              ),
              SizedBox(
                width: 13 * Scale.width,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Name",
                      style: textStyle(const Color(0xff333333), FontWeight.w500,
                          "NotoSansKR", 16.0),
                    ),
                    SizedBox(height: 4 * Scale.height),
                    Text(
                      "Color | 수량 : Count",
                      style: textStyle(const Color(0xff797979), FontWeight.w400,
                          "NotoSansKR", 13.0),
                    ),
                    SizedBox(height: 8 * Scale.height),
                    Text(
                      "Product Price",
                      style: textStyle(const Color(0xff333333), FontWeight.w400,
                          "NotoSansKR", 15.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget exchangeReasonArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "교환 사유",
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
          ),
          SizedBox(height: 5 * Scale.height),
          Text(
            "단순 변심과 상품 문제 중 하나만 선택해주세요.",
            style: textStyle(Colors.red, FontWeight.w500, 'NotoSansKR', 12.0),
          ),
          SizedBox(height: 20 * Scale.height),
          Text(
            "단순 변심",
            style: textStyle(Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 5 * Scale.height,
            ),
            height: 45 * Scale.height,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey[400]!, width: 1.5 * Scale.width),
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
            ),
          ),
          Text(
            "상품 문제",
            style: textStyle(Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 5 * Scale.height,
            ),
            height: 45 * Scale.height,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey[400]!, width: 1.5 * Scale.width),
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exchangeWay() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "교환 방법 선택",
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
          ),
          SizedBox(height: 5 * Scale.height),
          Text(
            "교환 및 상품 회수는 Omios가 할게요",
            style: textStyle(Colors.red, FontWeight.w500, 'NotoSansKR', 12.0),
          ),
          SizedBox(height: 15 * Scale.height),
          Row(
            children: [
              Text(
                "반품 방법",
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 30 * Scale.width, right: 5 * Scale.width),
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: Checkbox(
                    value: true,
                    onChanged: (_) {},
                    activeColor: MAINCOLOR,
                  ),
                ),
              ),
              Text(
                "회수해 주세요",
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget retrieveLocationArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "회수지 정보",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ChangeShippingAddress(
                                shippingAddressBloc: shippingAddressBloc,
                              ))));
                },
                child: Text(
                  "회수지 변경",
                  style: textStyle(
                      Colors.grey[500]!, FontWeight.w500, 'NotoSansKR', 16.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * Scale.height),
          Text(
            "Receiver",
            style: textStyle(
                const Color(0xff333333), FontWeight.w500, 'NotoSansKR', 16.0),
          ),
          SizedBox(height: 8 * Scale.height),
          Text(
            "Address",
            style: textStyle(
                const Color(0xff555555), FontWeight.w400, 'NotoSansKR', 16.0),
          ),
          SizedBox(height: 4 * Scale.height),
          Text(
            "MobileNumber}",
            style: textStyle(
                const Color(0xff999999), FontWeight.w400, 'NotoSansKR', 14.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
            child: Divider(
              color: Colors.grey[400],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "회수 택배사",
                style: textStyle(const Color(0xff555555), FontWeight.w400,
                    'NotoSansKR', 16.0),
              ),
              Text(
                "CJ대한통운",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    'NotoSansKR', 16.0),
              ),
            ],
          ),
          SizedBox(height: 10 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "교환 배송비",
                style: textStyle(const Color(0xff555555), FontWeight.w400,
                    'NotoSansKR', 16.0),
              ),
              Text(
                "0원",
                style:
                    textStyle(MAINCOLOR, FontWeight.w700, 'NotoSansKR', 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget precautionsArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "주의사항",
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
          ),
          SizedBox(height: 15 * Scale.height),
          Container(
            height: 200 * Scale.height,
            width: double.maxFinite,
            color: Colors.grey[200],
            child: Center(
              child: Text(
                "교환 시 주의사항 내용",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomBarArea() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.maxFinite,
        height: 65 * Scale.height,
        color: const Color(0xffec5363),
        child: Center(
          child: Text(
            "교환하기",
            style: textStyle(Colors.white, FontWeight.w500, "NotoSansKR", 18.0),
          ),
        ),
      ),
    );
  }

  Widget widgetDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25 * Scale.height),
      child: Divider(
        thickness: 10 * Scale.height,
        color: Colors.grey[50],
      ),
    );
  }
}
