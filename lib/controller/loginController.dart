import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isChecked;

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isChecked = prefs.getBool('isChecked');
    if (isChecked == null) {
      isChecked = false;
    }

    print("LoginController init");
    prefs.setBool('isChecekd', isChecked);
  }

  void checkedAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isChecked = !isChecked;
    prefs.setBool('isChecked', isChecked);
    print(isChecked);
    update();
  }
}
