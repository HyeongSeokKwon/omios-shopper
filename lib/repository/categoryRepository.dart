import 'httpRepository.dart';

class CategoryRepository extends HttpRepository {
  static const String categoryUrl = "/products/categories";

  Future<dynamic> getCategory() async {
    Map response;
    try {
      response = await super.httpPublicGet(categoryUrl);
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
