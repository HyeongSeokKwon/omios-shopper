import 'dart:convert';

import 'package:cloth_collection/repository/httpRepository.dart';

class QnaRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getQnaList(int productId) async {
    final String getQnaListUrl = "/products/$productId/question-answers";

    try {
      response = await super.httpPublicGet(getQnaListUrl);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getQuestionClassification() async {
    final String getQuestionClassificationUrl =
        "/products/question-answers/classifications";
    try {
      response = await super.httpGet(getQuestionClassificationUrl);

      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postQuestion(int productId, Map<String, dynamic> body) async {
    final String registQuestionUrl = "/products/$productId/question-answers";
    try {
      response = await super.httpPost(registQuestionUrl, json.encode(body));

      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
