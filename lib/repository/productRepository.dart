import 'httpRepository.dart';

class ProductRepository extends HttpRepository {
  Future<dynamic> getProductInfo(int id) async {
    Map response;
    try {
      response = await super.httpGet("/products/$id");
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
