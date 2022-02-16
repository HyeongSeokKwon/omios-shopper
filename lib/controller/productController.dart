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

  String? prevDataLink = "";
  String? nextDataLink = "";

  int sortType = NOTSELECT;
  int startPrice = 0;
  double endPrice = 100;
  RangeValues priceRange = RangeValues(0, 100);

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

  Map<String, dynamic> queryParams = {};

  Future<dynamic> initGetProducts() async {
    var response;
    queryParams = {};
    queryParams['main_category'] = '$mainCategoryId';
    if (subCategoryId != NOTSELECT) {
      queryParams['sub_category'] = '$subCategoryId';
    }
    response =
        await httpservice.httpGet("product", queryParams).catchError((e) {
      throw e;
    });

    endPrice = (response["data"]["max_price"] / 1000) + 1;
    productData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];

    priceRange = RangeValues(0, (response["data"]["max_price"] / 1000) + 1);
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
          await httpservice.httpGet("product", queryParams).catchError((e) {
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
    priceRange = RangeValues(0, 100);
    update(["priceOption"]);
  }

  void priceRangeChange(RangeValues changeRange) {
    priceRange = changeRange;
    update(["priceOption"]);
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

    queryParams['main_category'] = '$mainCategoryId';
    queryParams['minprice'] = '${startPrice * 1000}';
    queryParams['maxprice'] = '${endPrice * 1000}';

    queryParams['sort'] = sortTypesUrl[sortType];

    if (subCategoryId != NOTSELECT) {
      queryParams['sub_category'] = '$subCategoryId';
    }

    queryParams['color'] = List.generate(
        selectedColor.length, (index) => selectedColor[index].toString());

    response =
        await httpservice.httpGet("product", queryParams).catchError((e) {
      throw e;
    });

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = response['data']['results'];

    update();
  }

  Future<void> sortClicked(int index) async {
    var response;

    queryParams = {};
    sortType = index;

    queryParams['main_category'] = '$mainCategoryId';
    if (subCategoryId != NOTSELECT) {
      queryParams['sub_category'] = '$subCategoryId';
    }

    switch (index) {
      case CREATED:
        queryParams['sort'] = 'created';
        break;
      case PRICEASC:
        queryParams['sort'] = 'price_asc';
        break;
      case PRICEDSC:
        queryParams['sort'] = 'price_dsc';
        break;
      default:
    }

    response =
        await httpservice.httpGet("product", queryParams).catchError((e) {
      throw e;
    });

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = response['data']['results'];
    update();
  }

  void initFilter() {
    sortType = NOTSELECT;
    selectedColor = [];
    priceRange = RangeValues(0, 100);
  }

  bool isApplyedFilter() {
    if (sortType != NOTSELECT ||
        selectedColor.isNotEmpty ||
        endPrice != priceRange.end) {
      return true;
    } else {
      return false;
    }
  }
}
