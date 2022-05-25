import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../model/orderHistoryModel.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  static const String purchaseConfirmation = "결제 완료";
  static const String shippingCompledte = "배송 완료";
  static const String preparingShipping = "배송 준비 중";
  static const String shippingInProgress = "배송 중";
  static const String paymentComplete = "결제 완료";
  static const String waitingDeposit = "입금 대기";

  final OrderHistoryBloc orderHistoryBloc = OrderHistoryBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => orderHistoryBloc,
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
                "주문 내역",
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
      ),
    );
  }

  Widget scrollArea() {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        if (state.getOrderHistoryState == ApiState.initial) {
          context.read<OrderHistoryBloc>().add(InitOrderHistoryEvent());
          return progressBar();
        } else if (state.getOrderHistoryState == ApiState.success) {
          return SingleChildScrollView(
            child: Column(
              children: [
                summaryInfoArea(),
                filteringArea(),

                orderStatusArea(),
                // purchaseConfirmationArea(),
                // shippingCompletedArea(),
                // preparingShippingArea(),
                // shippingInProgressArea(),
                // paymentCompletedArea(),
                // waitingDepositArea(),
              ],
            ),
          );
        } else if (state.getOrderHistoryState == ApiState.fail) {
          return ErrorCard();
        } else {
          return progressBar();
        }
      },
    );
  }

  Widget orderStatusArea() {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
        return Padding(
          padding: EdgeInsets.only(top: 30 * Scale.height),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: context
                  .read<OrderHistoryBloc>()
                  .state
                  .orderHistoryList
                  .length,
              itemBuilder: (context, index) {
                if (context
                    .read<OrderHistoryBloc>()
                    .state
                    .orderHistoryList[index]
                    .items
                    .isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20 * Scale.width),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                "${formatter.format(state.orderHistoryList[index].createdAt)} / ",
                                style: textStyle(const Color(0xff666666),
                                    FontWeight.w400, 'NotoSansKR', 14),
                              ),
                              Text(
                                "${state.orderHistoryList[index].number}",
                                style: textStyle(const Color(0xff666666),
                                    FontWeight.w400, 'NotoSansKR', 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: const Color(0xffe2e2e2),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: context
                              .read<OrderHistoryBloc>()
                              .state
                              .orderHistoryList[index]
                              .items
                              .length,
                          itemBuilder: ((context, index2) {
                            Item item = context
                                .read<OrderHistoryBloc>()
                                .state
                                .orderHistoryList[index]
                                .items[index2];
                            switch (context
                                .read<OrderHistoryBloc>()
                                .state
                                .orderHistoryList[index]
                                .items[index2]
                                .status) {
                              case purchaseConfirmation:
                                return purchaseConfirmationArea(item);
                              case shippingCompledte:
                                return shippingCompletedArea(item);
                              case preparingShipping:
                                return preparingShippingArea(item);
                              case shippingInProgress:
                                return shippingInProgressArea(item);
                              case paymentComplete:
                                return paymentCompletedArea(item);
                              case waitingDeposit:
                                return waitingDepositArea(item);
                              default:
                                return SizedBox();
                            }
                          }))
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
        );
      },
    );
  }

  Widget productInfoArea(Item item) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              width: 74 * Scale.width,
              height: 74 * Scale.width * 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                      imageUrl: item.option['product_image_url'])),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
            ),
            SizedBox(
              width: 20 * Scale.width,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.option['product_name']}",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                  SizedBox(height: 4 * Scale.height),
                  Text(
                    "${item.option['display_color_name']}/${item.option['size']} | 수량 : ${item.count}",
                    style: textStyle(const Color(0xff797979), FontWeight.w400,
                        "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 8 * Scale.height),
                  Text(
                    "${setPriceFormat(item.paymentPrice)}원",
                    style: textStyle(const Color(0xff333333), FontWeight.w400,
                        "NotoSansKR", 15.0),
                  ),
                ],
              ),
            )
          ],
        );
      },
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
              selectDateArea("start"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6 * Scale.width),
                child: Container(
                    width: 8 * Scale.width,
                    height: 1,
                    decoration: BoxDecoration(color: const Color(0xffaaaaaa))),
              ),
              selectDateArea("end"),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectDateArea(String type) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return InkWell(
      onTap: (() {
        if (Platform.isIOS) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: orderHistoryBloc,
                child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
                  builder: (context, state) {
                    DateTime date = DateTime.now();
                    return SizedBox(
                      height: 300 * Scale.height,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoButton(
                                  child: Text('Done'),
                                  onPressed: () {
                                    switch (type) {
                                      case "start":
                                        context.read<OrderHistoryBloc>().add(
                                            ChangeStartTimeEvent(
                                                startTime: date));
                                        break;
                                      case "end":
                                        context.read<OrderHistoryBloc>().add(
                                            ChangeEndTimeEvent(endTime: date));
                                        break;
                                      default:
                                    }

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                maximumDate: DateTime.now(),
                                maximumYear: DateTime.now().year,
                                onDateTimeChanged: (value) {
                                  date = value;
                                }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now());
        }
      }),
      child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          return Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8 * Scale.width, vertical: 5 * Scale.height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    type == "start"
                        ? Text(
                            context.read<OrderHistoryBloc>().state.start !=
                                    DateTime(0)
                                ? "${formatter.format(state.start!)}"
                                : "선택",
                            style: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 13.0),
                          )
                        : Text(
                            context.read<OrderHistoryBloc>().state.end !=
                                    DateTime(0)
                                ? "${formatter.format(state.end!)}"
                                : "선택",
                            style: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 13.0),
                          ),
                    SizedBox(width: 10 * Scale.height),
                    SvgPicture.asset("assets/images/svg/calendar.svg")
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffe2e2e2), width: 1),
                  color: const Color(0xffffffff)));
        },
      ),
    );
  }

  Widget periodFilterButton(String period) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        final orderHistoryBloc = context.read<OrderHistoryBloc>();
        return InkWell(
          onTap: () {
            if (state.end != DateTime(0)) {
              switch (period) {
                case "1주일":
                  orderHistoryBloc.add(
                    ChangeStartTimeEvent(
                      startTime: state.end!.subtract(
                        const Duration(days: 7),
                      ),
                    ),
                  );
                  break;
                case "1개월":
                  orderHistoryBloc.add(
                    ChangeStartTimeEvent(
                        startTime: DateTime(state.end!.year,
                            state.end!.month - 1, state.end!.day)),
                  );
                  break;
                case "3개월":
                  orderHistoryBloc.add(
                    ChangeStartTimeEvent(
                        startTime: DateTime(state.end!.year,
                            state.end!.month - 3, state.end!.day)),
                  );
                  break;
                case "전체시기":
                  orderHistoryBloc.add(
                    ChangeStartTimeEvent(startTime: DateTime(0)),
                  );

                  orderHistoryBloc.add(
                    ChangeEndTimeEvent(endTime: DateTime(0)),
                  );
                  print(state.start);
                  print(state.end);
                  break;
                default:
              }
            }
          },
          child: Container(
            width: 70 * Scale.width,
            height: 32 * Scale.height,
            child: Center(
              child: Text(
                period,
                style: textStyle(const Color(0xff555555), FontWeight.w400,
                    "NotoSansKR", 13.0),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffe2e2e2), width: 1),
              color: const Color(0xffffffff),
            ),
          ),
        );
      },
    );
  }

  Widget orderStatusWidgetStructure(
      Widget buttonWidgets, String status, Item item) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20 * Scale.width,
          right: 20 * Scale.width,
          bottom: 30 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderStatusText(status),
          SizedBox(height: 10 * Scale.height),
          productInfoArea(item),
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

  Widget purchaseConfirmationArea(Item item) {
    return orderStatusWidgetStructure(
        purchaseConfirmationButtons(), purchaseConfirmation, item);
  }

  Widget shippingCompletedButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 34 * Scale.height,
              child: Center(
                child: Text(
                  purchaseConfirmation,
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

  Widget shippingCompletedArea(Item item) {
    return orderStatusWidgetStructure(shippingCompletedButtons(), "배송완료", item);
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

  Widget preparingShippingArea(Item item) {
    return orderStatusWidgetStructure(
        preparingShippingButtons(), "배송 준비 중", item);
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

  Widget shippingInProgressArea(Item item) {
    return orderStatusWidgetStructure(
        shippingInProgressButtons(), "배송 중", item);
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

  Widget paymentCompletedArea(Item item) {
    return orderStatusWidgetStructure(paymentCompletedButtons(), "결제 완료", item);
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

  Widget waitingDepositArea(Item item) {
    return Column(
      children: [
        orderStatusWidgetStructure(waitingDepositButtons(), "입금 대기", item),
      ],
    );
  }
}
