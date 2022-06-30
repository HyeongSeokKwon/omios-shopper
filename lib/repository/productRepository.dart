import 'httpRepository.dart';

class ProductRepository extends HttpRepository {
  static const String productUrl = "/products";
  Future<dynamic> getProductInfo(int id) async {
    Map response;
    try {
      response = await super.httpGet(productUrl + "/$id");
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getProductInfoByIdList(List idList) async {
    Map response;
    try {
      response = await super.httpGet(productUrl, {'id': idList});
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
