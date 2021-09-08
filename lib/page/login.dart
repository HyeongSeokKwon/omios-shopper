import 'package:cloth_collection/controller/loginController.dart';
import 'package:cloth_collection/page/home.dart';
import 'package:cloth_collection/widget/frequently_used_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String autoLoginIcon = "assets/images/login_check/Login.png";
  String autoUnLoginIcon = "assets/images/login_check/unLogin.png";
  LoginController controller = LoginController();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xffffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 지금 당신의 쇼핑몰을  책임지는 시간 Deepy
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.123, left: width * 0.053),
              child: Container(
                child: Text(
                  "지금 당신의 쇼핑몰을\n책임지는 시간\nDeepy",
                  style: TextStyle(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w700,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 28.0.sp),
                ),
              ),
            ),

            Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.056),
                  _buildTextfield("아이디", width, height),
                  SizedBox(height: height * 0.018),
                  _buildTextfield("비밀번호", width, height),
                  Container(
                    height: height * 0.069,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.03),
                      child: Row(
                        children: [
                          // 자동로그인
                          Container(
                            width: width * 0.1,
                            child: GetBuilder<LoginController>(
                              init: controller,
                              builder: (_) => FutureBuilder(
                                future: SharedPreferences.getInstance(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      return IconButton(
                                        onPressed: () {
                                          controller.checkedAutoLogin();
                                        },
                                        icon: Container(
                                          width: width * 0.043,
                                          height: width * 0.043,
                                          child: Image.asset(
                                            controller.isChecked
                                                ? autoLoginIcon
                                                : autoUnLoginIcon,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    } else
                                      return progressBar();
                                  } else
                                    return progressBar();
                                },
                              ),
                            ),
                          ),
                          Text("자동로그인",
                              style: TextStyle(
                                  color: const Color(0xff666666),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansKR",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.w),
                              textAlign: TextAlign.left)
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: Text("로그인", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(width * 0.894, height * 0.067)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffec5363)),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: height * 0.022),
                  // 아이디 찾기       |       비밀번호 찾기
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          "아이디 찾기",
                          style: TextStyle(
                            color: const Color(0xff999999),
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSansKR",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                        onTap: () {},
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          height: 15.h,
                          child: VerticalDivider(
                            color: const Color(0xff999999),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "비밀번호 찾기",
                          style: TextStyle(
                            color: const Color(0xff999999),
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSansKR",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.212),
                  Center(
                    child: TextButton(
                      child: Text(
                        "지금 회원가입하기!",
                        style: TextStyle(
                            color: const Color(0xff666666),
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSansKR",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            side: BorderSide(color: const Color(0xffe2e2e2)),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(width * 0.894, height * 0.063),
                        ),
                      ),
                      onPressed: () {
                        Get.to(HomePage());
                      },
                    ),
                  ),
                  // InkWell(
                  //   child: Text("건너뛰기"),
                  //   onTap: () {
                  //     Get.off(() => HomePage());
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextfield(String type, width, height) {
    return Container(
      alignment: Alignment.center,
      width: width * 0.894,
      height: height * 0.079,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
        border: Border.all(color: const Color(0xffcccccc), width: 1.w),
        color: const Color(0xffffffff),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.038),
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
          ],
          textInputAction: TextInputAction.next,
          maxLength: 30,
          obscureText: type == "아이디" ? false : true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: "$type",
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: const Color(0xff666666),
              height: 0.6,
              fontWeight: FontWeight.w400,
              fontFamily: "NotoSansKR",
              fontStyle: FontStyle.normal,
              fontSize: 14.sp,
            ),
            hintText: ("$type를 입력하세요"),
            hintStyle: TextStyle(
                color: const Color(0xffcccccc),
                fontWeight: FontWeight.w400,
                fontFamily: "NotoSansKR",
                fontStyle: FontStyle.normal,
                fontSize: 16.sp),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
