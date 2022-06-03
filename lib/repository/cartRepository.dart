import 'dart:convert';

import 'httpRepository.dart';

class CartRepository extends HttpRepository {
  Future<dynamic> getItemFromCarts() async {
    int id = await super.getId();
    Map response;
    try {
      response = await super.httpGet('/users/shoppers/$id/carts');
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registItemToCarts(Map body) async {
    int id = await super.getId();
    Map response;
    try {
      response =
          await super.httpPost("/users/shoppers/$id/carts", json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> deleteItemFromCart(List idList) async {
    int id = await super.getId();
    Map response;
    Map body = {};
    body['id'] = idList;
    try {
      response = await super
          .httpPost("/users/shoppers/$id/carts/remove", json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
