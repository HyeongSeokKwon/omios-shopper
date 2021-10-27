import 'dart:convert';
import 'package:cloth_collection/model/loginModel.dart';
import 'package:http/http.dart' as http;

class LoginHttp {
  // Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
  //   var url = Uri.parse('uri'); //API

  //   final response = await http.post(url, body: requestModel.toJson());

  //     print(requestModel.toJson());
  //   if (response.statusCode == 200) {
  //     return LoginResponseModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('failed to load data');
  //   }
  // }
  void login(LoginRequestModel requestModel) {
    print(requestModel.toJson());
  }
}
