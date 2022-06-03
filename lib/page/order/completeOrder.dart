import 'package:cloth_collection/page/shippingAddress/changeShippingAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../util/util.dart';

class CompleteOrder extends StatelessWidget {
  final OrderBloc orderBloc;
  final ShippingAddressBloc shippingAddressBloc;
  const CompleteOrder(
      {Key? key, required this.orderBloc, required this.shippingAddressBloc})
      : super(key: key);

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
            Padding(
              padding: EdgeInsets.only(left: 20 * Scale.width),
              child: Text(
                "주문/결제",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: orderBloc),
          BlocProvider.value(value: shippingAddressBloc),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 30 * Scale.height),
            messageArea(),
            SizedBox(height: 30 * Scale.height),
            shippingInfoArea(),
            SizedBox(height: 30 * Scale.height),
            paymentInfoArea(),
            SizedBox(height: 30 * Scale.height),
            pageRouteButtonArea(),
          ]),
        ),
      ),
    );
  }

  Widget messageArea() {
    const String message = "주문이 정상적으로 완료되었습니다.";
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            message,
            style: textStyle(Colors.black, FontWeight.w700, 'NotoSansKR', 18.0),
          ),
          SizedBox(height: 10 * Scale.height),
          Text(
            "주문번호 XXXXXXXXX",
            style: textStyle(
                Colors.grey[400]!, FontWeight.w400, 'NotoSansKR', 15.0),
          )
        ],
      ),
    );
  }

  Widget shippingInfoArea() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "배송지 정보",
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeShippingAddress(
                                  shippingAddressBloc: shippingAddressBloc)));
                      context.read<ShippingAddressBloc>().add(
                          ChangeShippingAddressEvent(
                              orderId:
                                  context.read<OrderBloc>().state.orderId!));
                    },
                    child: Text(
                      "변경하기",
                      style: textStyle(
                          Colors.red, FontWeight.w500, 'NotoSansKR', 15.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * Scale.height),
              Row(
                children: [
                  Text(
                    "수령인",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
                  ),
                  SizedBox(width: 20 * Scale.width),
                  Text(
                    state.recipient,
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
                  ),
                  SizedBox(width: 15 * Scale.width),
                  Text(
                    state.mobilePhoneNumber,
                    style: textStyle(
                        Colors.grey[500]!, FontWeight.w400, 'NotoSansKR', 15.0),
                  ),
                ],
              ),
              SizedBox(height: 10 * Scale.height),
              Row(
                children: [
                  Text(
                    "배송지",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
                  ),
                  SizedBox(width: 20 * Scale.width),
                  Text(
                    state.baseAddress + " " + state.detailAddress,
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget paymentInfoArea() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "결제 금액",
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
                ),
                SizedBox(width: 20 * Scale.width),
                Text(
                  setPriceFormat(state.finalPaymentPrice) + "원",
                  style: textStyle(
                      Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
                ),
              ],
            ),
            Text(
              "결제 수단",
              style: textStyle(
                  Colors.grey[500]!, FontWeight.w400, 'NotoSansKR', 15.0),
            ),
          ],
        );
      },
    );
  }

  Widget pageRouteButtonArea() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50 * Scale.height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[500]!),
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
            ),
            child: Center(
              child: Text(
                "주문 상세보기",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10 * Scale.width,
        ),
        Expanded(
          child: Container(
            height: 50 * Scale.height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[500]!),
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
            ),
            child: Center(
              child: Text(
                "계속 쇼핑하기",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
