import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:get/get.dart';

class RecentViewController extends GetxController {
  var recentViewList = Future.value();
  List<dynamic> recentViewProductList = [];
  List<dynamic> selectProductList = [];
  DBHelper dbHelper = DBHelper();
  HttpRepository httpRepository = HttpRepository();
  bool edit = false;

  void dataInit() {
    recentViewList = getRecentView(dbHelper.db);
  }

  void insertRecentView(int productId) async {
    int listCount = 0;

    for (var i in await recentViewList) {
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

  Future<dynamic> getRecentViewProduct() async {
    var response;
    List idList = [];
    recentViewProductList = [];

    recentViewList = getRecentView(dbHelper.db);
    for (var i in await recentViewList) {
      idList.add(i['productId'].toString());
    }
    try {
      response = await httpRepository.httpGet('/products', {'id': idList});
      recentViewProductList = response["data"]['results'];
    } catch (e) {
      throw (e);
    }

    return recentViewProductList;
  }

  void editProductsClicked() {
    edit = !edit;
    update();
  }

  bool isSelected(int index) {
    int productId = recentViewProductList[index]['id'];
    if (selectProductList.contains(productId)) {
      return true;
    } else {
      return false;
    }
  }

  void productClicked(int index) {
    int productId = recentViewProductList[index]['id'];

    if (isSelected(index)) {
      selectProductList.remove(productId);
    } else {
      selectProductList.add(productId);
    }

    update();
    return;
  }

  void selectAllProduct() {
    if (recentViewProductList.length != selectProductList.length) {
      selectProductList.clear();
      for (var i in recentViewProductList) {
        selectProductList.add(i['id']);
      }
    } else {
      selectProductList = [];
    }

    update();
  }

  void deleteProduct() {
    for (var i in selectProductList) {
      deleteRecent(dbHelper.db, i);
      recentViewProductList.removeWhere((element) => element['id'] == i);
    }

    update();
  }
}
