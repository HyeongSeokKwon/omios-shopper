import 'dart:convert';

import 'package:cloth_collection/repository/httpRepository.dart';

class ShopperRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getShopperInfo() async {
    try {
      response = await super.httpGet('/users/shoppers');
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> patchShopperInfo(Map body) async {
    try {
      response = await super.httpPatch('/users/shoppers', json.encode(body));
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPointHistory(String type) async {
    try {
      switch (type) {
        case "All":
          response = await super.httpGet("/users/shoppers/point-histories");
          break;
        case "USE":
          response = await super
              .httpGet("/users/shoppers/point-histories", {'type': 'USE'});
          break;

        case "SAVE":
          response = await super
              .httpGet("/users/shoppers/point-histories", {'type': 'SAVE'});
          break;
      }

      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
