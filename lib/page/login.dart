import 'package:cloth_collection/controller/loginController.dart';
import 'package:cloth_collection/page/home.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/frequently_used_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String autoLoginIcon = "assets/images/svg/login.svg";
  String autoUnLoginIcon = "assets/images/svg/unlogin.svg";
  LoginController loginController = LoginController();
  TextEditingController idTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  @override
  void initState() async {
    super.initState();
    loginController.init();
    canVibrate = await Vibrate.canVibrate;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: const Color(0xffffffff),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 지금 당신의 쇼핑몰을  책임지는 시간 Deepy
              _buildMainText(width, height),
              Column(
                children: [
                  SizedBox(height: height * 0.056),
                  _buildTextfield("아이디", width, height),
                  SizedBox(height: height * 0.018),
                  _buildTextfield("비밀번호", width, height),
                  _buildAutoLogin(width, height),
                  _buildLoginButton(width, height),
                  SizedBox(height: height * 0.022),
                  _buildFindArea(),
                  SizedBox(height: height * 0.212),
                  _buildSignInButton(width, height)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainText(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.123, left: width * 0.053),
      child: Container(
        child: Text("지금 당신의 쇼핑몰을\n책임지는 시간\nDeepy",
            style: textStyle(const Color(0xff333333), FontWeight.w700,
                "NotoSansKR", 28.0.sp)),
      ),
    );
  }

  Widget _buildTextfield(String type, width, height) {
    final TextEditingController textController =
        type == "아이디" ? idTextController : pwdTextController;

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
        child: Stack(
          children: [
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
              ],
              onChanged: (value) {
                setState(() {});
              },
              textInputAction: TextInputAction.next,
              maxLength: 30,
              controller: textController,
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
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "NotoSansKR", 16.sp)),
              textAlign: TextAlign.left,
              onFieldSubmitted: (value) {
                if (type == "비밀번호") {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
            textController.text.length > 0
                ? Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: new Icon(
                          Icons.clear,
                          color: const Color(0xffcccccc),
                        ),
                        onPressed: () {
                          setState(() {
                            textController.clear();
                          });
                        }),
                  )
                : Container(
                    height: 0.0,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoLogin(double width, double height) {
    return Container(
      height: height * 0.069,
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.053),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 자동로그인
            Container(
              width: width * 0.065,
              child: GetBuilder<LoginController>(
                id: "autoLogin",
                init: loginController,
                builder: (_) => FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return InkWell(
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.043,
                                height: width * 0.043,
                                child: SvgPicture.asset(
                                  loginController.isChecked
                                      ? autoLoginIcon
                                      : autoUnLoginIcon,
                                ),
                              ),
                              SizedBox(width: width * 0.014),
                            ],
                          ),
                          onTap: () {
                            loginController.checkedAutoLogin();
                          },
                        );
                      } else
                        return progressBar();
                    } else
                      return progressBar();
                  },
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: height * 0.6,
                child: Center(
                  child: Text(
                    "자동로그인",
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 14.sp),
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

  Widget _buildLoginButton(double width, double height) {
    return Center(
      child: TextButton(
        child: Text("로그인", style: TextStyle(color: Colors.white)),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
              Size(width * 0.894, height * 0.067)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffec5363)),
        ),
        onPressed: () {
          loginController.getLoginInfo(
              idTextController.text, pwdTextController.text);
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
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            height: 15.h,
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
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.sp)),
      onTap: () {
        if (findTarget == "아이디 찾기") {
          //아이디 찾기에 따른 로직
        } else {
          //비밀번호 찾기에 따른 로직
        }
      },
    );
  }

  Widget _buildSignInButton(double width, double height) {
    return Center(
      child: TextButton(
        child: Text(
          "지금 회원가입하기!",
          style: textStyle(
              const Color(0xff666666), FontWeight.w500, "NotoSansKR", 16.sp),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
          Get.to(() => HomePage());
        },
      ),
    );
  }
}

// class SearchTextFieldState extends State<SearchTextField> {
//   final TextEditingController _textController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Row(
//       children: <Widget>[
//         new Expanded(
//           child: new Stack(
//               alignment: const Alignment(1.0, 1.0),
//               children: <Widget>[
//                 new TextField(
//                   decoration: InputDecoration(hintText: 'Search'),
//                   onChanged: (text) {
//                     setState(() {
//                       print(text);
//                     });
//                   },
//                   controller: _textController,
//                 ),
//                 _textController.text.length > 0
//                     ? new IconButton(
//                         icon: new Icon(Icons.clear),
//                         onPressed: () {
//                           setState(() {
//                             _textController.clear();
//                           });
//                         })
//                     : new Container(
//                         height: 0.0,
//                       )
//               ]),
//         ),
//       ],
//     );
//   }
// }
