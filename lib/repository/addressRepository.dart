import 'dart:convert';

import 'package:cloth_collection/repository/httpRepository.dart';

class AddressRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getDefaultAddress() async {
    try {
      response = await super.httpGet("/users/shoppers/addresses/default");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getAddressList() async {
    try {
      response = await super.httpGet("/users/shoppers/addresses");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postAddress(Map<String, dynamic> body) async {
    try {
      response =
          await super.httpPost("/users/shoppers/addresses", json.encode(body));
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteAddress(int addressId) async {
    try {
      response = await super.httpDelete("/users/shoppers/addresses/$addressId");
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> patchAddress(int addressId, Map<String, dynamic> body) async {
    try {
      response = await super
          .httpPatch("/users/shoppers/addresses/$addressId", json.encode(body));
      return response;
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
}
