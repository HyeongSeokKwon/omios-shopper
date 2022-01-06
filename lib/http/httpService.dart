import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'httpException.dart';

// 13.209.244.41/user/token/            : id, pwd 이용해서 token 발급
// 13.209.244.41/user/token/refresh/    : refresh token이용해서 token 발급
// username = rkdeowls
// password = rkdeowls

// 1. access token 만료 확인
// 2. refresh token 만료 확인
// 3-1. refresh token이 만료가 되었으면, 로그아웃
// 3-2. refresh token이 만료가 안되었으면, refresh token 이용해서 token 발급
class HttpService {
  static var refreshToken;
  static var accessToken;
  var baseUrl = 'http://13.209.244.41';
  late SharedPreferences pref;

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode:${response.statusCode}');
    }
  }

  void getToken() async {
    pref = await SharedPreferences.getInstance();
    refreshToken = pref.getString('refreshToken');
    accessToken = pref.getString('accessToken');
  }

  void setRefreshToken(var changedRefreshToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('refreshToken', changedRefreshToken);
    refreshToken = changedRefreshToken;
  }

  void setAccessToken(var changedAccessToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', changedAccessToken);
    accessToken = changedAccessToken;
  }

  bool isAccessExpired() {
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

  void updateToken() async {
    // refresh token으로 accessToken 갱신시키는 함수
    var responseJson;
    if (isAccessExpired()) {
      //access token 만료 되었으면
      if (!isRefreshExpired()) {
        // refresh token 만료 되지 않았으면
        var response = await http.post(
          Uri.parse(baseUrl + '/user/token/refresh/'), // refresh token 으로 재발급
          headers: {"Content-Type": "application/json; charset=UTF-8"},
          body: json.encode(
            {
              "data": {"refresh": refreshToken}
            },
          ),
        );
        responseJson = _response(response);
        setAccessToken(responseJson['access']);
        setRefreshToken(responseJson['refresh']);
      }
    }
  }

  Future<dynamic> httpGet(String additionalUrl) async {
    var response;
    var responseBody;
    var responseJson;
    updateToken();
    try {
      response = await http.get(Uri.parse(baseUrl + additionalUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'});
      responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);
      responseJson = _response(responseBody);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    }
  }

  Future<dynamic> httpPost(String addtionalUrl, var body) async {
    var response;
    var responseJson;
    if (addtionalUrl != "/user/token/") {
      updateToken();
    }

    try {
      response = await http.post(Uri.parse(baseUrl + addtionalUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: body);

      responseJson = _response(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    }
  }

  Future<dynamic> httpPatch(String addtionalUrl) async {}

  Future<dynamic> httpDelete(String addtionalUrl) async {}
}
