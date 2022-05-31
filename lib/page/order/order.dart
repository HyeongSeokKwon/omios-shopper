import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/model/orderProduct.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/bloc.dart';
import '../../util/util.dart';
import '../shippingAddress/changeShippingAddress.dart';

class Order extends StatefulWidget {
  final OrderBloc orderBloc;
  Order({Key? key, required this.orderBloc}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final ShippingAddressBloc shippingAddressBloc = ShippingAddressBloc();
  final ShopperInfoBloc shopperInfoBloc = ShopperInfoBloc();
  TextEditingController requirementController = TextEditingController();
  @override
  void initState() {
    widget.orderBloc.shippingAddressBloc = shippingAddressBloc;
    widget.orderBloc.shopperInfoBloc = shopperInfoBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopperInfoBloc>(
          create: ((context) => shopperInfoBloc),
        ),
        BlocProvider.value(value: widget.orderBloc),
        BlocProvider<ShippingAddressBloc>(
            create: (context) => shippingAddressBloc)
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
                "주문/결제",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
          builder: (context, state) {
            final shippingAddressBloc = context.read<ShippingAddressBloc>();
            final shopperInfoBloc = context.read<ShopperInfoBloc>();

            return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
              builder: (context, state) {
                print(state.getDefaultShippingAddressState);
                print(shopperInfoBloc.state.getShopperInfoState);
                if (shippingAddressBloc.state.getDefaultShippingAddressState ==
                        ApiState.initial &&
                    shopperInfoBloc.state.getShopperInfoState ==
                        ApiState.initial) {
                  shippingAddressBloc.add(InitDataEvent());
                  shopperInfoBloc.add(GetShopperInfoEvent());
                  return progressBar();
                } else if (shippingAddressBloc
                            .state.getDefaultShippingAddressState ==
                        ApiState.success &&
                    shopperInfoBloc.state.getShopperInfoState ==
                        ApiState.success) {
                  return scrollArea();
                } else if (shippingAddressBloc
                            .state.getDefaultShippingAddressState ==
                        ApiState.fail ||
                    shopperInfoBloc.state.getShopperInfoState ==
                        ApiState.fail) {
                  return progressBar();
                } else {
                  return progressBar();
                }
              },
            );
          },
        ),
        bottomSheet: BlocConsumer<OrderBloc, OrderState>(
          listener: ((context, state) {
            if (state.registOrderState == ApiState.success) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("주문 성공"),
                    );
                  });
            }
          }),
          builder: (context, state) {
            return InkWell(
              onTap: () {
                print("ontap");
                print(requirementController.text);
                context
                    .read<OrderBloc>()
                    .add(RegistOrderEvent(requirementController.text));
              },
              child: Container(
                width: double.maxFinite,
                height: 65 * Scale.height,
                color: const Color(0xffec5363),
                child: Center(
                  child: Text(
                    "결제하기",
                    style: textStyle(
                        Colors.white, FontWeight.w500, "NotoSansKR", 18.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100.0 * Scale.height),
        child: Column(
          children: [
            orderProduct(),
            divider(14, 30, 30, const Color(0xfffafafa)),
            shippingAddressArea(),
            pointArea(),
            paymentArea(),
            divider(14, 50, 30, const Color(0xfffafafa)),
            amountOfPaymentArea(),
          ],
        ),
      ),
    );
  }

  Widget orderProduct() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        print(context.read<OrderBloc>().state.productCart);
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.read<OrderBloc>().state.productCart.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20 * Scale.height),
                      child: Text(
                        "주문상품",
                        style: textStyle(
                            Colors.black, FontWeight.w500, 'NotoSansKR', 21.0),
                      ),
                    ),
                    productInfo(
                        context.read<OrderBloc>().state.productCart[index]),
                    SizedBox(
                      height: 14 * Scale.height,
                    ),
                    usingCoupon(),
                  ],
                ),
              );
            });
      },
    );
  }

  Widget divider(int h, int topEdgeInset, int bottomEdgeInset, Color color) {
    return Padding(
      padding: EdgeInsets.only(
          top: topEdgeInset * Scale.height,
          bottom: bottomEdgeInset * Scale.height),
      child: Divider(
        thickness: h * Scale.height,
        color: color,
      ),
    );
  }

  Widget productInfo(OrderProduct orderProduct) {
    return Row(
      children: [
        Container(
          width: 80 * Scale.width,
          height: 80 * Scale.width * 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: CachedNetworkImage(
              imageUrl: orderProduct.imageUrl,
              fit: BoxFit.fill,
              width: 414 * Scale.width,
              height: 1.2 * 414 * Scale.width,
            ),
          ),
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
                "${orderProduct.name}",
                style: textStyle(
                  const Color(0xff333333),
                  FontWeight.w500,
                  "NotoSansKR",
                  16.0,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5 * Scale.height),
              Text(
                "${orderProduct.color['display_color_name']} / ${orderProduct.size}  |  수량 : ${orderProduct.count}",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 13.0),
              ),
              SizedBox(height: 12 * Scale.height),
              Text(
                "${setPriceFormat(orderProduct.baseDiscountedPrice * orderProduct.count)}원",
                style: textStyle(const Color(0xff333333), FontWeight.w400,
                    "NotoSansKR", 15.0),
              ),
            ],
          ),
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
    TextEditingController textEditingController = TextEditingController();
    List<String> requirements = [
      "없음",
      "부재시 문앞에 놔주세요",
      "경비실에 맡겨주세요",
      "도착시 전화주세요",
      "도착시 문자주세요",
      "문앞에 두고 노크해주세요",
      "도착전에 문자주세요",
      "직접 입력"
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "배송지",
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeShippingAddress(
                              shippingAddressBloc: shippingAddressBloc)));
                    },
                    child: SizedBox(
                      width: 40 * Scale.width,
                      child: Text(
                        "변경",
                        style: textStyle(const Color(0xff888888),
                            FontWeight.w400, 'NotoSansKR', 13.0),
                      ),
                    ),
                  )
                ],
              ),
              divider(1, 16, 16, const Color(0xffeeeeee)),
              userInfo(),
              SizedBox(height: 10 * Scale.height),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    isDismissible: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: shippingAddressBloc,
                      child: Stack(
                        children: [
                          BlocBuilder<ShippingAddressBloc,
                              ShippingAddressState>(
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
                          Positioned(
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
                                            child: Text("배송 요청 사항",
                                                style: textStyle(
                                                    const Color(0xff333333),
                                                    FontWeight.w700,
                                                    "NotoSansKR",
                                                    21.0)),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: ListView.separated(
                                                itemCount: requirements.length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Divider();
                                                },
                                                itemBuilder: ((context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              ShippingAddressBloc>()
                                                          .add(SetRequirementEvent(
                                                              requirement:
                                                                  requirements[
                                                                      index]));
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10 *
                                                                    Scale
                                                                        .height),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              requirements[
                                                                  index],
                                                              style: textStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .w300,
                                                                  "NotoSansKR",
                                                                  16.0),
                                                            ),
                                                            context
                                                                        .read<
                                                                            ShippingAddressBloc>()
                                                                        .state
                                                                        .requirement ==
                                                                    requirements[
                                                                        index]
                                                                ? SvgPicture.asset(
                                                                    "assets/images/svg/accept.svg")
                                                                : SizedBox()
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: const Color(0xffe2e2e2), width: 1),
                            color: const Color(0xffffffff)),
                        child: Padding(
                          padding: EdgeInsets.all(10.0 * Scale.width),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context
                                        .read<ShippingAddressBloc>()
                                        .state
                                        .requirement
                                        .isEmpty
                                    ? "배송시 요청사항을 선택하세요."
                                    : context
                                        .read<ShippingAddressBloc>()
                                        .state
                                        .requirement,
                                style: textStyle(Colors.grey[800]!,
                                    FontWeight.w400, 'NotoSansKR', 14.0),
                              ),
                              SvgPicture.asset("assets/images/svg/dropdown.svg",
                                  width: 12 * Scale.width),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5 * Scale.height),
              BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                builder: (context, state) {
                  if (state.requirement == '직접 입력') {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 200 * Scale.height,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffe2e2e2)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: requirementController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: 1,
                                style: textStyle(Colors.grey[800]!,
                                    FontWeight.w400, 'NotoSansKR', 14.0),
                                decoration: InputDecoration(
                                  hintText: "요청 사항을 작성해주세요",
                                  hintStyle: textStyle(Colors.grey[800]!,
                                      FontWeight.w400, 'NotoSansKR', 14.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget userInfo() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<ShippingAddressBloc>().state.recipient,
              style: textStyle(
                  const Color(0xff333333), FontWeight.w500, 'NotoSansKR', 16.0),
            ),
            SizedBox(height: 8 * Scale.height),
            Text(
              context.read<ShippingAddressBloc>().state.baseAddress +
                  context.read<ShippingAddressBloc>().state.detailAddress,
              style: textStyle(
                  const Color(0xff555555), FontWeight.w400, 'NotoSansKR', 16.0),
            ),
            SizedBox(height: 4 * Scale.height),
            Text(
              "${context.read<ShippingAddressBloc>().state.recipient} ${context.read<ShippingAddressBloc>().state.mobilePhoneNumber}",
              style: textStyle(
                  const Color(0xff999999), FontWeight.w400, 'NotoSansKR', 14.0),
            ),
          ],
        );
      },
    );
  }

  Widget pointArea() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        TextEditingController pointController = TextEditingController(
            text: context.read<OrderBloc>().state.usedPoint.toString());

        int orderEarn =
            (context.read<OrderBloc>().state.finalPaymentPrice * 0.01).toInt();
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 40 * Scale.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "포인트",
                style:
                    textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20),
              ),
              divider(1, 10, 10, const Color(0xffeeeeee)),
              Row(
                children: [
                  SizedBox(
                    width: 200 * Scale.width,
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return TextFormField(
                          onChanged: (text) {
                            context
                                .read<OrderBloc>()
                                .add(ChangeUsingPointEvent(point: text));
                          },
                          controller: pointController
                            ..selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: pointController.text.length)),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          maxLength: 30,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(
                              10 * Scale.width,
                              12 * Scale.height,
                              10 * Scale.width,
                              12 * Scale.height,
                            ),
                            counterText: "",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(
                              color: const Color(0xff666666),
                              height: 0.6,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansKR",
                              fontStyle: FontStyle.normal,
                              fontSize: 14 * Scale.height,
                            ),
                            hintStyle: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 16.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                          ),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 5 * Scale.width),
                  Container(
                    child: InkWell(
                      child: Center(
                        child: Text("전액사용",
                            style: textStyle(const Color(0xffec5363),
                                FontWeight.w400, "NotoSansKR", 15.0),
                            textAlign: TextAlign.center),
                      ),
                      onTap: () {
                        pointController.text = context
                            .read<OrderBloc>()
                            .state
                            .canUsePoint
                            .toString();
                        context.read<OrderBloc>().add(
                            ChangeUsingPointEvent(point: pointController.text));
                      },
                    ),
                    width: 90 * Scale.width,
                    height: 46 * Scale.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: const Color(0xfffff7f8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5 * Scale.height),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "사용 가능한 포인트 ",
                    style: textStyle(
                        Color(0xff555555), FontWeight.w400, "NotoSansKR", 14.0),
                  ),
                  Text(
                      "${setPriceFormat(context.read<OrderBloc>().state.canUsePoint)}원",
                      style: textStyle(const Color(0xffec5363), FontWeight.w500,
                          "NotoSansKR", 14.0))
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/images/svg/info.svg'),
                  Text(" 주문 금액 1,000원 이상이 될때까지 모두 사용 가능합니다.",
                      style: textStyle(const Color(0xff999999), FontWeight.w400,
                          "NotoSansKR", 13.0),
                      textAlign: TextAlign.left)
                ],
              ),
              SizedBox(height: 60 * Scale.height),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            style: textStyle(const Color(0xff333333),
                                FontWeight.w500, "NotoSansKR", 20.0),
                            text: "포인트 혜택 "),
                        TextSpan(
                            style: textStyle(const Color(0xffec5363),
                                FontWeight.w500, "NotoSansKR", 20.0),
                            text: "최대 ${setPriceFormat(orderEarn + 500)}원 "),
                        TextSpan(
                            style: textStyle(const Color(0xff333333),
                                FontWeight.w500, "NotoSansKR", 20.0),
                            text: "(구매확정 시)")
                      ],
                    ),
                  );
                },
              ),
              divider(1, 10, 10, const Color(0xffeeeeee)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("주문적립",
                      style: textStyle(const Color(0xff555555), FontWeight.w400,
                          "NotoSansKR", 14.0),
                      textAlign: TextAlign.left),
                  Text(setPriceFormat(orderEarn) + "원",
                      style: textStyle(const Color(0xff555555), FontWeight.w500,
                          "NotoSansKR", 14.0),
                      textAlign: TextAlign.right)
                ],
              ),
              SizedBox(height: 10 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("텍스트리뷰 적립",
                      style: textStyle(const Color(0xff555555), FontWeight.w400,
                          "NotoSansKR", 14.0),
                      textAlign: TextAlign.left),
                  Text("100 원",
                      style: textStyle(const Color(0xff555555), FontWeight.w500,
                          "NotoSansKR", 14.0),
                      textAlign: TextAlign.right)
                ],
              ),
              SizedBox(height: 10 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("포토리뷰 적립",
                      style: textStyle(const Color(0xff555555), FontWeight.w400,
                          "NotoSansKR", 14.0),
                      textAlign: TextAlign.left),
                  Text("500 원",
                      style: textStyle(const Color(0xff555555), FontWeight.w500,
                          "NotoSansKR", 14.0),
                      textAlign: TextAlign.right)
                ],
              ),
              divider(1, 10, 10, const Color(0xffeeeeee)),
              Text("- 주문적립 혜택은 최종결제금액에 따라 변경될 수 있습니다.",
                  style: textStyle(const Color(0xff999999), FontWeight.w400,
                      "NotoSansKR", 12.0),
                  textAlign: TextAlign.left),
              Text("- 리뷰 적립 혜택은 동일 상품의 텍스트리뷰와 포토리뷰 중 1회만 지급됩니다.",
                  style: textStyle(const Color(0xff999999), FontWeight.w400,
                      "NotoSansKR", 12.0),
                  textAlign: TextAlign.left)
            ],
          ),
        );
      },
    );
  }

  Widget paymentArea() {
    List<String> paymentString = ["카드", "무통장입금", "카카오페이", "토스", "네이버페이", "페이코"];
    List<Widget> paymentImg = [
      SvgPicture.asset('assets/images/svg/creditCard.svg'),
      SvgPicture.asset('assets/images/svg/bankTransfer.svg'),
      SvgPicture.asset('assets/images/svg/bankTransfer.svg'),
      SvgPicture.asset('assets/images/svg/bankTransfer.svg'),
      SvgPicture.asset('assets/images/svg/bankTransfer.svg'),
      SvgPicture.asset('assets/images/svg/bankTransfer.svg'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "결제 수단",
                style:
                    textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16 * Scale.height, horizontal: 20 * Scale.width),
          child: Divider(
              thickness: 1 * Scale.height, color: const Color(0xffeeeeee)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
          itemCount: paymentImg.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1.0),
          itemBuilder: (BuildContext context, int index) {
            return paymentContainer(paymentString[index], paymentImg[index]);
          },
        ),
      ],
    );
  }

  Widget paymentContainer(String payment, Widget image) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        context.read<OrderBloc>().add(CalculatePriceInfoEvent());
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 4.0 * Scale.width, vertical: 8 * Scale.height),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: const Color(0xfff2f2f2), width: 1),
              color: const Color(0xfffbfcfe),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  SizedBox(height: 15 * Scale.height),
                  Text(
                    payment,
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        'NotoSansKR', 13.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget amountOfPaymentArea() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "결제 금액",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
              ),
              SizedBox(height: 20 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "총 상품 금액",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                  Text(
                    setPriceFormat(
                            context.read<OrderBloc>().state.totalProductPrice) +
                        "원",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                ],
              ),
              divider(1, 10, 10, const Color(0xffeeeeee)),
              amountOfPaymentContents(
                  "상품할인",
                  setPriceFormat(
                          -context.read<OrderBloc>().state.baseDiscountPrice) +
                      "원"),
              amountOfPaymentContents("쿠폰할인", setPriceFormat(-1000) + "원"),
              amountOfPaymentContents(
                  "포인트",
                  setPriceFormat(-context.read<OrderBloc>().state.usedPoint) +
                      "원"),
              amountOfPaymentContents(
                  "멤버십 할인",
                  setPriceFormat(-context
                          .read<OrderBloc>()
                          .state
                          .membershipDiscountPrice) +
                      "원"),
              amountOfPaymentContents("배송비", "전 상품 무료 배송"),
              divider(1, 10, 10, const Color(0xffeeeeee)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "최종 결제 금액",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                  Text(
                    setPriceFormat(
                            context.read<OrderBloc>().state.finalPaymentPrice) +
                        "원",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget amountOfPaymentContents(String subject, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0 * Scale.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: textStyle(
                const Color(0xff555555), FontWeight.w400, 'NotoSansKR', 16.0),
          ),
          Text(
            value,
            style: textStyle(
                const Color(0xff555555), FontWeight.w400, 'NotoSansKR', 16.0),
          ),
        ],
      ),
    );
  }
}
