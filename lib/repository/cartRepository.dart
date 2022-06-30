import 'dart:convert';

import 'httpRepository.dart';

class CartRepository extends HttpRepository {
  late Map<String, dynamic> response;

  static const String cartItemUrl = '/users/shoppers/carts';
  static const String deleteCartItemUrl = '/users/shoppers/carts/remove';

  Future<dynamic> getItemFromCarts() async {
    try {
      response = await super.httpGet(cartItemUrl);
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registItemToCarts(List body) async {
    try {
      response = await super.httpPost(cartItemUrl, json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> patchItemFromCart(int cartId, Map body) async {
    try {
      response =
          await super.httpPatch('$cartItemUrl/$cartId', json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> deleteItemFromCart(List idList) async {
    Map body = {};
    body['id'] = idList;
    try {
      response = await super.httpPost(deleteCartItemUrl, json.encode(body));
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
