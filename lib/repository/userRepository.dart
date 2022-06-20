import 'package:cloth_collection/repository/httpRepository.dart';

class UserRepository extends HttpRepository {
  late Map response;

  Future<dynamic> addLike(String productId) async {
    try {
      response =
          await super.httpPost("/users/shoppers/like/products/$productId");

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> deleteLike(String productId) async {
    try {
      response =
          await super.httpDelete("/users/shoppers/like/products/$productId");
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getAllLikeProducts() async {
    try {
      response = await super.httpGet("/products", {'like': null});
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
