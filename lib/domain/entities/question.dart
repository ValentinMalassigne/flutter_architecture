import 'package:equatable/equatable.dart';

//incorrect_answers is replaced by answers that include all answers

class Question extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> answers;

  const Question({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  @override
  List<Object> get props {
    return [
      category,
      difficulty,
      question,
      correctAnswer,
      answers,
    ];
  }
}
