import 'package:cloth_collection/repository/httpRepository.dart';

class SearchRepository extends HttpRepository {
  static const String relatedSearchWordsUrl = "/products/related-search-words";
  static const String productUrl = "/products";
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getSearchBox(String text) async {
    queryParams = {};
    queryParams['search_word'] = text;
    try {
      response = await super.httpPublicGet(relatedSearchWordsUrl, queryParams);

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getSearchProducts(String text) async {
    queryParams = {};
    queryParams['search_word'] = text;
    try {
      response = await super.httpGet(productUrl, queryParams);

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
