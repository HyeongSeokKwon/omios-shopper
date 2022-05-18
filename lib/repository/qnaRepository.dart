import 'dart:convert';

import 'package:cloth_collection/http/httpService.dart';

class QnaRepository extends HttpService {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getQnaList(int productId) async {
    try {
      response =
          await super.httpPublicGet("/products/$productId/question-answers");
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getQuestionClassification() async {
    try {
      response =
          await super.httpGet("/products/question-answers/classifications");

      return response['data'];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postQuestion(int productId, Map<String, dynamic> body) async {
    try {
      response = await super
          .httpPost("/products/$productId/question-answers", json.encode(body));

      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
