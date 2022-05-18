import 'package:cloth_collection/http/httpService.dart';

class ShopperRepository extends HttpService {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getShopperInfo() async {
    int id = super.getId();
    try {
      response = await super.httpGet('/users/shoppers/$id');
      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
