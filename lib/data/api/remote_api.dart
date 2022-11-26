import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/data/models/requests/question_request.dart';
import 'package:flutter_architecture/data/models/responses/question_response.dart';

class RemoteApi {
  static const String url = "https://opentdb.com/api.php";

  Future<List<QuestionResponse>> getQuestion(QuestionRequest request) async {
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results']);
        if (results.isNotEmpty) {
          return results.map((e) => QuestionResponse.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      throw Failure(
          message: err.response?.statusMessage ?? "Something went wrong");
    } on SocketException catch (err) {
      throw Failure(message: "Please check your connection, error : $err");
    }
  }
}
