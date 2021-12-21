import 'dart:convert';

import 'package:get/get.dart';
import 'package:cloth_collection/http/httpService.dart';

class SignUpController extends GetxController {
  late String id;
  late String pwd;
  late String email;

  String isDuplicationCheck = "default";
  String isPwdValidate = "default";
  String isPwdSame = "default";
  bool isAgreeAllTerms = false;
  bool isAgreeFirstTerms = false;
  bool isAgreeSecondTerms = false;

  void resetIsDuplicationCheck() {
    isDuplicationCheck = "default";
    update();
  }

  void validateId(String id) async {
    var response;
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (regex.hasMatch(id) && id.length >= 4) {
      response = await HttpService.httpGet("/user/unique/username/$id/");
      if (response['message'])
        isDuplicationCheck = "accept";
      else
        isDuplicationCheck = "deny";
    }
    if (id.length < 4) {
      isDuplicationCheck = "deny";
    }

    update();
  }

  void validatePassword(String password, String checkPassword) {
    RegExp regex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[!-~]+$');
    validateDuplicationCheck(password, checkPassword);
    if (regex.hasMatch(password) && password.length >= 10) {
      isPwdValidate = "accept";
    } else if (password.length == 0) {
      isPwdValidate = "default";
    } else {
      isPwdValidate = 'deny';
    }

    update();
  }

  void validateDuplicationCheck(String password, String checkPassword) {
    if (password == checkPassword && password.length != 0) {
      isPwdSame = "accept";
      print(isPwdSame);
    } else if (checkPassword.length == 0) {
      isPwdSame = "default";
    } else {
      isPwdSame = "deny";
    }

    update();
  }
}
