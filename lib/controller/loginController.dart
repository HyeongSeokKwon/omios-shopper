import 'package:cloth_collection/http/httpService.dart';
import 'package:cloth_collection/model/loginModel.dart';
import 'package:cloth_collection/page/home.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isAutoLoginChecked;
  var loginResponse;

  HttpService httpservice = HttpService();
  String errorString = "";
  String userId = "";
  String userPwd = "";
  late LoginRequestModel loginRequestModel;
  late final SharedPreferences prefs;

  Future<void> initLoginController(context) async {
    httpservice.getToken();
    prefs = await SharedPreferences.getInstance();
    isAutoLoginChecked = prefs.getBool('isChecked');

    if (isAutoLoginChecked == null) {
      isAutoLoginChecked = false;
      await prefs.setBool('isChecked', isAutoLoginChecked);
    }

    if (httpservice.isRefreshExpired()) {
      // refresh token 만료되면 오토로그인 풀리게
      await prefs.setBool('isChecked', isAutoLoginChecked);
    }
    autoLogin().catchError((e) {
      throw e;
    });
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

  Future<void> autoLogin() async {
    if (prefs.getBool("isChecked") == true) {
      print("do autologin");
      try {
        httpservice.updateToken();
      } catch (e) {
        throw e;
      }
      Get.to(() => HomePage());
    }
  }

  Future<bool> loginRequest() async {
    var responseData;
    loginRequestModel = LoginRequestModel(userId, userPwd);

    try {
      loginResponse = await httpservice.httpPublicPost(
          '/users/tokens', loginRequestModel.toJson());
      print(loginResponse);
      //만약 ID PW가 틀리면 =>
      if (loginResponse['message'] ==
          "No active account found with the given credentials") {
        return false;
      }
      //만약 ID PW가 맞으면=>
      else {
        responseData = loginResponse['data'];
        print(responseData['access']);
        httpservice.setAccessToken(responseData['access']);
        httpservice.setRefreshToken(responseData['refresh']);
        return true;
      }
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<bool> loginButtonPressed(String username, String password) {
    getLoginInfo(username, password);
    return loginRequest();
  }
}
