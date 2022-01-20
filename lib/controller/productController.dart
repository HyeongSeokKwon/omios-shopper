import 'package:cloth_collection/http/httpService.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SearchOption {
  List<int> color;
  RangeValues priceRange;

  SearchOption({required this.color, required this.priceRange});
}

class ProductController extends GetxController {
  HttpService httpservice = HttpService();
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

  Map<String, String> queryParams = {};

  Future<dynamic> initGetProducts() async {
    var response;
    queryParams = {};
    queryParams['main_category'] = '$mainCategoryId';
    if (subCategoryId != 0) {
      queryParams['sub_category'] = '$subCategoryId';
    }
    print(Uri.http("deepy", "product", queryParams));
    response =
        await httpservice.httpGet("product", queryParams).catchError((e) {
      throw e;
    });

    productData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];

    update();
    return response['data']['results'];
  }

  Future<void> getProducts() async {
    var response;
    if (nextDataLink != null) {
      var page = "page";
      queryParams['page'] = "${nextDataLink![nextDataLink!.indexOf(page) + 5]}";
      print(Uri.http("deepy", "product", queryParams));
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

  Future<void> searchClicked() async {
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

    response =
        await httpservice.httpGet("product", queryParams).catchError((e) {
      throw e;
    });

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = response['data']['results'];
    update();
  }
}
