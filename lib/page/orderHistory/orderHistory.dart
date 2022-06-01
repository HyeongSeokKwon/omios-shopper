import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/order_bloc/order_change_status/bloc/orderstatus_change_bloc.dart';
import 'package:cloth_collection/page/shippingAddress/changeShippingAddress.dart';
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
  static const String purchaseConfirmation = "구매 확정";
  static const String shippingCompledte = "배송 완료";
  static const String preparingShipping = "배송 준비 중";
  static const String shippingInProgress = "배송 중";
  static const String paymentComplete = "결제 완료";
  static const String waitingDeposit = "입금 대기";

  ShippingAddressBloc shippingAddressBloc = ShippingAddressBloc();
  OrderHistoryBloc orderHistoryBloc = OrderHistoryBloc();
  late OrderstatusChangeBloc orderstatusChangeBloc;

  @override
  Widget build(BuildContext context) {
    orderstatusChangeBloc = OrderstatusChangeBloc(
        shippingAddressBloc: shippingAddressBloc,
        orderHistoryBloc: orderHistoryBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => orderHistoryBloc),
        BlocProvider(create: (context) => orderstatusChangeBloc),
        BlocProvider(
          create: (context) => shippingAddressBloc,
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
                                return purchaseConfirmationArea(
                                    state.orderHistoryList[index], item);
                              case shippingCompledte:
                                return shippingCompletedArea(item);
                              case preparingShipping:
                                return preparingShippingArea(item);
                              case shippingInProgress:
                                return shippingInProgressArea(item);
                              case paymentComplete:
                                return paymentCompletedArea(
                                    state.orderHistoryList[index], item);
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

  Widget purchaseConfirmationButtons(
      OrderHistoryData orderHistoryData, Item item) {
    const String deliveryTracking = "배송 조회";
    const String writeReview = "리뷰 작성";
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 34 * Scale.width,
              child: Center(
                child: Text(
                  deliveryTracking,
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
                  writeReview,
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

  Widget purchaseConfirmationArea(
      OrderHistoryData orderHistoryData, Item item) {
    return orderStatusWidgetStructure(
        purchaseConfirmationButtons(orderHistoryData, item),
        purchaseConfirmation,
        item);
  }

  Widget shippingCompletedButtons() {
    const String exchange = "교환하기";
    const String deliveryTracking = "배송 조회";
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
                  exchange,
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
                  deliveryTracking,
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

  Widget paymentCompletedButtons(OrderHistoryData orderHistoryData, Item item) {
    return BlocBuilder<OrderstatusChangeBloc, OrderstatusChangeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(child: cancelOrderButton(orderHistoryData.id, item)),
            SizedBox(width: 6 * Scale.width),
            Expanded(child: changeShippingAddressButton(orderHistoryData)),
            SizedBox(width: 6 * Scale.width),
            Expanded(
              child: InkWell(
                onTap: () {
                  context.read<OrderstatusChangeBloc>().add(
                      ClickChangeOptionEvent(
                          productId: item.option['product_id']));
                  showModalBottomSheet<void>(
                    isDismissible: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (context) =>
                        BlocProvider<OrderstatusChangeBloc>.value(
                      value: orderstatusChangeBloc,
                      child: Stack(
                        children: [
                          BlocBuilder<OrderstatusChangeBloc,
                              OrderstatusChangeState>(
                            builder: (context, state) {
                              return GestureDetector(
                                child: Container(
                                    width: 414 * Scale.width,
                                    height: 896 * Scale.height,
                                    color: Colors.transparent),
                                onTap: Navigator.of(context).pop,
                              );
                            },
                          ),
                          BlocBuilder<OrderstatusChangeBloc,
                              OrderstatusChangeState>(
                            builder: (context, state) {
                              return Positioned(
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.6,
                                  maxChildSize: 1.0,
                                  builder: (_, controller) {
                                    return Stack(children: [
                                      Container(
                                        width: 414 * Scale.width,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 22 * Scale.width),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 25 * Scale.height,
                                                    bottom: 30 * Scale.height),
                                                child: Text("옵션 변경",
                                                    style: textStyle(
                                                        const Color(0xff333333),
                                                        FontWeight.w700,
                                                        "NotoSansKR",
                                                        21.0)),
                                              ),
                                              BlocProvider<
                                                  OrderHistoryBloc>.value(
                                                value: orderHistoryBloc,
                                                child: BlocBuilder<
                                                    OrderstatusChangeBloc,
                                                    OrderstatusChangeState>(
                                                  builder: (context, state) {
                                                    print(context
                                                        .read<
                                                            OrderstatusChangeBloc>()
                                                        .state
                                                        .getOptionInfoState);
                                                    if (state
                                                            .getOptionInfoState ==
                                                        ApiState.success) {
                                                      return Expanded(
                                                        child: Center(
                                                          child: ListView
                                                              .separated(
                                                            itemCount: state
                                                                .optionList
                                                                .length,
                                                            separatorBuilder:
                                                                (context,
                                                                    index) {
                                                              return const Divider();
                                                            },
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              return BlocBuilder<
                                                                  OrderHistoryBloc,
                                                                  OrderHistoryState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      if (isSameItemExist(
                                                                          orderHistoryData,
                                                                          context
                                                                              .read<OrderstatusChangeBloc>()
                                                                              .state
                                                                              .optionList[index]['option_id'])) {
                                                                        Navigator.pop(
                                                                            context);
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return showAlertDialog(context, "같은 주문에 동일 상품이 존재합니다.");
                                                                            });

                                                                        return;
                                                                      } else {
                                                                        Navigator.pop(
                                                                            context);
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              if (Platform.isIOS) {
                                                                                return BlocProvider.value(
                                                                                  value: orderstatusChangeBloc,
                                                                                  child: CupertinoAlertDialog(
                                                                                    content: BlocBuilder<OrderstatusChangeBloc, OrderstatusChangeState>(
                                                                                      builder: (context, state) {
                                                                                        return Text("${context.read<OrderstatusChangeBloc>().state.optionList[index]['color']} / ${context.read<OrderstatusChangeBloc>().state.optionList[index]['size']} 로 변경하시겠습니까?");
                                                                                      },
                                                                                    ),
                                                                                    actions: <Widget>[
                                                                                      BlocBuilder<OrderstatusChangeBloc, OrderstatusChangeState>(
                                                                                        builder: (context, state) {
                                                                                          return CupertinoDialogAction(
                                                                                            isDefaultAction: true,
                                                                                            child: Text("확인"),
                                                                                            onPressed: () {
                                                                                              context.read<OrderstatusChangeBloc>().add(ChangeOptionEvent(itemId: item.id, optionId: context.read<OrderstatusChangeBloc>().state.optionList[index]['option_id']));

                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                return AlertDialog(
                                                                                  content: Text(
                                                                                    "${context.read<OrderstatusChangeBloc>().state.optionList[index]['color'] / context.read<OrderstatusChangeBloc>().state.optionList[index]['size']}로 변경하시겠습니까?",
                                                                                    style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
                                                                                  ),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      child: Text(
                                                                                        "확인",
                                                                                        style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        context.read<OrderstatusChangeBloc>().add(ChangeOptionEvent(itemId: item.id, optionId: context.read<OrderstatusChangeBloc>().state.optionList[index]['option_id']));
                                                                                        context.read<OrderHistoryBloc>().add(InitOrderHistoryEvent());
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              }
                                                                            });
                                                                      }
                                                                    },
                                                                    child:
                                                                        SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(vertical: 10 * Scale.height),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              "${context.read<OrderstatusChangeBloc>().state.optionList[index]['color']} / ${context.read<OrderstatusChangeBloc>().state.optionList[index]['size']}",
                                                                              style: textStyle(Colors.black, FontWeight.w300, "NotoSansKR", 16.0),
                                                                            ),
                                                                            context.read<OrderstatusChangeBloc>().state.optionList[index]['option_id'] == item.option['id']
                                                                                ? SvgPicture.asset("assets/images/svg/accept.svg")
                                                                                : SizedBox()
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    } else if (state
                                                                .getOptionInfoState ==
                                                            ApiState.loading ||
                                                        state.getOptionInfoState ==
                                                            ApiState.initial) {
                                                      return progressBar();
                                                    } else {
                                                      return ErrorCard();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
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
            ),
          ],
        );
      },
    );
  }

  Widget paymentCompletedArea(OrderHistoryData orderHistoryData, Item item) {
    return orderStatusWidgetStructure(
        paymentCompletedButtons(orderHistoryData, item), "결제 완료", item);
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

  Widget changeShippingAddressButton(OrderHistoryData data) {
    return BlocBuilder<OrderstatusChangeBloc, OrderstatusChangeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            await _moveToShippingAddressSelection(context);
            context
                .read<OrderstatusChangeBloc>()
                .add(ChangeShippingAddressEvent(orderHistoryData: data));
          },
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
              border: Border.all(color: const Color(0xffe2e2e2), width: 1),
            ),
          ),
        );
      },
    );
  }

  Future<void> _moveToShippingAddressSelection(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChangeShippingAddress(shippingAddressBloc: shippingAddressBloc),
      ),
    );
  }

  Widget cancelOrderButton(
    int orderId,
    Item item,
  ) {
    return BlocBuilder<OrderstatusChangeBloc, OrderstatusChangeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            // context
            //     .read<OrderstatusChangeBloc>()
            //     .add(CancelOrderEvent(orderId: orderId, itemId: item.id));
          },
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
        );
      },
    );
  }

  bool isSameItemExist(OrderHistoryData orderHistoryData, int selectedOption) {
    for (var value in orderHistoryData.items) {
      if (value.option['id'] == selectedOption) {
        return true;
      }
    }
    return false;
  }
}
