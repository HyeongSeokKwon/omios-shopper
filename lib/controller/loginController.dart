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
  late LoginRequestModel loginRequestModel;
  late final SharedPreferences prefs;

  HttpService httpservice = HttpService();

  void init() async {
    httpservice.getToken();
    prefs = await SharedPreferences.getInstance();
    isAutoLoginChecked = prefs.getBool('isChecked');

    if (isAutoLoginChecked == null) {
      isAutoLoginChecked = false;
      prefs.setBool('isChecked', isAutoLoginChecked);
    }

    if (httpservice.isRefreshExpired()) {
      // refresh token 만료되면 오토로그인 풀리게
      prefs.setBool('isChecked', isAutoLoginChecked);
    }
    autoLogin();
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
    if (prefs.getBool("isChecked") == true) {
      print("do autologin");
      httpservice.updateToken();
      Get.to(() => HomePage());
    }
  }

  Future<bool> loginRequest() async {
    var responseData;
    loginRequestModel = LoginRequestModel(userId, userPwd);

    try {
      loginResponse = await httpservice.httpPost(
          '/user/token/', loginRequestModel.toJson());
      //만약 ID PW가 틀리면 =>
      if (loginResponse['detail'] ==
          "No active account found with the given credentials") {
        return false;
      }
      //만약 ID PW가 맞으면=>
      else {
        responseData = loginResponse['data'];
        httpservice.setAccessToken(responseData['access']);
        httpservice.setRefreshToken(responseData['refresh']);
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginButtonPressed(String username, String password) {
    getLoginInfo(username, password);
    return loginRequest();
  }
}
