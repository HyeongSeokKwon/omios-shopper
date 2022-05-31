import 'dart:io';

import 'package:cloth_collection/page/shippingAddress/searchAddressWebview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';
import '../../util/util.dart';

class RegistShippingAddress extends StatefulWidget {
  final ShippingAddressBloc shippingAddressBloc;
  final String mode;
  final int? index;
  RegistShippingAddress(
      {Key? key,
      required this.shippingAddressBloc,
      required this.mode,
      this.index})
      : super(key: key);

  @override
  State<RegistShippingAddress> createState() => _RegistShippingAddressState();
}

class _RegistShippingAddressState extends State<RegistShippingAddress> {
  TextEditingController addressKindsController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController mobilePhoneNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.shippingAddressBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<ShippingAddressBloc>().add(InitDataEvent());
                    },
                    icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
                  );
                },
              ),
              Text(
                "배송지 추가",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: bodyArea(),
        bottomSheet: completeButton(),
      ),
    );
  }

  Widget bodyArea() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        if (widget.mode == 'update') {
          addressKindsController.text =
              BlocProvider.of<ShippingAddressBloc>(context).state.addressKinds;
          recipientController.text =
              BlocProvider.of<ShippingAddressBloc>(context).state.recipient;
          mobilePhoneNumberController.text =
              BlocProvider.of<ShippingAddressBloc>(context)
                  .state
                  .mobilePhoneNumber;
          phoneNumberController.text =
              BlocProvider.of<ShippingAddressBloc>(context).state.phoneNumber;
          detailAddressController.text =
              BlocProvider.of<ShippingAddressBloc>(context).state.detailAddress;
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            children: [
              addressKinds(),
              SizedBox(height: 15 * Scale.height),
              recipient(),
              SizedBox(height: 15 * Scale.height),
              mobilePhoneNumber(),
              SizedBox(height: 15 * Scale.height),
              phoneNumber(),
              SizedBox(height: 15 * Scale.height),
              addressInfo(),
              SizedBox(height: 10 * Scale.height),
              defaultShippingAddressCheckBox(),
            ],
          ),
        );
      },
    );
  }

  Widget addressKinds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5 * Scale.height),
          child: Text("배송지 이름",
              style:
                  textStyle(Colors.black, FontWeight.w400, "NotoSansKR", 14.0)),
        ),
        SizedBox(
          width: 15 * Scale.width,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[\w\s!-~ㄱ-ㅎ가-힣]*$')),
                ],
                controller: addressKindsController,
                maxLength: 20,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
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
                  hintText: ("ex) 집, 회사"),
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "NotoSansKR", 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: Colors.grey[700]!, width: 1 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget recipient() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5 * Scale.height),
          child: Text("수령인",
              style:
                  textStyle(Colors.black, FontWeight.w400, "NotoSansKR", 14.0)),
        ),
        SizedBox(
          width: 15 * Scale.width,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[\w\s!-~ㄱ-ㅎ가-힣]*$')),
                ],
                controller: recipientController,
                textInputAction: TextInputAction.next,
                maxLength: 30,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
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
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "NotoSansKR", 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: Colors.grey[700]!, width: 1 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobilePhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5 * Scale.height),
          child: Text("휴대폰",
              style:
                  textStyle(Colors.black, FontWeight.w400, "NotoSansKR", 14.0)),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                controller: mobilePhoneNumberController,
                textInputAction: TextInputAction.next,
                maxLength: 30,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
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
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "NotoSansKR", 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: Colors.grey[700]!, width: 1 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget phoneNumber() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5 * Scale.height),
              child: Text("전화번호",
                  style: textStyle(
                      Colors.black, FontWeight.w400, "NotoSansKR", 14.0)),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    enabled: !context
                        .read<ShippingAddressBloc>()
                        .state
                        .noPhoneNumber,
                    controller: phoneNumberController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(
                        10 * Scale.width,
                        10 * Scale.height,
                        10 * Scale.width,
                        10 * Scale.height,
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
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(
                            color: Colors.grey[700]!, width: 1 * Scale.width),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5 * Scale.height),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "없음",
                  style: textStyle(
                      Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
                ),
                SizedBox(width: 5 * Scale.width),
                BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                  builder: (context, state) {
                    return Transform.scale(
                      scale: 0.8,
                      child: SizedBox(
                        width: 20 * Scale.width,
                        height: 20 * Scale.width,
                        child: Checkbox(
                          activeColor: Colors.grey[500],
                          side: BorderSide(
                              color: Colors.grey[500]!, width: 1 * Scale.width),
                          value: context
                              .read<ShippingAddressBloc>()
                              .state
                              .noPhoneNumber,
                          onChanged: (value) {
                            print(value);
                            if (value == true) {
                              phoneNumberController.text = '';
                            }
                            context
                                .read<ShippingAddressBloc>()
                                .add(ClickNoPhoneNumberEvent(value: value!));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget addressInfo() {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchAddressWebView(
                      shippingAddressBloc: widget.shippingAddressBloc,
                    )));
          },
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchAddressWebView(
                        shippingAddressBloc: widget.shippingAddressBloc,
                      )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5 * Scale.height),
                  child: Text("배송지",
                      style: textStyle(
                          Colors.black, FontWeight.w400, "NotoSansKR", 14.0)),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: BlocBuilder<ShippingAddressBloc,
                          ShippingAddressState>(
                        builder: (context, state) {
                          return TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[\w\s!-~ㄱ-ㅎ가-힣]*$')),
                            ],
                            enabled: false,
                            controller: TextEditingController(
                                text: context
                                        .read<ShippingAddressBloc>()
                                        .state
                                        .selectedAddressInKakao
                                        .isNotEmpty
                                    ? context
                                        .read<ShippingAddressBloc>()
                                        .state
                                        .selectedAddressInKakao['zonecode']
                                    : ''),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "우편번호",
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                10 * Scale.width,
                                10 * Scale.height,
                                10 * Scale.width,
                                10 * Scale.height,
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
                              enabledBorder: OutlineInputBorder(
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
                                    color: Colors.grey[700]!,
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
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffcccccc)),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Center(child: Text("우편번호 찾기")),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15 * Scale.height,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<ShippingAddressBloc,
                          ShippingAddressState>(
                        builder: (context, state) {
                          return TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            enabled: false,
                            controller: TextEditingController(
                                text: context
                                        .read<ShippingAddressBloc>()
                                        .state
                                        .selectedAddressInKakao
                                        .isNotEmpty
                                    ? context
                                        .read<ShippingAddressBloc>()
                                        .state
                                        .selectedAddressInKakao['address']
                                    : ''),
                            textInputAction: TextInputAction.next,
                            maxLength: 30,
                            decoration: InputDecoration(
                              hintText: "주소",
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                10 * Scale.width,
                                10 * Scale.height,
                                10 * Scale.width,
                                10 * Scale.height,
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
                                    color: Colors.grey[700]!,
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
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10 * Scale.height),
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\w\s!-~ㄱ-ㅎ가-힣]*$')),
          ],
          controller: detailAddressController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "상세주소",
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(
              10 * Scale.width,
              10 * Scale.height,
              10 * Scale.width,
              10 * Scale.height,
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
            hintStyle: textStyle(
                const Color(0xffcccccc), FontWeight.w400, "NotoSansKR", 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: const Color(0xffcccccc), width: 1 * Scale.width),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: const Color(0xffcccccc), width: 1 * Scale.width),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: const Color(0xffcccccc), width: 1 * Scale.width),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide:
                  BorderSide(color: Colors.grey[700]!, width: 1 * Scale.width),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                  color: const Color(0xffcccccc), width: 1 * Scale.width),
            ),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget completeButton() {
    return BlocConsumer<ShippingAddressBloc, ShippingAddressState>(
      listener: (context, state) {
        if (state.shippingAddressValidateState == ValidateState.fail) {
          showDialog(
              context: context,
              builder: (context) {
                if (Platform.isIOS) {
                  return CupertinoAlertDialog(
                    content: Text(state.validateErrMsg),
                    actions: <Widget>[
                      CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text("확인"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  );
                } else {
                  return AlertDialog(
                    content: Text(
                      state.validateErrMsg,
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          "확인",
                          style: textStyle(Colors.black, FontWeight.w500,
                              'NotoSansKR', 15.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
              });
        }
        if (state.postShippingAddressState == ApiState.success) {
          context.read<ShippingAddressBloc>().add(InitDataEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * Scale.width, vertical: 30 * Scale.height),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50 * Scale.height,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "완료",
                        style: textStyle(
                            Colors.white, FontWeight.w500, "NotoSansKR", 17.0),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (widget.mode == 'regist') {
                context.read<ShippingAddressBloc>().add(
                    RegistShippingAddressEvent(
                        addressKinds: addressKindsController.text,
                        recipient: recipientController.text,
                        mobilePhoneNumber: mobilePhoneNumberController.text,
                        phoneNumber: phoneNumberController.text,
                        detailAddress: detailAddressController.text));
              } else {
                context.read<ShippingAddressBloc>().add(
                    PatchShippingAddressEvent(
                        index: widget.index!,
                        addressKinds: addressKindsController.text,
                        recipient: recipientController.text,
                        mobilePhoneNumber: mobilePhoneNumberController.text,
                        phoneNumber: phoneNumberController.text,
                        detailAddress: detailAddressController.text));
              }
            });
      },
    );
  }

  Widget defaultShippingAddressCheckBox() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "기본 배송지로 설정",
              style:
                  textStyle(Colors.black, FontWeight.w400, 'NotoSansKR', 14.0),
            ),
            SizedBox(width: 5 * Scale.width),
            Transform.scale(
              scale: 0.8,
              child: SizedBox(
                width: 20 * Scale.width,
                height: 20 * Scale.width,
                child: Checkbox(
                  activeColor: Colors.grey[500],
                  side: BorderSide(
                      color: Colors.grey[500]!, width: 1 * Scale.width),
                  value: context.read<ShippingAddressBloc>().state.isDefault,
                  onChanged: (value) {
                    context
                        .read<ShippingAddressBloc>()
                        .add(ClickIsDefaultEvent(isDefault: value!));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
