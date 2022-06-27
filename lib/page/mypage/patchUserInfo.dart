import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';

class PatchUserInfo extends StatefulWidget {
  ShopperInfoBloc shopperInfoBloc;
  PatchUserInfo({Key? key, required this.shopperInfoBloc}) : super(key: key);

  @override
  State<PatchUserInfo> createState() => _PatchUserInfoState();
}

class _PatchUserInfoState extends State<PatchUserInfo> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nickNameController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.shopperInfoBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      "assets/images/svg/moveToBack.svg",
                      width: 10 * Scale.width,
                      height: 20 * Scale.height,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(width: 14 * Scale.width),
                  Text("회원정보 수정",
                      style: textStyle(const Color(0xff333333), FontWeight.w700,
                          "NotoSansKR", 22.0)),
                ],
              ),
              BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      context.read<ShopperInfoBloc>().add(PatchShopperInfoEvent(
                          email: emailController.text,
                          nickname: nickNameController.text,
                          height: heightController.text,
                          weight: weightController.text));
                    },
                    child: Text(
                      '완료',
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        idArea(),
        emailArea(),
        nicknameArea(),
        bodySizeArea(),
      ],
    );
  }

  Widget idArea() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '아이디',
                    style: textStyle(
                      Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                  ),
                  SizedBox(
                    width: 10 * Scale.width,
                  ),
                  Text(state.shopperInfo['username']),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget emailArea() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        emailController.text = state.shopperInfo['email'];
        return Padding(
          padding: EdgeInsets.only(
              top: 18 * Scale.width,
              left: 22 * Scale.width,
              right: 22 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이메일',
                style: textStyle(
                  Color(0xff555555),
                  FontWeight.w400,
                  "NotoSansKR",
                  13.0,
                ),
              ),
              SizedBox(
                height: 4 * Scale.height,
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 60 * Scale.height,
                        width: 370 * Scale.width,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z0-9!-~]')),
                          ],
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          controller: emailController,
                          decoration: InputDecoration(
                            counterText: "",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            contentPadding:
                                EdgeInsets.only(left: 12 * Scale.width),
                            labelStyle: TextStyle(
                              color: const Color(0xff666666),
                              height: 0.6,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansKR",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0,
                            ),
                            hintText: ("입력하세요"),
                            hintStyle: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 16.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget nicknameArea() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        nickNameController.text = state.shopperInfo['nickname'];
        return Padding(
          padding:
              EdgeInsets.only(left: 22 * Scale.width, right: 22 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '닉네임',
                style: textStyle(
                  Color(0xff555555),
                  FontWeight.w400,
                  "NotoSansKR",
                  13.0,
                ),
              ),
              SizedBox(
                height: 4 * Scale.height,
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 60 * Scale.height,
                        width: 370 * Scale.width,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z0-9!-~]')),
                          ],
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          controller: nickNameController,
                          decoration: InputDecoration(
                            counterText: "",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            contentPadding:
                                EdgeInsets.only(left: 12 * Scale.width),
                            labelStyle: TextStyle(
                              color: const Color(0xff666666),
                              height: 0.6,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansKR",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0,
                            ),
                            hintText: ("입력하세요"),
                            hintStyle: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 16.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bodySizeArea() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        heightController.text = state.shopperInfo['height'].toString();
        weightController.text = state.shopperInfo['weight'].toString();
        return Padding(
          padding:
              EdgeInsets.only(left: 22 * Scale.width, right: 22 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '신체사이즈',
                style: textStyle(
                  Color(0xff555555),
                  FontWeight.w400,
                  "NotoSansKR",
                  13.0,
                ),
              ),
              SizedBox(
                height: 4 * Scale.height,
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 60 * Scale.height,
                        width: 100 * Scale.width,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          controller: heightController,
                          decoration: InputDecoration(
                            counterText: "",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            contentPadding:
                                EdgeInsets.only(left: 12 * Scale.width),
                            labelStyle: TextStyle(
                              color: const Color(0xff666666),
                              height: 0.6,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansKR",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0,
                            ),
                            hintText: ("키"),
                            hintStyle: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 16.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
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
                  Text(' cm'),
                  SizedBox(width: 10 * Scale.width),
                  Stack(
                    children: [
                      Container(
                        height: 60 * Scale.height,
                        width: 100 * Scale.width,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          controller: weightController,
                          decoration: InputDecoration(
                            counterText: "",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            contentPadding:
                                EdgeInsets.only(left: 12 * Scale.width),
                            labelStyle: TextStyle(
                              color: const Color(0xff666666),
                              height: 0.6,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansKR",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0,
                            ),
                            hintText: ("몸무게"),
                            hintStyle: textStyle(const Color(0xffcccccc),
                                FontWeight.w400, "NotoSansKR", 16.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                              borderSide: BorderSide(
                                  color: const Color(0xffcccccc),
                                  width: 1 * Scale.width),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
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
                  Text(' kg')
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
