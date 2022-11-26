// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/data/api/remote_api.dart';
import 'package:flutter_architecture/data/repository/quiz_repository_impl.dart';
import 'package:flutter_architecture/domain/usecases/quiz_usecase.dart';

import '../../../../domain/entities/question.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizState.initial());

  final _useCase = QuizUseCase(QuizRepositoryImpl(RemoteApi()));

  void getQuestions() async {
    emit(state.copyWith(questions: await _useCase.getQuestions()));
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      emit(state.copyWith(
        selectedAnswer: answer,
        nbCorrect: state.nbCorrect + 1,
        status: QuizStatus.correct,
      ));
    } else {
      emit(state.copyWith(
        selectedAnswer: answer,
        status: QuizStatus.incorrect,
      ));
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    emit(state.copyWith(
      selectedAnswer: "",
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
    ));
  }

  void reset() {
    emit(QuizState.initial());
  }
}
