import 'package:cloth_collection/http/httpService.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SearchOption {
  List<int> color;
  RangeValues priceRange;

  SearchOption({required this.color, required this.priceRange});
}

class ProductController extends GetxController {
  static const int NOTSELECT = 0;
  static const int CREATED = 0;
  static const int PRICEASC = 1;
  static const int PRICEDSC = 2;

  HttpService httpservice = HttpService();
  List<dynamic> productData = [];
  List<dynamic> colorData = [];

  String? prevDataLink = "";
  String? nextDataLink = "";

  int sortType = NOTSELECT;
  int startPrice = 0;
  double endPrice = 100;
  RangeValues priceRange = RangeValues(0, 100);
  RangeValues initPriceRange = RangeValues(0, 100);
  List<int> selectedColor = [];
  List<String> sortTypes = ["최신순", "가격 낮은순", "가격 높은순", "리뷰 많은순", "추천순"];
  List<String> sortTypesUrl = [
    'created',
    'price_asc',
    'price_dsc',
    'price_dsc',
    'price_dsc'
  ];

  late SearchOption searchOption;
  late int subCategoryId;
  late int mainCategoryId;
  bool showMoveToUpBtn = false;

  Map<String, dynamic> queryParams = {};

  void showMoveToUp(double scrollControllerOffset) {
    if (scrollControllerOffset > 500.0) {
      showMoveToUpBtn = true;
    } else {
      showMoveToUpBtn = false;
    }
    update();
  }

  Future<dynamic> initGetProducts() async {
    var response;
    queryParams = {};
    if (subCategoryId != NOTSELECT) {
      queryParams['sub_category'] = '$subCategoryId';
    } else {
      queryParams['main_category'] = '$mainCategoryId';
    }
    response =
        await httpservice.httpGet("/products", queryParams).catchError((e) {
      throw e;
    });

    endPrice = (response["data"]["max_price"] / 1000) + 1;
    productData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];

    priceRange = RangeValues(0, (response["data"]["max_price"] / 1000) + 1);
    initPriceRange = priceRange;

    endPrice = ((response["data"]["max_price"] / 1000) + 1);

    update();
    return response['data']['results'];
  }

  Future<void> getProducts() async {
    var response;
    if (nextDataLink != null) {
      var page = "page";
      queryParams['page'] = "${nextDataLink![nextDataLink!.indexOf(page) + 5]}";
      response =
          await httpservice.httpGet("/products", queryParams).catchError((e) {
        throw e;
      });
    } else {
      return;
    }

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = productData + response['data']['results'];
    update();
  }

  void refreshColorOption() {
    selectedColor = [];
    update();
  }

  void refreshPriceOption() {
    priceRange = initPriceRange;
    update();
  }

  void priceRangeChange(RangeValues changeRange) {
    priceRange = changeRange;
    update();
  }

  bool isColorSelected(int colorIndex) {
    if (selectedColor.contains(colorIndex + 1)) {
      return true;
    }
    return false;
  }

  void selectColor(int colorIndex) {
    if (selectedColor.contains(colorIndex + 1)) {
      selectedColor.remove(colorIndex + 1);
      update();
    } else {
      selectedColor.add(colorIndex + 1);
      update();
    }
  }

  Future<void> searchClicked() async {
    var response;
    searchOption = SearchOption(color: selectedColor, priceRange: priceRange);
    int startPrice = searchOption.priceRange.start.toInt();
    int endPrice = searchOption.priceRange.end.toInt();
    queryParams = {};

    queryParams['min_price'] = '${startPrice * 1000}';
    queryParams['max_price'] = '${endPrice * 1000}';

    queryParams['sort'] = sortTypesUrl[sortType];

    if (subCategoryId != NOTSELECT) {
      queryParams['sub_category'] = '$subCategoryId';
    } else {
      queryParams['main_category'] = '$mainCategoryId';
    }

    queryParams['color'] = List.generate(
        selectedColor.length, (index) => selectedColor[index].toString());

    response =
        await httpservice.httpGet("/products", queryParams).catchError((e) {
      throw e;
    });

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = response['data']['results'];

    update();
  }

  Future<List<dynamic>> getColorImage() async {
    var response = await httpservice.httpGet("/products/colors");
    colorData = response['data'];
    return response['data'];
  }

  void initFilter(String type) {
    switch (type) {
      case "색상":
        refreshColorOption();
        break;
      case "가격":
        refreshPriceOption();
        break;
      case "전체":
        refreshColorOption();
        refreshPriceOption();
        sortType = NOTSELECT;
        break;
    }
    update();
  }

  bool isSortApplyed() {
    if (sortType == NOTSELECT) {
      return false;
    }
    return true;
  }

  bool isFilterApplyed(String type) {
    switch (type) {
      case "가격":
        if (priceRange != initPriceRange) {
          return true;
        }
        return false;

      case "색상":
        if (selectedColor.isNotEmpty) {
          return true;
        }
        return false;
    }
    return false;
  }

  bool isApplyedFilter() {
    if (sortType != NOTSELECT ||
        selectedColor.isNotEmpty ||
        priceRange != initPriceRange) {
      return true;
    } else {
      return false;
    }
  }
}
