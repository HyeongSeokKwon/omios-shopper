import 'dart:convert';

import 'httpRepository.dart';

class CartRepository extends HttpRepository {
  Future<dynamic> getItemFromCarts() async {
    Map response;
    try {
      response = await super.httpGet('/users/shoppers/carts');
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registItemToCarts(Map body) async {
    Map response;
    try {
      response =
          await super.httpPost("/users/shoppers/carts", json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> deleteItemFromCart(List idList) async {
    Map response;
    Map body = {};
    body['id'] = idList;
    try {
      response = await super
          .httpPost("/users/shoppers/carts/remove", json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
