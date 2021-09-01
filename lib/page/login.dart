import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 지금 당신의 쇼핑몰을  책임지는 시간 Deepy
            Padding(
              padding: EdgeInsets.only(top: 110.h, left: 22.w),
              child: Container(
                child: Text(
                  "지금 당신의 쇼핑몰을\n책임지는 시간\nDeepy",
                  style: TextStyle(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w700,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 28.w),
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: _buildTextfield("아이디"),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: _buildTextfield("비밀번호"),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: Row(
                children: [
                  // 자동로그인
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
            SizedBox(height: 26.h),
            // 사각형 3740
            Center(
              child: TextButton(
                child: Text("로그인", style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(Size(370.w, 60.h)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffec5363)),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 20.h),
            // 아이디 찾기       |       비밀번호 찾기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Text(
                    "아이디 찾기",
                    style: const TextStyle(
                      color: const Color(0xff999999),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
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
                    style: const TextStyle(
                      color: const Color(0xff999999),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextfield(String type) {
    return Container(
      alignment: Alignment.center,
      width: 370.w,
      height: 75.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
        border: Border.all(color: const Color(0xffcccccc), width: 1.w),
        color: const Color(0xffffffff),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "$type",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.sp,
                  ),
                  hintText: ("$type를 입력하세요"),
                  hintStyle: TextStyle(
                      color: const Color(0xffcccccc),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp),
                ),
                textAlign: TextAlign.left),
          ],
        ),
      ),
    );
  }
}
