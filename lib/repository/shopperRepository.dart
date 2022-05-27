import 'package:cloth_collection/repository/httpRepository.dart';

class ShopperRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getShopperInfo() async {
    int id = await super.getId();
    try {
      response = await super.httpGet('/users/shoppers/$id');
      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPointHistory() async {
    int id = await super.getId();
    try {
      response = await super.httpGet("/users/shoppers/$id/point-histories");
      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
