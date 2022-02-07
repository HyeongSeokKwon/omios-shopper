import 'package:cloth_collection/http/httpService.dart';
import 'package:get/get.dart';

class SearchByTextController extends GetxController {
  HttpService httpservice = HttpService();
  late Map<String, dynamic> searchBoxData;
  List<dynamic> searchData = [];
  bool isSearchButtonClicked = false;
  late Map<String, String> queryParams;
  String? prevDataLink = "";
  String? nextDataLink = "";

  Future<dynamic> getSearchBoxResults(String text) async {
    Map<String, String> queryParams = {};
    queryParams['query'] = text;
    var response = await httpservice.httpGet("product/searchbox/", queryParams);
    searchBoxData = response['data'];
    print(response['data']);
    update();
    return response['data'];
  }

  Future<dynamic> getSearchResults(String text) async {
    Map<String, String> queryParams = {};
    queryParams['query'] = text;
    var response = await httpservice.httpGet("product/search/", queryParams);
    searchData = response['data'];
    print(response['data']);
    update();
    return response['data'];
  }

  Future<dynamic> initGetProducts(String text) async {
    var response;
    queryParams = {};
    queryParams['query'] = text;
    response = await httpservice
        .httpGet("product/search/", queryParams)
        .catchError((e) {
      throw e;
    });

    searchData = response["data"]["results"];
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
    searchData = searchData + response['data']['results'];
    update();
  }
}
