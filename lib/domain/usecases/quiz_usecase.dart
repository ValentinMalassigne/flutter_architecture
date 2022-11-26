import 'dart:math';

import 'package:flutter_architecture/domain/repository/quiz_repository.dart';

import '../entities/question.dart';

class QuizUseCase {
  final QuizRepository _repository;
  QuizUseCase(this._repository);

  Future<List<Question>> getQuestions() {
    return _repository.getQuestions(
        numQuestions: 5, categoryId: Random().nextInt(24) + 9);
  }
}
