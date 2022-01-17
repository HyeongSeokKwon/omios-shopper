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
  int sortType = 0;
  List<String> sortTypes = ["최신순", "가격 낮은순", "가격 높은순", "리뷰 많은순", "추천순"];

  late SearchOption searchOption;
  late int subCategoryId;
  late int mainCategoryId;

  bool isLoading = false;
  Map<String, String> queryParams = {};

  Future<void> initGetProducts(int mainCategoryID, int subCategoryID) async {
    var response;
    isLoading = true;
    subCategoryId = subCategoryID;
    mainCategoryId = mainCategoryID;
    queryParams = {};
    queryParams['main_category'] = '$mainCategoryId';
    if (subCategoryId != 0) {
      queryParams['sub_category'] = '$subCategoryId';
    }

    response = await httpService.httpGet("product", queryParams);
    productData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];
    isLoading = false;

    update();
  }

  void getProducts() async {
    var response;
    isLoading = true;
    if (nextDataLink != null) {
      var page = "page";
      queryParams['page'] = "${nextDataLink![nextDataLink!.indexOf(page) + 5]}";
      response = await httpService.httpGet("product", queryParams);
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
  }

  void searchClicked() async {
    var response;
    searchOption = SearchOption(color: selectedColor, priceRange: priceRange);
    int startPrice = searchOption.priceRange.start.toInt();
    int endPrice = searchOption.priceRange.end.toInt();
    queryParams = {};

    queryParams['main_category'] = '$mainCategoryId';
    queryParams['minprice'] = '$startPrice';
    queryParams['maxprice'] = '$endPrice';
    queryParams['sort'] = 'price_asc';

    if (subCategoryId != 0) {
      queryParams['sub_category'] = '$subCategoryId';
    }

    isLoading = true;
    response = await httpService.httpGet("product", queryParams);
    isLoading = false;

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = response['data']['results'];
    update();
  }

  void sortClicked(int index) async {
    var response;
    queryParams = {};
    sortType = index;

    queryParams['main_category'] = '$mainCategoryId';
    if (subCategoryId != 0) {
      queryParams['sub_category'] = '$subCategoryId';
    }
    switch (index) {
      case 0:
        queryParams['sort'] = 'created';
        break;
      case 1:
        queryParams['sort'] = 'price_asc';
        break;
      case 2:
        queryParams['sort'] = 'price_dsc';
        break;
      default:
    }

    isLoading = true;
    response = await httpService.httpGet("product", queryParams);
    isLoading = false;

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = response['data']['results'];
    update();
  }
}
