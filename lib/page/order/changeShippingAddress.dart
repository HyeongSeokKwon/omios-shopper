import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/page/order/registShippingAddress.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class ChangeShippingAddress extends StatelessWidget {
  final ShippingAddressBloc shippingAddressBloc = ShippingAddressBloc();
  static const REGIST = "regist";
  static const UPDATE = "update";
  ChangeShippingAddress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => shippingAddressBloc,
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
                "배송지 변경",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20 * Scale.width),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => RegistShippingAddress(
                              shippingAddressBloc: shippingAddressBloc,
                              mode: REGIST))));
                    },
                    child: Text("배송지 추가",
                        style: textStyle(const Color(0xff333333),
                            FontWeight.w400, "NotoSansKR", 14.0)),
                  ),
                ],
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: scrollArea(),
      ),
    );
  }

  Widget scrollArea() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        print(state.getShippingAddressesState);
        if (state.getShippingAddressesState == ApiState.success) {
          return SingleChildScrollView(child: shippingAddressList());
        } else if (state.getShippingAddressesState == ApiState.initial) {
          context.read<ShippingAddressBloc>().add(ShowShippingAddressesEvent());
          return progressBar();
        } else if (state.getShippingAddressesState == ApiState.fail) {
          return ErrorCard();
        } else {
          return progressBar();
        }
      },
    );
  }

  Widget shippingAddressList() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        if (context
            .read<ShippingAddressBloc>()
            .state
            .shippingAddresses
            .isEmpty) {
          return Container(
            width: 414 * Scale.width,
            height: 600 * Scale.height,
            child: Center(
              child: Text(
                "등록된 배송지가 없습니다.",
                style: textStyle(
                    Colors.grey[700]!, FontWeight.w500, 'NotoSansKR', 19),
              ),
            ),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: context
                  .read<ShippingAddressBloc>()
                  .state
                  .shippingAddresses
                  .length,
              itemBuilder: ((context, index) {
                return shippingAddressInfoForm(
                    context
                        .read<ShippingAddressBloc>()
                        .state
                        .shippingAddresses[index],
                    index);
              }));
        }
      },
    );
  }

  Widget shippingAddressInfoForm(Map<String, dynamic> addressData, int index) {
    return Padding(
      padding: EdgeInsets.all(20.0 * Scale.width),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressData['receiver_name'],
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
              ),
              SizedBox(height: 10 * Scale.height),
              Text(
                "${addressData['base_address']}, ${addressData['detail_address']}",
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 5 * Scale.height),
              Text(
                addressData['receiver_mobile_number'].substring(0, 3) +
                    "-" +
                    addressData['receiver_mobile_number'].substring(3, 7) +
                    "-" +
                    addressData['receiver_mobile_number'].substring(7),
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 5 * Scale.height),
              Text(
                "문 앞",
                style: textStyle(
                    Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 20 * Scale.height),
              BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<ShippingAddressBloc>().add(
                                  DeleteShippingAddressEvent(index: index));
                            },
                            child: Container(
                              width: 70 * Scale.width,
                              height: 40 * Scale.height,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Center(
                                child: Text(
                                  "삭제",
                                  style: textStyle(Colors.grey[600]!,
                                      FontWeight.w400, 'NotoSansKR', 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10 * Scale.width),
                          InkWell(
                            onTap: () {
                              context
                                  .read<ShippingAddressBloc>()
                                  .add(InitPatchDataEvent(index: index));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => RegistShippingAddress(
                                        shippingAddressBloc:
                                            shippingAddressBloc,
                                        mode: UPDATE,
                                        index: index,
                                      ))));
                            },
                            child: Container(
                              width: 70 * Scale.width,
                              height: 40 * Scale.height,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Center(
                                child: Text(
                                  "수정",
                                  style: textStyle(Colors.grey[600]!,
                                      FontWeight.w400, 'NotoSansKR', 14.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 70 * Scale.width,
                        height: 40 * Scale.height,
                        decoration: BoxDecoration(
                          color: MAINCOLOR,
                        ),
                        child: Center(
                          child: Text(
                            "선택",
                            style: textStyle(Colors.white, FontWeight.w400,
                                'NotoSansKR', 14.0),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
