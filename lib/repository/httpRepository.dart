import 'dart:convert';
import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../http/httpException.dart';

class HttpRepository {
  String? refreshToken;
  String? accessToken;
  late int id;

  String addressUrl = '13.209.244.41';
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
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

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

  Future<int> getId() async {
    await getToken();
    return Jwt.parseJwt(accessToken!)['user_id'];
  }

  Future<void> getToken() async {
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
  }

  bool isAccessExpired() {
    if (accessToken == null || Jwt.isExpired(accessToken!)) {
      return true;
    } else {
      return false;
    }
  }

  bool isRefreshExpired() {
    if (refreshToken == null || Jwt.isExpired(refreshToken!)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateToken() async {
    // refresh token으로 accessToken 갱신시키는 함수
    Map<String, dynamic> responseJson;
    await getToken();
    if (isAccessExpired()) {
      //access token 만료 되었으면
      if (!isRefreshExpired()) {
        // refresh token 만료 되지 않았으면
        try {
          var response = await http.post(
            Uri.http(
                addressUrl, '/users/tokens/refresh'), // refresh token 으로 재발급
            headers: {"Content-Type": "application/json; charset=UTF-8"},
            body: json.encode(
              {"refresh": refreshToken},
            ),
          );
          responseJson = _response(response);
          id = Jwt.parseJwt(responseJson['data']['access'])['user_id'];
          setAccessToken(responseJson['data']['access']);
          setRefreshToken(responseJson['data']['refresh']);
        } on SocketException {
          throw FetchDataException("연결된 인터넷이 없습니다.");
        }
      }
    }
  }

  Future<dynamic> httpGet(String baseUrl,
      [Map<String, dynamic>? queryParams]) async {
    http.Response response;
    var responseJson = {};
    try {
      response = await updateToken().then(((value) async {
        return await http.get(
          Uri.http(addressUrl, baseUrl, queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
        );
      }));
      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    } on FetchDataException {
      throw Exception("서버 오류가 발생했습니다!!");
    }
  }

  Future<dynamic> httpPublicGet(String baseUrl,
      [Map<String, dynamic>? queryParams]) async {
    http.Response response;
    var responseJson = {};
    try {
      response = await http.get(Uri.http(addressUrl, baseUrl, queryParams));

      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpPost(String addtionalUrl, [var body]) async {
    http.Response response;
    Map<String, dynamic> responseJson;

    try {
      response = await updateToken().then(((value) async {
        return await http.post(
            Uri.http(
              addressUrl,
              addtionalUrl,
            ),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              HttpHeaders.authorizationHeader: 'Bearer $accessToken'
            },
            body: body);
      }));
      responseJson = _response(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      throw const SocketException('연결된 인터넷이 없습니다.');
    } on FetchDataException {
      throw Exception("서버 오류가 발생했습니다.");
    }
  }

  Future<dynamic> httpPublicPost(String baseUrl, var body) async {
    http.Response response;
    var responseJson = {};
    try {
      response = await http.post(Uri.http(addressUrl, baseUrl),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpPatch(String addtionalUrl, var body) async {
    http.Response response;
    Map<String, dynamic> responseJson;

    try {
      response = await updateToken().then(((value) async {
        return await http.patch(
            Uri.http(
              addressUrl,
              addtionalUrl,
            ),
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader: 'Bearer $accessToken'
            },
            body: body);
      }));
      print(response.body);
      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    } on FetchDataException {
      throw Exception("서버 오류가 발생했습니다.");
    }
  }

  Future<dynamic> httpDelete(String addtionalUrl) async {
    var response;
    var responseJson;
    try {
      await updateToken().then((value) async => response = await http.delete(
          Uri.http(addressUrl, addtionalUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      responseJson = _response(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }
}
