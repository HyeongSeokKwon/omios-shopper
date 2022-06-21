import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/page/cart/emptyCart.dart';
import 'package:cloth_collection/page/order/order.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';
import '../../bloc/cart_bloc/bloc/cart_state.dart';
import '../../util/util.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartBloc cartbloc;
  OrderBloc orderBloc = OrderBloc();
  @override
  Widget build(BuildContext context) {
    cartbloc = CartBloc(orderBloc: orderBloc);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => cartbloc),
        BlocProvider(create: (context) => orderBloc),
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
                "장바구니",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          bottom: PreferredSize(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<CartBloc>().add(
                                ClickSelectAllProductButtonEvent(
                                    isChecked:
                                        state.selectedProductsId.length ==
                                                state.getCartsData.length
                                            ? false
                                            : true));
                          },
                          child: Text(
                            "전체 선택",
                            style: textStyle(Colors.grey[700]!, FontWeight.w400,
                                'NotoSansKR', 14.0),
                          ),
                        ),
                        Text(
                          "상품 삭제",
                          style: textStyle(Colors.grey[700]!, FontWeight.w400,
                              'NotoSansKR', 14.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
              preferredSize: Size.fromHeight(10 * Scale.height)),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.getCartsState == ApiState.initial) {
              context.read<CartBloc>().add(GetCartsProductEvent());
              return progressBar();
            } else if (state.getCartsState == ApiState.success) {
              if (state.getCartsData.isEmpty) {
                return EmptyCart();
              }
              return scrollArea();
            } else if (state.getCartsState == ApiState.fail) {
              return ErrorCard();
            } else {
              return progressBar();
            }
          },
        ),
        bottomSheet: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.getCartsState == ApiState.initial) {
              context.read<CartBloc>().add(GetCartsProductEvent());
              return progressBar();
            } else if (state.getCartsState == ApiState.success) {
              if (state.getCartsData.isEmpty) {
                return SizedBox();
              }
              return Container(
                height: 80,
                color: Colors.white.withOpacity(0.5),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
                  child: Row(children: [
                    Expanded(
                      child: BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              if (context
                                  .read<CartBloc>()
                                  .state
                                  .selectedProductsId
                                  .isNotEmpty) {
                                context
                                    .read<CartBloc>()
                                    .add(ClickBuyButtonEvent());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Order(orderBloc: orderBloc),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 50 * Scale.height,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                                color: Colors.red[400],
                              ),
                              child: Center(
                                child: Text(
                                  "바로구매",
                                  style: textStyle(Colors.white,
                                      FontWeight.w400, 'NotoSansKR', 17.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                ),
              );
            } else if (state.getCartsState == ApiState.fail) {
              return ErrorCard();
            } else {
              return progressBar();
            }
          },
        ),
      ),
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            thickness: 10 * Scale.height,
            color: Colors.grey[50],
          ),
          productInfoArea(),
          Divider(
            thickness: 15 * Scale.height,
            color: Colors.grey[50],
          ),
          paymentArea()
        ],
      ),
    );
  }

  Widget productInfoArea() {
    int totalPrice;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.getCartsData.length,
          itemBuilder: (context, cartIndex) {
            totalPrice = 0;

            for (var value in state.getCartsData[cartIndex]['carts']) {
              totalPrice += (value['base_discounted_price'].toInt()) as int;
            }

            return cartInfoArea(cartIndex, totalPrice);
          },
        );
      },
    );
  }

  Widget cartInfoArea(int cartIndex, int totalPrice) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          activeColor: Colors.grey[500],
                          side: BorderSide(
                              color: Colors.grey[500]!, width: 1 * Scale.width),
                          value: state.selectedProductsId.contains(cartIndex),
                          onChanged: (value) {
                            context.read<CartBloc>().add(SelectProductEvent(
                                index: cartIndex, isChecked: value!));
                          },
                        )),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 20 * Scale.width),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  productPicture(
                                      state.getCartsData[cartIndex]['image']),
                                  SizedBox(width: 10 * Scale.width),
                                  Expanded(
                                    child: Text(
                                      state.getCartsData[cartIndex]
                                          ['product_name'],
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, 'NotoSansKR', 17.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15 * Scale.height),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.getCartsData[cartIndex]['carts'].length,
                    itemBuilder: (context, optionIndex) {
                      return Column(
                        children: [
                          optionArea(cartIndex, optionIndex),
                        ],
                      );
                    },
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            setPriceFormat(state.getCartsData[cartIndex]
                                        .containsKey('cart_price')
                                    ? state.getCartsData[cartIndex]
                                        ['cart_price']
                                    : totalPrice) +
                                '원',
                            style: textStyle(Colors.black, FontWeight.w500,
                                'NotoSansKR', 18)),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget productPicture(String imageUrl) {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            width: 75 * Scale.width,
            height: 75 * (4 / 3) * Scale.width,
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            fadeInDuration: Duration(milliseconds: 0),
            placeholder: (context, url) {
              return Container(
                  color: Colors.grey[200], width: 30, height: 30 * (4 / 3));
            },
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
    );
  }

  Widget optionArea(int cartIndex, int optionIndex) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        Map optionData = state.getCartsData[cartIndex]['carts'][optionIndex];
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20 * Scale.width, vertical: 4 * Scale.height),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(9),
                    ),
                    color: Colors.grey[100]),
                child: Padding(
                  padding: EdgeInsets.all(10.0 * Scale.height),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${optionData['display_color_name']} / ${optionData['size']}",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w400, "NotoSansKR", 14.0),
                      ),
                      SizedBox(
                        height: 10 * Scale.height,
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: SvgPicture.asset(
                                          "assets/images/svg/minus.svg",
                                          width: 18 * Scale.width,
                                          height: 18,
                                          fit: BoxFit.scaleDown),
                                      onTap: () {
                                        if (optionData['count'] != 1) {
                                          context.read<CartBloc>().add(
                                              ChangeProductsCountEvent(
                                                  id: optionData['id'],
                                                  count:
                                                      optionData['count'] - 1));
                                          context
                                              .read<CartBloc>()
                                              .add(GetCartsProductEvent());
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8 * Scale.width),
                                      child: Text(
                                        optionData['count'].toString(),
                                        style: textStyle(
                                            const Color(0xff444444),
                                            FontWeight.w400,
                                            "NotoSansKR",
                                            14.0),
                                      ),
                                    ),
                                    InkWell(
                                        child: SvgPicture.asset(
                                            "assets/images/svg/plus.svg",
                                            width: 18 * Scale.width,
                                            height: 18,
                                            fit: BoxFit.scaleDown),
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                                ChangeProductsCountEvent(
                                                    id: optionData['id'],
                                                    count: optionData['count'] +
                                                        1),
                                              );
                                          context
                                              .read<CartBloc>()
                                              .add(GetCartsProductEvent());
                                        }),
                                  ],
                                ),
                                Text(
                                  setPriceFormat(
                                          optionData['base_discounted_price']) +
                                      "원",
                                  style: textStyle(Color(0xff333333),
                                      FontWeight.w500, "NotoSansKR", 16.0),
                                ),
                              ],
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Positioned(
                    top: 12 * Scale.width,
                    right: 12 * Scale.width,
                    child: GestureDetector(
                        child: SvgPicture.asset(
                            "assets/images/svg/productCancel.svg"),
                        onTap: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveCartProductsEvent([optionData['id']]));
                        }),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget paymentArea() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              left: 20.0 * Scale.width,
              right: 20.0 * Scale.width,
              bottom: 110 * Scale.height),
          child: Column(
            children: [
              SizedBox(height: 30 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "총 상품 금액",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                  Text(
                    setPriceFormat(context
                            .read<CartBloc>()
                            .state
                            .getCartsResponse['total_sale_price']) +
                        "원",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                ],
              ),
              SizedBox(height: 15 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "총 할인 금액",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                  Text(
                    setPriceFormat(-(context
                                .read<CartBloc>()
                                .state
                                .getCartsResponse['total_sale_price'] -
                            context.read<CartBloc>().state.getCartsResponse[
                                'total_base_discounted_price'])) +
                        "원",
                    style: textStyle(
                        Colors.black, FontWeight.w400, 'NotoSansKR', 16.0),
                  ),
                ],
              ),
              SizedBox(height: 15 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "결제금액",
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 18.0),
                  ),
                  Text(
                    setPriceFormat(context
                            .read<CartBloc>()
                            .state
                            .getCartsResponse['total_base_discounted_price']) +
                        "원",
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 18.0),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
