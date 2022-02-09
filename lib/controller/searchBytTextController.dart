import 'dart:async';

import 'package:cloth_collection/http/httpService.dart';
import 'package:get/get.dart';

class SearchByTextController extends GetxController {
  HttpService httpservice = HttpService();
  late Map<String, dynamic> searchBoxData;
  List<dynamic> searchData = [];
  bool isSearchButtonClicked = false;
  String? searchText = '';
  String? prevDataLink = "";
  String? nextDataLink = "";
  StreamController streamController = StreamController();

  void searchTextChange(String text) async {
    isSearchButtonClicked = false;
    searchText = text;
    if (text.isNotEmpty) {
      await getSearchBoxResults(text); //글자 바뀔때마다 검색 요청
    }
    update();
  }

  Future<void> getSearchBoxResults(String text) async {
    Map<String, String> queryParams = {};
    queryParams['query'] = text;
    var response = await httpservice.httpGet("product/searchbox/", queryParams);
    searchBoxData = response['data'];
    streamController.add(searchBoxData);

    update();
  }

  Future<void> getSearchResults(String text) async {
    streamController.add(null);
    Map<String, String> queryParams = {};
    queryParams['query'] = text;
    var response = await httpservice
        .httpGet("product/search/", queryParams)
        .catchError((e) {
      throw e;
    });
    searchData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];
    streamController.add(searchData);

    update();
  }

  Future<void> getProducts() async {
    var response;
    Map<String, String> queryParams = {};
    if (nextDataLink != null) {
      var page = "page";
      queryParams['page'] = "${nextDataLink![nextDataLink!.indexOf(page) + 5]}";

      print('query');
      print(queryParams);
      response =
          await httpservice.httpGet("product", queryParams).catchError((e) {
        throw e;
      });
    } else {
      return;
    }

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    searchData = searchData + response['data']['results'];
    streamController.add(searchData);
  }
}
