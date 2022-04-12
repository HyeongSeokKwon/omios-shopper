import 'package:cloth_collection/http/httpService.dart';

class SearchRepository extends HttpService {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getSearchBox(String text) async {
    queryParams = {};
    queryParams['search_word'] = text;
    try {
      response = await super
          .httpPublicGet("/products/related-search-words", queryParams);

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getSearchProducts(String text) async {
    queryParams = {};
    queryParams['search_word'] = text;
    try {
      response = await super.httpGet("/products", queryParams);

      return response['data'];
    } catch (e) {
      throw (e);
    }
  }
}
