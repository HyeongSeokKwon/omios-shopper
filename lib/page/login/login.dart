import 'package:cloth_collection/controller/loginController.dart';
import 'package:cloth_collection/page/deepyHome/deepyHome.dart';
import 'package:cloth_collection/page/home.dart';
import 'package:cloth_collection/page/signUp/signUp.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String autoLoginIcon = "assets/images/svg/login.svg";
  String autoUnLoginIcon = "assets/images/svg/unlogin.svg";
  LoginController loginController = LoginController();
  TextEditingController idTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loginController.init();
    //loginController.autoLogin();

    getVibratePermission();
  }

  void getVibratePermission() async {
    try {
      canVibrate = await Vibrate.canVibrate;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Scale.setScale(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: const Color(0xffffffff),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 지금 당신의 쇼핑몰을  책임지는 시간 Deepy
                _buildMainText(),
                Column(
                  children: [
                    SizedBox(height: 50 * Scale.height),
                    _buildLoginField(),
                    SizedBox(height: 16 * Scale.height),
                    _buildAutoLogin(),
                    SizedBox(height: 26 * Scale.height),
                    _buildLoginButton(),
                    SizedBox(height: 20 * Scale.height),
                    _buildFindArea(),
                    SizedBox(height: 190 * Scale.height),
                    _buildSignInButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainText() {
    return Padding(
      padding: EdgeInsets.only(top: 110 * Scale.height, left: 22 * Scale.width),
      child: Container(
        child: Text("지금 당신의 쇼핑몰을\n책임지는 시간\nDeepy",
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 28.0)),
      ),
    );
  }

  Widget _buildLoginField() {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildIdField(),
          SizedBox(height: 16 * Scale.height),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildIdField() {
    final TextEditingController textController = idTextController;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
      child: Stack(
        children: [
          SizedBox(
            // height: 71.0 * Scale.height,
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
                setState(() {});
              },
              textInputAction: TextInputAction.next,
              maxLength: 30,
              controller: textController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(
                  10 * Scale.width,
                  22 * Scale.height,
                  10 * Scale.width,
                  22 * Scale.height,
                ),
                counterText: "",
                labelText: "아이디",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: TextStyle(
                  color: const Color(0xff666666),
                  height: 0.6,
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSansKR",
                  fontStyle: FontStyle.normal,
                  fontSize: 14 * Scale.height,
                ),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.clear,
                    color: const Color(0xff666666),
                    size: 20.0 * Scale.width,
                  ),
                  onPressed: () => textController.clear(),
                ),
                hintText: ("아이디를 입력하세요"),
                hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                    "NotoSansKR", 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    final TextEditingController textController = pwdTextController;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
      child: Stack(
        children: [
          Container(
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
              ],
              validator: (text) {
                if (text!.trim().isNotEmpty && text.trim().length < 4) {
                  return "비밀번호는 6글자 이상 입력해주세요";
                } else
                  return null;
              },
              textInputAction: TextInputAction.next,
              maxLength: 30,
              controller: textController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "비밀번호",
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(
                  10 * Scale.width,
                  22 * Scale.height,
                  10 * Scale.width,
                  22 * Scale.height,
                ),
                labelStyle: TextStyle(
                  color: const Color(0xff666666),
                  height: 0.6,
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSansKR",
                  fontStyle: FontStyle.normal,
                  fontSize: 14 * Scale.height,
                ),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.clear,
                    color: const Color(0xff666666),
                    size: 20.0 * Scale.width,
                  ),
                  onPressed: () => textController.clear(),
                ),
                hintText: ("비밀번호를 입력하세요"),
                hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                    "NotoSansKR", 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide:
                      BorderSide(color: const Color(0xffcccccc), width: 1.w),
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoLogin() {
    return Container(
      height: 20 * Scale.height,
      child: Padding(
        padding: EdgeInsets.only(left: 22.0 * Scale.width),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24 * Scale.width,
              child: GetBuilder<LoginController>(
                id: "autoLogin",
                init: loginController,
                builder: (_) => GestureDetector(
                  child: Row(
                    children: [
                      Container(
                        width: 18 * Scale.width,
                        height: 20 * Scale.height,
                        child: SvgPicture.asset(
                          loginController.isAutoLoginChecked == true
                              ? autoLoginIcon
                              : autoUnLoginIcon,
                        ),
                      ),
                      SizedBox(width: 6 * Scale.width),
                    ],
                  ),
                  onTap: () {
                    loginController.checkedAutoLogin();
                  },
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: 20 * Scale.height,
                child: Center(
                  child: Text(
                    "자동로그인",
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ),
              ),
              onTap: () {
                loginController.checkedAutoLogin();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    bool isLoginSuccess;

    return Center(
      child: TextButton(
        child: Text("로그인",
            style:
                textStyle(Colors.white, FontWeight.w400, "NotoSansKR", 16.0)),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
              Size(370 * Scale.width, 60 * Scale.height)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffec5363)),
        ),
        onPressed: () async {
          try {
            isLoginSuccess = await loginController.loginButtonPressed(
                idTextController.text, pwdTextController.text);

            if (isLoginSuccess) {
              Get.to(() => HomePage());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("아이디,패스워드를 확인해주세요"),
                ),
              );
            }
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(e.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildFindArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFindPrivacy("아이디 찾기"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
          child: Container(
            height: 15 * Scale.height,
            child: VerticalDivider(
              color: const Color(0xff999999),
            ),
          ),
        ),
        _buildFindPrivacy("비밀번호 찾기")
      ],
    );
  }

  Widget _buildFindPrivacy(String findTarget) {
    return InkWell(
      child: Text("$findTarget",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0)),
      onTap: () {
        Get.to(HomePage());
        if (findTarget == "아이디 찾기") {
          //아이디 찾기에 따른 로직
        } else {
          //비밀번호 찾기에 따른 로직
        }
      },
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * Scale.height),
      child: Center(
        child: TextButton(
          child: Text(
            "지금 회원가입하기!",
            style: textStyle(
                const Color(0xff666666), FontWeight.w500, "NotoSansKR", 16.0),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
                side: BorderSide(color: const Color(0xffe2e2e2)),
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
              Size(370 * Scale.width, 56 * Scale.height),
            ),
          ),
          onPressed: () {
            Get.to(() => SignUp());
          },
        ),
      ),
    );
  }
}
