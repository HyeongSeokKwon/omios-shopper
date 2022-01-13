import 'package:cloth_collection/http/httpService.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  HttpService httpService = HttpService();
  List<dynamic> productData = [];

  String? prevDataLink = "";
  String? nextDataLink = "";

  bool isLoading = false;

  void initGetProducts(int mainCategoryId, int subCategoryId) async {
    var response;
    isLoading = true;
    if (subCategoryId == 0) {
      response =
          await httpService.httpGet("/product/?main_category=$mainCategoryId");
    } else {
      response = await httpService.httpGet(
          "/product/?main_category=$mainCategoryId&sub_category=$subCategoryId");
    }
    productData = response["data"]["results"];
    prevDataLink = response["data"]["previous"];
    nextDataLink = response["data"]["next"];
    isLoading = false;
    update();
  }

  void getMainCategoryProducts(int mainCategoryId) {
    String url = "/product/?main_category=$mainCategoryId";
    getProducts(url);
  }

  void getSubCategoryProducts(int mainCategoryId, int subCategoryId) {
    String url =
        "/product/?main_category=$mainCategoryId&sub_category=$subCategoryId";
    getProducts(url);
  }

  void getProducts(String url) async {
    var response;
    isLoading = true;
    if (nextDataLink != null) {
      response = await httpService.httpGet(nextDataLink!.substring(12));
      print(response['data']);
    } else {
      return;
    }

    prevDataLink = response['data']['previous'];
    nextDataLink = response['data']['next'];
    productData = productData + response['data']['results'];

    isLoading = false;
    update();
  }
}
