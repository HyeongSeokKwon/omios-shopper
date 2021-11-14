import 'dart:convert';
import 'package:cloth_collection/model/loginModel.dart';
import 'package:http/http.dart' as http;

class LoginHttp {
  Future<LoginResponseModel?> login(LoginRequestModel requestModel) async {
    var url = 'https://jsonplaceholder.typicode.com/'; //API
    final response;
    LoginResponseModel? loginResponse;

    response = await http.post(Uri.parse(url), body: requestModel.toJson());

    if (response.statusCode == 200) {
      loginResponse = LoginResponseModel.fromJson(jsonDecode(response.data));
      return loginResponse;
    }
    throw 'Request failed \n Status : ${response.statusCode} \n';
    // try {
    //   response = await http.post(Uri.parse(url), body: requestModel.toJson());
    //   if (response.statusCode != 200)
    //     throw HttpException('${response.statusCode}');
    //   loginResponse = LoginResponseModel.fromJson(jsonDecode(response.data));
    //   return loginResponse;
    // } on SocketException {
    //   print("no internect connection");
    //   return null;
    // } on HttpException {
    //   print("Couldn't find the post");
    //   return null;
    // } on FormatException {
    //   print("Bad response format");
    //   return null;
    // }
  }
}
