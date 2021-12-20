import 'dart:convert';
import 'dart:io';
import 'package:cloth_collection/model/loginModel.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 13.209.244.41/user/token/            : id, pwd 이용해서 token 발급
// 13.209.244.41/user/token/refresh/    : refresh token이용해서 token 발급
// username = rkdeowls
// password = rkdeowls
class HttpService {
  static var refreshToken;
  static var accessToken;
  static var baseUrl = 'http://13.209.244.41';
  static late SharedPreferences pref;

  static void getToken() async {
    pref = await SharedPreferences.getInstance();
    refreshToken = pref.getString('refreshToken');
    accessToken = pref.getString('accessToken');
  }

  static void setRefreshToken(var changedRefreshToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('refreshToken', changedRefreshToken);
    refreshToken = changedRefreshToken;
  }

  static void setAccessToken(var changedAccessToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', changedAccessToken);
    accessToken = changedAccessToken;
  }

  static bool isAccessExpired() {
    // 1. access token 만료 확인
    // 2. refresh token 만료 확인
    // 3-1. refresh token이 만료가 되었으면, 로그아웃
    // 3-2. refresh token이 만료가 안되었으면, refresh token 이용해서 token 발급
    if (accessToken == null || Jwt.isExpired(accessToken)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isRefreshExpired() {
    if (refreshToken == null || Jwt.isExpired(refreshToken)) {
      return true;
    } else {
      return false;
    }
  }

  static void updateToken() async {
    // refresh token으로 accessToken 갱신시키는 함수
    var decodedValidationResponse;
    if (isAccessExpired()) {
      //access token 만료 되었으면
      if (!isRefreshExpired()) {
        // refresh token 만료 되지 않았으면
        var validationResponse = await http.post(
          Uri.parse(baseUrl + '/user/token/refresh/'), // refresh token 으로 재발급
          headers: {"Content-Type": "application/json; charset=UTF-8"},
          body: json.encode(
            {"refresh": refreshToken},
          ),
        );
        print(validationResponse.body);
        decodedValidationResponse = jsonDecode(validationResponse.body);
        setAccessToken(decodedValidationResponse['access']);
        setRefreshToken(decodedValidationResponse['refresh']);
      }
    }
  }

  static Future<dynamic> httpGet(String additionalUrl) async {
    var response;
    var responseBody;
    updateToken();

    response = await http.get(Uri.parse(baseUrl + additionalUrl),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'});
    print("get response>>>>>>>>>>>>>>>>>>>");
    responseBody = utf8.decode(response.bodyBytes);
    // print(jsonDecode(responseBody));
    // print(jsonDecode(responseBody).runtimeType);
    return jsonDecode(responseBody);
  }

  static Future<dynamic> httpPost(String addtionalUrl, var body) async {
    var response;
    if (addtionalUrl != "/user/token/") {
      //ID PW 로 갱신 시키는 요청은 굳이 updateToken 과정 필요없음
      updateToken();
    }

    response = await http.post(Uri.parse(baseUrl + addtionalUrl),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
        body: body);

    print("post response>>>>>>>>>>>");
    print(response.body);
    print(response.body.runtimeType);
    return response;
  }

  static Future<dynamic> httpPatch(String addtionalUrl) async {}

  static Future<dynamic> httpDelete(String addtionalUrl) async {}
}

class LoginHttp {
  Future<LoginResponseModel?> login(LoginRequestModel requestModel) async {
    var url = 'http://13.209.244.41'; //API
    var response;
    LoginResponseModel? loginResponse;

    response = await http.post(Uri.parse(url + '/user/token/'), //토큰
        body: requestModel.toJson());

    var access_token = jsonDecode(response.body)['access'];
    var refresh_token = jsonDecode(response.body)['refresh'];
    // access_token, refresh_token의 payload 정보를 sqlite에 저장
    // var c = Jwt.parseJwt(a['refresh']);
    // var c = Jwt.parseJwt(a['access']);

    print(access_token);
    print(refresh_token);
    print(access_token.runtimeType); //access_token은 String => Jwt.parse에서 파싱
    response = await http.get(Uri.parse(url + '/user/shopper/'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $access_token'});
    print("isExpired : " + Jwt.isExpired(access_token).toString());
    print(response.headers);
    print(utf8.decode(response.bodyBytes));
    print(Jwt.getExpiryDate(access_token)); //만료 날짜 타입 DateTime
    print(Jwt.parseJwt(access_token));
    print(Jwt.parseJwt(refresh_token));
    print(jsonDecode(response.body));

    // if (response.statusCode == 200) {
    //   loginResponse = LoginResponseModel.fromJson(jsonDecode(response.data));
    //   return loginResponse;
    // }
    //throw 'Request failed \n Status : ${response.statusCode}\n';
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
