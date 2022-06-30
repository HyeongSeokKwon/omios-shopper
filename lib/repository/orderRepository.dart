import 'dart:convert';

import 'httpRepository.dart';

class OrderRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;
  Map body = {};

  Future<dynamic> postOrder(Map<String, dynamic> body) async {
    try {
      response = await super.httpPost("/orders", json.encode(body));

      return response;
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

  Future<dynamic> getOrderHistoryById(int id) async {
    try {
      response = await super.httpGet("/orders/$id");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getOrderHistoryByDate(
      String startDate, String endDate) async {
    Map<String, dynamic> queryString = {};
    try {
      if (startDate.isNotEmpty || endDate.isNotEmpty) {
        queryString['start_date'] = startDate;
        queryString['end_date'] = endDate;
      }
      response = await super.httpGet("/orders", queryString);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getOrderStatistics() async {
    try {
      response = await super.httpGet('/orders/items/statistics');

      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> cancelOrder(int orderId, int itemId) async {
    try {
      body['order_items'] = [itemId];
      response =
          await super.httpPost('/orders/$orderId/cancel', json.encode(body));
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changeShippingAddress(int orderId, Map body) async {
    try {
      response = await super
          .httpPut('orders/$orderId/shipping-address', json.encode(body));
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changeOption(int itemId, int optionId) async {
    try {
      body['option'] = optionId;
      response =
          await super.httpPatch('/orders/items/$itemId', json.encode(body));
      return response;
    } catch (e) {
      throw e;
    }
  }
}
