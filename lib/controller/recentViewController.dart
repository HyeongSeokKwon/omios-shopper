import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/http/httpService.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:get/get.dart';

class RecentViewController extends GetxController {
  var recentViewList = Future.value().obs;
  List<dynamic> recentViewProductList = [];
  DBHelper dbHelper = DBHelper();
  HttpService httpService = HttpService();

  void dataInit() {
    recentViewList.value = getRecentView(dbHelper.db);
  }

  void insertRecentView(int productId) async {
    int listCount = 0;

    for (var i in await recentViewList.value) {
      listCount++;
      if (i['productId'] == productId) {
        deleteRecent(dbHelper.db, productId);
        break;
      } else if (listCount > 14) {
        deleteOldestRecent(dbHelper.db);
        break;
      }
    }

    setRecentView(dbHelper.db, productId);

    update();
  }

  void getRecentViewProduct() async {
    var response;
    recentViewProductList = [];
    recentViewList.value = getRecentView(dbHelper.db);
    for (var i in await recentViewList.value) {
      response = await httpService.httpGet('product/${i['productId']}');
      recentViewProductList.add(response['data']);
    }
  }
}
