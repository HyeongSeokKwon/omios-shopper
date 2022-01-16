import 'package:cloth_collection/http/httpService.dart';
import 'package:get/get.dart';

class Category {
  int id;
  String name;
  Category({required this.id, required this.name});
}

class CategoryController extends GetxController {
  Category mainCategory = Category(id: 1, name: "init");

  HttpService httpService = HttpService();
  late Future<List<Category>> categoryList;
  Map<String, String> queryParams = {};

  Future<List<dynamic>> getCategory() async {
    var response = await httpService.httpGet("product/main-category");
    print(response);
    return response['data'];
  }

  Future<List<dynamic>> getSubCategory(int mainCategoryId) async {
    var response = await httpService
        .httpGet("product/main-category/$mainCategoryId/sub-category");

    return response['data']['sub_category'];
  }

  Future<List<dynamic>> getColorImage() async {
    var response = await httpService.httpGet("product/color");

    return response['data'];
  }

  void selectMainCategory(Map<String, dynamic> mainCategoryInfo) {
    mainCategory.id = mainCategoryInfo['id'];
    mainCategory.name = mainCategoryInfo['name'];
  }
}
