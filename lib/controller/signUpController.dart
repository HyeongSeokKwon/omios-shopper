import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late String id;
  late String pwd;
  String email = "";

  String isDuplicationCheck = "default";
  String isPwdValidate = "default";
  String isPwdSame = "default";
  bool isAgreeAllTerms = false;
  bool isAgreeFirstTerms = false;
  bool isAgreeSecondTerms = false;
  bool isSatisfy = false;

  HttpRepository httpRepository = HttpRepository();

  void resetIsDuplicationCheck() {
    isDuplicationCheck = "default";
    update();
  }

  void validateId(String id) async {
    var response;
    Map<String, dynamic> queryParams = {};
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (regex.hasMatch(id) && id.length >= 4) {
      queryParams['username'] = id;
      response =
          await httpRepository.httpPublicGet("/users/unique", queryParams);
      if (response['data']['is_unique'])
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
    } else if (checkPassword.length == 0) {
      isPwdSame = "default";
    } else {
      isPwdSame = "deny";
    }

    update();
  }

  bool isPerfectForSignUp() {
    if (isDuplicationCheck == "accept" &&
        isPwdValidate == "accept" &&
        isPwdSame == "accept" &&
        isAgreeFirstTerms == true &&
        email != "") {
      isSatisfy = true;
      return true;
    }
    isSatisfy = false;
    return false;
  }

  void clickedAllTerm() {
    if (!isAgreeAllTerms) {
      isAgreeAllTerms = true;
      isAgreeFirstTerms = true;
      isAgreeSecondTerms = true;
    } else {
      isAgreeAllTerms = false;
      isAgreeFirstTerms = false;
      isAgreeSecondTerms = false;
    }

    update();
  }

  void clickedFirstTerm() {
    if (isAgreeFirstTerms) {
      isAgreeAllTerms = false;
      isAgreeFirstTerms = false;
    } else {
      isAgreeFirstTerms = true;
      if (isAgreeSecondTerms) {
        isAgreeAllTerms = true;
      }
    }
    update();
  }

  void clickedSecondTerm() {
    if (isAgreeSecondTerms) {
      isAgreeAllTerms = false;
      isAgreeSecondTerms = false;
    } else {
      isAgreeSecondTerms = true;
      if (isAgreeFirstTerms) {
        isAgreeAllTerms = true;
      }
    }
    update();
  }

  void gotoAuthentification() async {
    var response;

    update();
  }
}
