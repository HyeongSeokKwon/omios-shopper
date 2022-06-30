import 'package:cloth_collection/repository/httpRepository.dart';

class UserRepository extends HttpRepository {
  static const String likeProductUrl = "/users/shoppers/like/products";
  static const String productsUrl = "/products";
  late Map response;

  Future<dynamic> addLike(String productId) async {
    try {
      response = await super.httpPost(likeProductUrl + "/$productId");

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> deleteLike(String productId) async {
    try {
      response = await super.httpDelete(likeProductUrl + "/$productId");
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getAllLikeProducts() async {
    try {
      response = await super.httpGet(productsUrl, {'like': null});
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
