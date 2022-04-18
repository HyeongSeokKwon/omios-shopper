import 'package:cloth_collection/http/httpService.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserRepository extends HttpService {
  late Map response;

  Future<dynamic> addLike(String productId) async {
    int userId = Jwt.parseJwt(HttpService.accessToken)['user_id'];

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
    int userId = Jwt.parseJwt(HttpService.accessToken)['user_id'];

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
