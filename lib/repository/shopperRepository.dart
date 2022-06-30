import 'dart:convert';

import 'package:cloth_collection/repository/httpRepository.dart';

class ShopperRepository extends HttpRepository {
  static const String shopperInfoUrl = "/users/shoppers";
  static const String pointHistoryUrl = "/users/shoppers/point-histories";
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getShopperInfo() async {
    try {
      response = await super.httpGet(shopperInfoUrl);
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> patchShopperInfo(Map body) async {
    try {
      response = await super.httpPatch(shopperInfoUrl, json.encode(body));
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPointHistory(String type) async {
    try {
      switch (type) {
        case "All":
          response = await super.httpGet(pointHistoryUrl);
          break;
        case "USE":
          response = await super.httpGet(pointHistoryUrl, {'type': 'USE'});
          break;

        case "SAVE":
          response = await super.httpGet(pointHistoryUrl, {'type': 'SAVE'});
          break;
      }

      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
