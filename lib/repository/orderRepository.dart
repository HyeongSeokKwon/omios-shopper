import 'dart:convert';

import 'httpRepository.dart';

class OrderRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;
  Map body = {};

  Future<dynamic> postOrder(Map<String, dynamic> body) async {
    try {
      response = await super.httpPost("/orders", json.encode(body));

      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getOrderHistory() async {
    try {
      response = await super.httpGet("/orders");

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> cancelOrder(int orderId, int itemId) async {
    try {
      body['order_items'] = [itemId];
      response =
          await super.httpPost('/orders/$orderId/cancel', json.encode(body));
      print(response);
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changeShippingAddress(int orderId, Map body) async {
    try {
      response = await super
          .httpPut('orders/$orderId/shipping-address', json.encode(body));
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changeOption(int itemId, int optionId) async {
    try {
      body['option'] = optionId;
      response =
          await super.httpPatch('/orders/items/$itemId', json.encode(body));
    } catch (e) {
      throw e;
    }
  }
}
