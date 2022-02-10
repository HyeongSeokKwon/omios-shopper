import 'package:cloth_collection/controller/signUpController.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';

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
  TextEditingController recommandController = TextEditingController();
  SignUpController signUpController = SignUpController();

  @override
  void dispose() {
    idTextController.dispose();
    pwdTextController.dispose();
    pwdCheckTextController.dispose();
    emailController.dispose();
    recommandController.dispose();
    signUpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subjectArea(),
            idArea(),
            passwordArea(),
            passwordCheckArea(),
            emailArea(),
            recommandPersonArea(),
            termsArea(),
            signUpButtonArea(),
          ],
        ),
      ),
    );
  }

  Widget subjectArea() {
    return Padding(
      padding: EdgeInsets.only(
          top: 60 * Scale.height,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
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
      padding: EdgeInsets.only(
          top: 30 * Scale.width,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
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
                    onChanged: (text) {
                      signUpController.id = text;
                    },
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
                        fontSize: 14.0,
                      ),
                      suffixIcon: GetBuilder<SignUpController>(
                          init: signUpController,
                          builder: (controller) {
                            if (controller.isDuplicationCheck == "accept") {
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
                          FontWeight.w400, "NotoSansKR", 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: const Color(0xffcccccc),
                            width: 1 * Scale.width),
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
      padding: EdgeInsets.only(
          top: 18 * Scale.width,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
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
                    signUpController.pwd = text;
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
                      fontSize: 14.0,
                    ),
                    suffixIcon: GetBuilder<SignUpController>(
                        init: signUpController,
                        builder: (controller) {
                          if (controller.isPwdValidate == "accept") {
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
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
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
    );
  }

  Widget passwordCheckArea() {
    final TextEditingController textController = pwdCheckTextController;
    return Padding(
      padding: EdgeInsets.only(
          top: 18 * Scale.height,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
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
                      fontSize: 14.0,
                    ),
                    suffixIcon: GetBuilder<SignUpController>(
                        init: signUpController,
                        builder: (controller) {
                          if (controller.isPwdSame == "accept") {
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
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
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
    );
  }

  Widget emailArea() {
    final TextEditingController textController = emailController;

    return Padding(
      padding: EdgeInsets.only(
          top: 18 * Scale.width,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
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
                    height: 60 * Scale.height,
                    width: 370 * Scale.width,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9!-~]')),
                      ],
                      onChanged: (text) {
                        signUpController.email = text;
                      },
                      keyboardType: TextInputType.emailAddress,
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
                          fontSize: 14.0,
                        ),
                        hintText: ("입력하세요"),
                        hintStyle: textStyle(const Color(0xffcccccc),
                            FontWeight.w400, "NotoSansKR", 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc),
                              width: 1 * Scale.width),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc),
                              width: 1 * Scale.width),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: const Color(0xffcccccc),
                              width: 1 * Scale.width),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
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
          SizedBox(height: 20 * Scale.height),
          Text(
            " 신규가입혜택 안내와 비밀번호 찾기가 이메일로 제공됩니다.\n 이메일을 정확히 입력해주세요.",
            style: textStyle(
                Color(0xff797979), FontWeight.w400, "NotoSansKR", 13.0),
          )
        ],
      ),
    );
  }

  Widget recommandPersonArea() {
    var textController = recommandController;
    return Padding(
      padding: EdgeInsets.only(
          left: 22 * Scale.width, right: 22 * Scale.width, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " 추천인 (친구초대 이벤트 - 친구아이디)",
            style: textStyle(
                Color(0xff797979), FontWeight.w400, "NotoSansKR", 13.0),
          ),
          SizedBox(height: 4 * Scale.height),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
            ],
            onChanged: (text) {
              signUpController.email = text;
            },
            maxLength: 30,
            controller: textController,
            decoration: InputDecoration(
              counterText: "",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.only(left: 12 * Scale.width),
              labelStyle: textStyle(
                const Color(0xff666666),
                FontWeight.w400,
                "NotoSansKR",
                14.0,
              ),
              hintText: ("추천인을 입력하세요"),
              hintStyle: textStyle(
                  const Color(0xffcccccc), FontWeight.w400, "NotoSansKR", 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget termsArea() {
    return Padding(
      padding: EdgeInsets.only(
          left: 22 * Scale.width, right: 22 * Scale.width, top: 40),
      child: Column(
        children: [
          Text(
            "deepy 이용약관 및 개인정보취급방침에 동의하셔야 회원가입이 완료됩니다.",
            style: textStyle(
                Color(0xff797979), FontWeight.w400, "NotoSansKR", 14.0),
          ),
          SizedBox(height: 15 * Scale.height),
          GetBuilder<SignUpController>(
              init: signUpController,
              builder: (controller) {
                return Container(
                    width: 370 * Scale.width,
                    height: 48 * Scale.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: signUpController.isAgreeAllTerms == false
                          ? Color(0xfffafafa)
                          : Color(0xffebf7f1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 14 * Scale.width),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(
                              signUpController.isAgreeAllTerms == false
                                  ? "assets/images/svg/termcheck.svg"
                                  : "assets/images/svg/termaccept.svg",
                              width: 22 * Scale.width,
                              height: 22 * Scale.height,
                            ),
                            onTap: () {
                              signUpController.clickedAllTerm();
                            },
                          ),
                          SizedBox(width: 10 * Scale.width),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "전체 동의",
                                style: textStyle(Color(0xff555555),
                                    FontWeight.w400, "NotoSansKR", 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              }),
          SizedBox(height: 10 * Scale.height),
          GetBuilder<SignUpController>(
              init: signUpController,
              builder: (controller) {
                return Container(
                    width: 370 * Scale.width,
                    height: 69 * Scale.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: signUpController.isAgreeFirstTerms == false
                          ? Color(0xfffafafa)
                          : Color(0xffebf7f1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 14 * Scale.width),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(
                              signUpController.isAgreeFirstTerms == false
                                  ? "assets/images/svg/termcheck.svg"
                                  : "assets/images/svg/termaccept.svg",
                              width: 22 * Scale.width,
                              height: 22 * Scale.height,
                            ),
                            onTap: () {
                              signUpController.clickedFirstTerm();
                            },
                          ),
                          SizedBox(width: 10 * Scale.width),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "이용 약관 동의",
                                style: textStyle(Color(0xff555555),
                                    FontWeight.w400, "NotoSansKR", 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              }),
          SizedBox(height: 10 * Scale.height),
          GetBuilder<SignUpController>(
            init: signUpController,
            builder: (controller) {
              return Container(
                width: 370 * Scale.width,
                height: 69 * Scale.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: signUpController.isAgreeSecondTerms == false
                      ? Color(0xfffafafa)
                      : Color(0xffebf7f1),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 14 * Scale.width),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                          signUpController.isAgreeSecondTerms == false
                              ? "assets/images/svg/termcheck.svg"
                              : "assets/images/svg/termaccept.svg",
                          width: 22 * Scale.width,
                          height: 22 * Scale.height,
                        ),
                        onTap: () {
                          signUpController.clickedSecondTerm();
                        },
                      ),
                      SizedBox(width: 10 * Scale.width),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "개인정보취급방침 및 이메일, SMS 수신동의",
                            style: textStyle(Color(0xff555555), FontWeight.w400,
                                "NotoSansKR", 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget signUpButtonArea() {
    return Padding(
      padding: EdgeInsets.only(top: 25 * Scale.height),
      child: Container(
        width: 414 * Scale.width,
        height: 100 * Scale.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
                color: const Color(0x1a000000),
                offset: Offset(0, -2),
                blurRadius: 3,
                spreadRadius: 0)
          ],
          color: Color(0xffffffff),
        ),
        child: Center(
          child: GetBuilder<SignUpController>(
            init: signUpController,
            builder: (controller) {
              return TextButton(
                child: Text("본인인증하고 가입하기",
                    style: textStyle(Color(0xffffffff), FontWeight.w500,
                        "NotoSansKR", 16.0)),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(370 * Scale.width, 60 * Scale.height)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      signUpController.isPerfectForSignUp() == true
                          ? Color(0xffec5363)
                          : Color(0xffcccccc)),
                ),
                onPressed: () {
                  if (signUpController.isSatisfy) {
                    signUpController.gotoAuthentification();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
