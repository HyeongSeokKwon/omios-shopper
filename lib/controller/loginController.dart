import 'dart:convert';

import 'package:cloth_collection/http/httpService.dart';
import 'package:cloth_collection/model/loginModel.dart';
import 'package:cloth_collection/page/home.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isAutoLoginChecked;
  var loginResponse;

  String errorString = "";
  String userId = "";
  String userPwd = "";
  String errorMessage = "";
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

    if (HttpService.isRefreshExpired()) {
      // refresh token 만료되면 오토로그인 풀리게
      prefs.setBool('isCheckd', isAutoLoginChecked);
    }
    if (isAutoLoginChecked) {
      HttpService.updateToken();
      Get.to(() => HomePage());
    }
    print(isAutoLoginChecked);
    update(["autoLogin"]);
  }

  void getLoginInfo(String id, String pwd) {
    userId = id;
    userPwd = pwd;
  }

  void checkedAutoLogin() {
    isAutoLoginChecked = !isAutoLoginChecked;

    prefs.setBool('isChecked', isAutoLoginChecked);
    update(["autoLogin"]);
  }

  void autoLogin() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isChecked") == true) {
      print("do autologin");
      HttpService.updateToken();
      Get.to(() => HomePage());
    }
  }

  Future<bool> loginRequest() async {
    loginRequestModel = LoginRequestModel(userId, userPwd);

    loginResponse =
        await HttpService.httpPost('/user/token/', loginRequestModel.toJson());
    var responseBody = jsonDecode(loginResponse.body);

    //만약 ID PW가 틀리면 =>
    if (responseBody['detail'] ==
        "No active account found with the given credentials") {
      print("check id pw");
      return false;
    }
    //만약 ID PW가 맞으면=>
    else {
      HttpService.setAccessToken(responseBody['access']);
      HttpService.setRefreshToken(responseBody['refresh']);
      //HttpService.httpGet("/user/shopper/");
      return true;
    }
  }

  Future<bool> loginButtonPressed(String username, String password) {
    getLoginInfo(username, password);
    return loginRequest();
  }
}
