import 'dart:convert';

import 'package:cloth_collection/http/loginHttp.dart';
import 'package:cloth_collection/model/loginModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isAutoLoginChecked;
  var loginResponseModel;

  String errorString = "";
  String userId = "";
  String userPwd = "";
  String errorMessage = "";
  late BuildContext context;

  late LoginRequestModel loginRequestModel;
  late LoginHttp loginHttp;
  late final SharedPreferences prefs;
  late var userData;

  void init() async {
    prefs = await SharedPreferences.getInstance();
    isAutoLoginChecked = prefs.getBool('isChecked');

    if (isAutoLoginChecked == null) {
      isAutoLoginChecked = false;
      prefs.setBool('isCheckd', isAutoLoginChecked);
    }
    print(isAutoLoginChecked);
    update(["autoLogin"]);
  }

  void getLoginInfo(String id, String pwd) {
    userId = id;
    userPwd = pwd;
    print("id:" + id);
    print("pwd:" + pwd);
  }

  void checkedAutoLogin() {
    isAutoLoginChecked = !isAutoLoginChecked;

    prefs.setBool('isChecked', isAutoLoginChecked);
    update(["autoLogin"]);
  }

  Future<String?> loginRequest() async {
    loginRequestModel = LoginRequestModel(userId, userPwd);
    loginHttp = LoginHttp();
    try {
      loginResponseModel = await loginHttp.login(loginRequestModel);
    } catch (e) {
      print(e);
      errorMessage = e.toString();
    }
  }

  void loginButtonPressed(String userId, String userPwd) {
    getLoginInfo(userId, userPwd);
    if (userId != "" && userPwd != "") {
      if (isAutoLoginChecked) {
        //자동 로그인 되어있으면 userdata to json 해서 공유변수에 저장
        userData = json.encode(
          {
            'accessToken': null, //_token;
            'refreshToken': null,
            'id': userId,
            'pwd': userPwd,
            'refreshTokenExpiryDate': null, //expiryDate,
          },
        );

        // prefs.setString('userData', userData);
      }

      loginRequest();
    } else {
      print("ID PWD 누락");
    }
  }
}
