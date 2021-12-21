import 'package:cloth_collection/controller/signUpController.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:menu_button/menu_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController idTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();
  TextEditingController pwdCheckTextController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  SignUpController signUpController = SignUpController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subjectArea(),
              idArea(),
              passwordArea(),
              passwordCheckArea(),
              emailArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget subjectArea() {
    return Padding(
      padding: EdgeInsets.only(top: 60 * Scale.height),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/svg/moveToBack.svg"),
          SizedBox(width: 14 * Scale.width),
          Center(
            child: Text("회원가입",
                style: textStyle(
                    Color(0xff333333), FontWeight.w700, "NotoSansKR", 20.0)),
          ),
        ],
      ),
    );
  }

  Widget idArea() {
    final TextEditingController textController = idTextController;
    return Padding(
      padding: EdgeInsets.only(top: 30 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(
                      Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "아이디 "),
                TextSpan(
                    style: textStyle(
                      Color(0xfff84457),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          Stack(
            children: [
              Container(
                height: 60 * Scale.height,
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus && idTextController.text.length != 0) {
                      signUpController.validateId(idTextController.text);
                    }
                    if (hasFocus) {
                      signUpController.resetIsDuplicationCheck();
                    }
                  },
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                    ],
                    validator: (text) {
                      if (text!.trim().isNotEmpty && text.trim().length < 4) {
                        return "아이디는 4글자 이상 입력해주세요";
                      } else
                        return null;
                    },
                    onChanged: (text) {},
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
                    controller: textController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12 * Scale.width),
                      counterText: "",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(
                        color: const Color(0xff666666),
                        height: 0.6,
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansKR",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.sp,
                      ),
                      suffixIcon: GetBuilder<SignUpController>(
                          init: signUpController,
                          builder: (controller) {
                            if (controller.isDuplicationCheck == "accept") {
                              print("accept");
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                    "assets/images/svg/accept.svg"),
                                onPressed: () {},
                              );
                            } else if (controller.isDuplicationCheck ==
                                "deny") {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                    "assets/images/svg/deny.svg"),
                                onPressed: () {},
                              );
                            } else {
                              return IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.ac_unit,
                                  size: 0,
                                ),
                              );
                            }
                          }),
                      hintText: ("아이디를 입력하세요"),
                      hintStyle: textStyle(const Color(0xffcccccc),
                          FontWeight.w400, "NotoSansKR", 16.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc), width: 1.w),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc), width: 1.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc), width: 1.w),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc), width: 1.w),
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget passwordArea() {
    final TextEditingController textController = pwdTextController;
    return Padding(
      padding: EdgeInsets.only(top: 18 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(
                      Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "비밀번호 "),
                TextSpan(
                    style: textStyle(
                      Color(0xfff84457),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          Stack(
            children: [
              Container(
                height: 60 * Scale.height,
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!-~]')),
                  ],
                  onChanged: (text) {
                    signUpController.validatePassword(
                        text, pwdCheckTextController.text);
                  },
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: textController,
                  obscureText: true,
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 12 * Scale.width),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                      color: const Color(0xff666666),
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.sp,
                    ),
                    suffixIcon: GetBuilder<SignUpController>(
                        init: signUpController,
                        builder: (controller) {
                          if (controller.isPwdValidate == "accept") {
                            print("accept");
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/accept.svg"),
                              onPressed: () {},
                            );
                          } else if (controller.isPwdValidate == "deny") {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/deny.svg"),
                              onPressed: () {},
                            );
                          } else {
                            return IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.ac_unit,
                                size: 0,
                              ),
                            );
                          }
                        }),
                    hintText: ("비밀번호를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget passwordCheckArea() {
    final TextEditingController textController = pwdCheckTextController;
    return Padding(
      padding: EdgeInsets.only(top: 18 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(
                      Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "비밀번호 확인 "),
                TextSpan(
                    style: textStyle(
                      Color(0xfff84457),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          Stack(
            children: [
              Container(
                height: 60 * Scale.height,
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!-~]')),
                  ],
                  onChanged: (text) {
                    signUpController.validateDuplicationCheck(
                        pwdTextController.text, pwdCheckTextController.text);
                    print(text);
                    print(pwdTextController.text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty && text.trim().length < 4) {
                      return "비밀번호는 10글자 이상 입력해주세요";
                    } else
                      return null;
                  },
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  obscureText: true,
                  controller: textController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12 * Scale.width),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                      color: const Color(0xff666666),
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.sp,
                    ),
                    suffixIcon: GetBuilder<SignUpController>(
                        init: signUpController,
                        builder: (controller) {
                          if (controller.isPwdSame == "accept") {
                            print("accept");
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/accept.svg"),
                              onPressed: () {},
                            );
                          } else if (controller.isPwdSame == "deny") {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/deny.svg"),
                              onPressed: () {},
                            );
                          } else {
                            return IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.ac_unit,
                                size: 0,
                              ),
                            );
                          }
                        }),
                    hintText: ("비밀번호를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc), width: 1.w),
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget emailArea() {
    final TextEditingController textController = emailController;
    String selectedKey = "선택하기";
    List<String> keys = <String>[
      'naver.com',
      'gmail.com',
      'daum.net',
      'naver.com',
      'gmail.com',
      'daum.net',
      'naver.com',
      'gmail.com',
      'daum.net',
      'naver.com',
      'gmail.com',
      'daum.net',
      'naver.com',
      'gmail.com',
      'daum.net',
    ];
    final Widget normalChildButton = Container(
      height: 60 * Scale.height,
      width: 165 * Scale.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Color(0xffcccccc), width: 1.w),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(selectedKey,
                    style: textStyle(Color(0xffcccccc), FontWeight.w400,
                        "NotoSansKR", 16.sp),
                    overflow: TextOverflow.ellipsis)),
            SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                  child: SvgPicture.asset("assets/images/svg/dropdown.svg")),
            ),
          ],
        ),
      ),
    );
    return Padding(
      padding: EdgeInsets.only(top: 18 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(
                      Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "이메일 "),
                TextSpan(
                    style: textStyle(
                      Color(0xfff84457),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "*")
              ],
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
                    width: 170 * Scale.width,
                    height: 60 * Scale.height,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9]')),
                      ],
                      onChanged: (text) {
                        setState(() {});
                      },
                      textInputAction: TextInputAction.next,
                      maxLength: 30,
                      controller: textController,
                      decoration: InputDecoration(
                        counterText: "",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        contentPadding: EdgeInsets.only(left: 12 * Scale.width),
                        labelStyle: TextStyle(
                          color: const Color(0xff666666),
                          height: 0.6,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.sp,
                        ),
                        hintText: ("입력하세요"),
                        hintStyle: textStyle(const Color(0xffcccccc),
                            FontWeight.w400, "NotoSansKR", 16.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc), width: 1.w),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc), width: 1.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc), width: 1.w),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc), width: 1.w),
                        ),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 7 * Scale.width),
              Text(
                "@",
                style: textStyle(
                  Color(0xff333333),
                  FontWeight.w500,
                  "NotoSansKR",
                  16.0,
                ),
              ),
              SizedBox(width: 7 * Scale.width),
              MenuButton<String>(
                scrollPhysics: AlwaysScrollableScrollPhysics(),
                child: normalChildButton,
                items: keys,
                itemBuilder: (String value) {
                  return Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 16),
                    child: Text(value),
                  );
                },
                toggledChild: Container(
                  child: normalChildButton,
                ),
                onItemSelected: (String value) {
                  setState(() {
                    selectedKey = value;
                    print(selectedKey);
                  });
                },
                onMenuButtonToggle: (bool isToggle) {
                  print(isToggle);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
