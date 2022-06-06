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

  Future<dynamic> getPointHistory() async {
    try {
      response = await super.httpGet("/users/shoppers/point-histories");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
