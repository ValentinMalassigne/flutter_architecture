import 'package:flutter_architecture/data/api/remote_api.dart';
import 'package:flutter_architecture/data/models/requests/question_request.dart';
import 'package:flutter_architecture/domain/entities/question.dart';
import 'package:flutter_architecture/domain/repository/quiz_repository.dart';

class QuizRepositoryImpl extends QuizRepository {
  final RemoteApi _remoteApi;

  QuizRepositoryImpl(this._remoteApi);

  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId}) {
    return _remoteApi
        .getQuestion(QuestionRequest(
            type: "multiple", amount: numQuestions, category: categoryId))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
