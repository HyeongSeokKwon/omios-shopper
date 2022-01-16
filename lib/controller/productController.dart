import 'package:cloth_collection/http/httpService.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SearchOption {
  List<int> color;
  RangeValues priceRange;

  SearchOption({required this.color, required this.priceRange});
}

class ProductController extends GetxController {
  HttpService httpService = HttpService();
  List<dynamic> productData = [];

  String? prevDataLink = "";
  String? nextDataLink = "";

  double startPrice = 1.0;
  double endPrice = 99999.0;
  RangeValues priceRange = RangeValues(0.0, 100000.0);
  List<int> selectedColor = [];
  int optionMode = 0;
  late SearchOption searchOption;
  late int subCategoryId;

  bool isLoading = false;
  Map<String, String> queryParams = {};

  Future<void> initGetProducts(int mainCategoryId, int subCategoryID) async {
    var response;
    isLoading = true;
    subCategoryId = subCategoryID;

    queryParams['main_category'] = '$mainCategoryId';
    if (subCategoryId != 0) {
      queryParams['sub_category'] = '$subCategoryId';
    }
    response = await httpService.httpGet("product", queryParams);
    productData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];
    isLoading = false;

    print(productData);
    update();
  }

  void getMainCategoryProducts(int mainCategoryId) {
    queryParams = {};
    queryParams['main_category'] = '$mainCategoryId';

    getProducts();
  }

  void getSubCategoryProducts(int mainCategoryId, int subCategoryId) {
    queryParams = {};
    queryParams['main_category'] = '$mainCategoryId';
    queryParams['sub_category'] = '$subCategoryId';

    getProducts();
  }

  void getProducts() async {
    var response;
    isLoading = true;
    if (nextDataLink != null) {
      queryParams['page'] = nextDataLink!.substring(nextDataLink!.length - 1);
      response = await httpService.httpGet("product", queryParams);
      print(response);
    } else {
      return;
    }

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = productData + response['data']['results'];

    isLoading = false;
    update();
  }

  void refreshColorOption() {
    selectedColor = [];
    update();
  }

  void refreshPriceOption() {
    priceRange = RangeValues(0.0, 100000.0);
    update(["priceOption"]);
  }

  void priceRangeChange(RangeValues changeRange) {
    priceRange = changeRange;
    update(["priceOption"]);
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

  void searchClicked(int mainCategoryId) async {
    var response;
    searchOption = SearchOption(color: selectedColor, priceRange: priceRange);
    int startPrice = searchOption.priceRange.start.toInt();
    int endPrice = searchOption.priceRange.end.toInt();
    productData = [];
    queryParams = {};

    queryParams['main_category'] = '$mainCategoryId';
    queryParams['minprice'] = '$startPrice';
    queryParams['maxprice'] = '$endPrice';

    if (subCategoryId != 0) {
      queryParams['sub_category'] = '$subCategoryId';
    }

    response = await httpService.httpGet("product", queryParams);
    print(response);
    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = productData + response['data']['results'];
    update();
  }
}
