import 'package:cloth_collection/repository/httpRepository.dart';

class UserRepository extends HttpRepository {
  late Map response;

  Future<dynamic> addLike(String productId) async {
    int userId = await super.getId();

    try {
      response =
          await super.httpPost("/users/shoppers/$userId/like/$productId");
      print('repository');
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
}
