import 'package:cloth_collection/http/httpService.dart';

class CategoryRepository extends HttpService {
  Future<dynamic> getCategory() async {
    Map response;
    try {
      response = await super.httpPublicGet("/products/categories");
      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getMainCategoryBySubCategoryId(int subCategoryId) async {
    List<dynamic> categoryData = await getCategory();

    for (var mainValue in categoryData) {
      for (var subValue in mainValue['sub_categories']) {
        if (subValue['id'] == subCategoryId) {
          return mainValue;
        }
      }
    }
    return -1;
  }
}
