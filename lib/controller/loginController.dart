import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isChecked;
  late String userId;
  late String userPwd;

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isChecked = prefs.getBool('isChecked');
    if (isChecked == null) {
      isChecked = false;
    }

    print("LoginController init");
    prefs.setBool('isChecekd', isChecked);
  }

  void getLoginInfo(String id, String pwd) {
    userId = id;
    userPwd = pwd;
    print("id:" + id);
    print("pwd:" + pwd);
  }

  void checkedAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isChecked = !isChecked;
    prefs.setBool('isChecked', isChecked);
    update(["autoLogin"]);
  }
}
