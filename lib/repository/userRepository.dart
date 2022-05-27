import 'package:cloth_collection/repository/httpRepository.dart';

class UserRepository extends HttpRepository {
  late Map response;

  Future<dynamic> addLike(String productId) async {
    int userId = await super.getId();

    try {
      response =
          await super.httpPost("/users/shoppers/$userId/like/$productId");

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> deleteLike(String productId) async {
    int userId = await super.getId();

    try {
      response =
          await super.httpDelete("/users/shoppers/$userId/like/$productId");
      print(response);
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
