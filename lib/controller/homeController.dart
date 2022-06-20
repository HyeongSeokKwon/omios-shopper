import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  final int home = 0;
  final int category = 1;
  final int chat = 2;
  final int mypage = 3;

  HttpRepository httpRepository = HttpRepository();

  int currentIndex = 0;

  Future<dynamic> getTodaysProducts() async {
    Map<String, String> queryParams = {};
    queryParams['sub_category'] = "6";
    var response =
        await httpRepository.httpGet("/products", queryParams).catchError((e) {
      throw e;
    });
    return response['data']['results'];
  }
}
