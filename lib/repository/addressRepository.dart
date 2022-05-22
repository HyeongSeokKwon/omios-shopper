import 'dart:convert';

import 'package:cloth_collection/repository/httpRepository.dart';

class AddressRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getDefaultAddress() async {
    int id = await super.getId();

    try {
      response = await super.httpGet("/users/shoppers/$id/addresses/default");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getAddressList() async {
    int id = await super.getId();

    try {
      response = await super.httpGet("/users/shoppers/$id/addresses");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postAddress(Map<String, dynamic> body) async {
    int id = await super.getId();

    try {
      response = await super
          .httpPost("/users/shoppers/$id/addresses", json.encode(body));
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteAddress(int addressId) async {
    int id = await super.getId();

    try {
      response =
          await super.httpDelete("/users/shoppers/$id/addresses/$addressId");
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> patchAddress(int addressId, Map<String, dynamic> body) async {
    int id = await super.getId();
    try {
      response = await super.httpPatch(
          "/users/shoppers/$id/addresses/$addressId", json.encode(body));
      return response;
    } catch (e) {
      throw e;
    }
  }
}
