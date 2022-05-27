import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:get/get.dart';

class Category {
  int id;
  String name;
  Category({required this.id, required this.name});
}

class CategoryController extends GetxController {
  Category mainCategory = Category(id: 1, name: "init");

  HttpRepository httpRepository = HttpRepository();
  late Future<List<Category>> categoryList;
  var subCategoryList;
  Map<String, String> queryParams = {};

  Future<List<dynamic>> getCategory() async {
    var response = await httpRepository
        .httpGet("/products/main-categories")
        .catchError((e) {
      throw e;
    });
    return response['data'];
  }

  Future<List<dynamic>> getSubCategory(int mainCategoryId) async {
    var response = await httpRepository
        .httpGet("/products/main-categories/$mainCategoryId/sub-categories")
        .catchError((e) {
      throw e;
    });
    subCategoryList = response['data'];
    return response['data'];
  }

  void selectMainCategory(Map<String, dynamic> mainCategoryInfo) {
    mainCategory.id = mainCategoryInfo['id'];
    mainCategory.name = mainCategoryInfo['name'];
  }
}
