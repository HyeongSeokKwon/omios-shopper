import 'package:cloth_collection/database/db.dart';
import 'package:get/get.dart';

class RecentViewController extends GetxController {
  var recentViewList = Future.value().obs;

  void dataInit(DBHelper _dbHelper) {
    recentViewList.value = getRecentView(_dbHelper.db);
  }

  void insertRecentView(String productCode, DBHelper _dbHelper) async {
    int listCount = 0;

    for (var i in await recentViewList.value) {
      listCount++;
      if (i['productCode'] == productCode) {
        deleteRecent(_dbHelper.db, productCode);
        break;
      } else if (listCount > 14) {
        deleteOldestRecent(_dbHelper.db);
        break;
      }
    }

    setRecentView(_dbHelper.db, productCode);
    update();
  }
}
