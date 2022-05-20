import 'dart:convert';

import 'package:cloth_collection/http/httpService.dart';

class OrderRepository extends HttpService {
  late Map response;
  late Map<String, dynamic> queryParams;

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

      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
