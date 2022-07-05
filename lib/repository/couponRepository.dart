import 'dart:convert';

import 'httpRepository.dart';

class CouponRepository extends HttpRepository {
  static const String ownCouponUrl = "/users/shoppers/coupons";
  static const String canGetCouponUrl = "/coupons";
  late Map response;
  late Map<String, dynamic> queryParams;
  Map body = {};

  Future<dynamic> getOwnCoupon() async {
    try {
      response = await super.httpGet(ownCouponUrl);
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getCoupon(int id) async {
    try {
      body['coupon'] = id;
      response = await super.httpPost(ownCouponUrl, json.encode(body));
      print(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getCanGetCoupon() async {
    try {
      response = await super.httpGet(canGetCouponUrl);
      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
