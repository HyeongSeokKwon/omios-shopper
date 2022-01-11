import 'package:cloth_collection/http/httpService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category {
  int id;
  String name;
  Category({required this.id, required this.name});
}

class CategoryController extends GetxController {
  double startPrice = 1.0;
  double endPrice = 99999.0;
  RangeValues priceRange = RangeValues(0.0, 100000.0);
  List<int> selectedColor = [];
  int optionMode = 0;
  Category mainCategory = Category(id: 1, name: "init");

  HttpService httpService = HttpService();
  late Future<List<Category>> categoryList;

  Future<List<dynamic>> getCategory() async {
    var response = await httpService.httpGet("/category/");
    return response['data'];
  }

  Future<List<dynamic>> getSubCategory(int mainCategoryId) async {
    var response =
        await httpService.httpGet("/category/$mainCategoryId/subcategory/");
    print("getsubCategory");
    print(response['data']);

    var responses = await httpService.httpGet("/product/");
    print("mainCategory");
    print(responses);
    // print(responses);

    return response['data']['subcategory'];
  }

  void selectMainCategory(Map<String, dynamic> mainCategoryInfo) {
    mainCategory.id = mainCategoryInfo['id'];
    mainCategory.name = mainCategoryInfo['name'];
  }

  void refreshColorOption() {
    selectedColor = [];
    update();
  }

  void refreshPriceOption() {
    priceRange = RangeValues(0.0, 100000.0);
    update();
  }

  void priceRangeChange(RangeValues changeRange) {
    priceRange = changeRange;
    update();
  }

  bool isColorSelected(int colorIndex) {
    if (selectedColor.contains(colorIndex)) {
      return true;
    }
    return false;
  }

  void selectColor(int colorIndex) {
    if (selectedColor.contains(colorIndex)) {
      selectedColor.remove(colorIndex);
      update();
    } else {
      selectedColor.add(colorIndex);
      update();
    }
    print(selectedColor);
  }
}
