import 'dart:convert';

import 'package:cloth_collection/repository/httpRepository.dart';

class AuthRepository extends HttpRepository {
  static const String createTokenUrl = "users/tokens";
  static const String createAccessTokenByRefreshUrl = "users/tokens/refresh";
  late Map response;

  Future<dynamic> basicLogin(String id, String password) async {
    Map<String, String> body = {
      'username': id,
      'password': password,
    };

    try {
      response = await super.httpPublicPost(createTokenUrl, json.encode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> autoLogin(String refreshToken) async {
    Map<String, String> body = {
      'refresh': refreshToken,
    };

    try {
      response = await super
          .httpPost(createAccessTokenByRefreshUrl, json.encode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
