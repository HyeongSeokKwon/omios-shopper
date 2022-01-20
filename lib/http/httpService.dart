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
  var addressUrl = 'http://13.209.244.41';
  var addressUrlx = '13.209.244.41';
  late SharedPreferences pref;

  dynamic _response(http.Response response) {
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
        throw FetchDataException("500 :");

      default:
        throw FetchDataException('');
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
        try {
          var response = await http.post(
            Uri.parse(addressUrl + '/token/refresh/'), // refresh token 으로 재발급
            headers: {"Content-Type": "application/json; charset=UTF-8"},
            body: json.encode(
              {"refresh": refreshToken},
            ),
          );

          responseJson = _response(response);
          setAccessToken(responseJson['data']['access']);
          setRefreshToken(responseJson['data']['refresh']);
        } on SocketException {
          throw FetchDataException("연결된 인터넷이 없습니다.");
        }
      }
    } else {
      print("access token is valid");
    }
  }

  Future<dynamic> httpGet(String baseUrl,
      [Map<String, String>? queryParams]) async {
    var response;
    var responseJson;
    try {
      updateToken();
      response = await http.get(Uri.http(addressUrlx, baseUrl, queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'});

      //responseBody = utf8.decode(response.bodyBytes);

      responseJson = _response(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpPost(String addtionalUrl, var body) async {
    var response;
    var responseJson;

    if (addtionalUrl != "/token/") {
      updateToken();
    }

    try {
      response = await http.post(Uri.parse(addressUrl + addtionalUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: body);

      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    }
  }

  Future<dynamic> httpPatch(String addtionalUrl) async {}

  Future<dynamic> httpDelete(String addtionalUrl) async {}
}
