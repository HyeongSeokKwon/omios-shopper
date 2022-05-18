import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../page/login/login.dart';
import 'httpException.dart';

// 13.209.244.41/user/token/            : id, pwd 이용해서 token 발급
// 13.209.244.41/user/token/refresh/    : refresh token이용해서 token 발급
// username = rkdeowls
// password = rkdeowls

class HttpService {
  static var refreshToken;
  static var accessToken;
  static var id;
  var addressUrl = 'http://13.209.244.41';
  var addressUrlx = '13.209.244.41';
  late SharedPreferences pref;

  dynamic _response(http.Response response) {
    print(response.body);

    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 201:
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 400:
        throw BadRequestException("400 :");

      case 401:
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 403:
        throw UnauthorisedException("403 :");

      case 404:
        throw NotfoundException("404 :");

      case 500:
        print(response.body);
        throw FetchDataException("500 :");

      default:
        throw FetchDataException('');
    }
  }

  int getId() {
    getToken();
    return Jwt.parseJwt(accessToken)['user_id'];
  }

  void getToken() async {
    pref = await SharedPreferences.getInstance();
    refreshToken = pref.getString('refreshToken');
    accessToken = pref.getString('accessToken');
  }

  Future<void> setRefreshToken(var changedRefreshToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('refreshToken', changedRefreshToken);
    refreshToken = changedRefreshToken;
  }

  Future<void> setAccessToken(var changedAccessToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', changedAccessToken);
    accessToken = changedAccessToken;
    id = Jwt.parseJwt(accessToken)['user_id'];
  }

  bool isAccessExpired() {
    print(accessToken);
    if (accessToken == null || Jwt.isExpired(accessToken)) {
      return true;
    } else {
      return false;
    }
  }

  bool isRefreshExpired() {
    if (refreshToken == null || Jwt.isExpired(refreshToken)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateToken() async {
    // refresh token으로 accessToken 갱신시키는 함수
    var responseJson;
    if (isAccessExpired()) {
      //access token 만료 되었으면
      if (!isRefreshExpired()) {
        // refresh token 만료 되지 않았으면
        print("refreshToken으로 token 갱신");
        try {
          var response = await http.post(
            Uri.parse(
                addressUrl + '/users/tokens/refresh'), // refresh token 으로 재발급
            headers: {"Content-Type": "application/json; charset=UTF-8"},
            body: json.encode(
              {"refresh": refreshToken},
            ),
          );

          responseJson = _response(response);
          print(responseJson);
          await setAccessToken(responseJson['data']['access']);
          await setRefreshToken(responseJson['data']['refresh']);
        } on SocketException {
          throw FetchDataException("연결된 인터넷이 없습니다.");
        } catch (e) {
          Get.snackbar('Snackbar', e.toString(),
              snackPosition: SnackPosition.TOP);
          Get.offAll(Login());
        }
      }
    } else {
      print("access token is valid");
    }
  }

  Future<dynamic> httpGet(String baseUrl,
      [Map<String, dynamic>? queryParams]) async {
    var response;
    var responseJson;
    try {
      await updateToken().then((value) async => response = await http.get(
          Uri.http(addressUrlx, baseUrl, queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));

      responseJson = _response(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpPublicGet(String baseUrl,
      [Map<String, dynamic>? queryParams]) async {
    var response;
    var responseJson;

    try {
      await updateToken().then((value) async => response = await http.get(
            Uri.http(addressUrlx, baseUrl, queryParams),
          ));

      responseJson = _response(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpPost(String additionalUrl, [var body]) async {
    var response;
    var responseJson;

    try {
      print(Uri.http(addressUrlx, additionalUrl));
      await updateToken().then(((value) async {
        response = await http.post(Uri.http(addressUrlx, additionalUrl),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $accessToken',
              "Content-Type": "application/json; charset=UTF-8"
            },
            body: body ?? body);
        responseJson = _response(response);
      }));
      print(responseJson);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    }
  }

  Future<dynamic> httpPublicPost(String additionalUrl, var body) async {
    var response;
    var responseJson;

    print(Uri.http(addressUrlx, additionalUrl));
    try {
      response =
          await http.post(Uri.parse(addressUrl + additionalUrl), body: body);

      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    }
  }

  Future<dynamic> httpPatch(String addtionalUrl, var body) async {
    var response;
    var responseJson;
    try {
      await updateToken().then((value) async =>
          response = await http.patch(Uri.http(addressUrlx, addtionalUrl),
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $accessToken',
                "Content-Type": "application/json; charset=UTF-8"
              },
              body: body));
      responseJson = _response(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpDelete(String addtionalUrl) async {
    var response;
    var responseJson;
    try {
      await updateToken().then((value) async => response = await http.delete(
          Uri.http(addressUrlx, addtionalUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      responseJson = _response(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }
}
