// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_cubit.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final int nbCorrect;
  final QuizStatus status;
  final List<Question> questions;

  const QuizState({
    required this.selectedAnswer,
    required this.nbCorrect,
    required this.status,
    required this.questions,
  });

  factory QuizState.initial() {
    return const QuizState(
      selectedAnswer: "",
      nbCorrect: 0,
      status: QuizStatus.initial,
      questions: [],
    );
  }

  QuizState copyWith({
    String? selectedAnswer,
    int? nbCorrect,
    QuizStatus? status,
    List<Question>? questions,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      nbCorrect: nbCorrect ?? this.nbCorrect,
      status: status ?? this.status,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object> get props => [selectedAnswer, nbCorrect, status, questions];

  @override
  bool get stringify => true;

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;
}
