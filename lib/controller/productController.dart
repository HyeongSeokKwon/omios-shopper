import 'package:cloth_collection/http/httpService.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  HttpService httpService = HttpService();
  List<dynamic> productData = [];
  String? prevDataLink = "first";
  String? nextDataLink = "first";
  bool isLoading = false;

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
    if (prevDataLink == "first" && nextDataLink == "first") {
      response = await httpService.httpGet(url);
      print(response['data']);
    } else if (nextDataLink != null) {
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
