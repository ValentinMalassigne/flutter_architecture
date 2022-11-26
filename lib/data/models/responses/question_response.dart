// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/domain/entities/question.dart';

class QuestionResponse extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionResponse({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  @override
  List<Object> get props {
    return [
      category,
      type,
      difficulty,
      question,
      correctAnswer,
      incorrectAnswers,
    ];
  }

//.. returns a list while . returns a void
  Question toEntity() {
    return Question(
      category: category,
      difficulty: difficulty,
      question: question,
      correctAnswer: correctAnswer,
      answers: incorrectAnswers
        ..add(correctAnswer)
        ..shuffle(),
    );
  }

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
      category: map['category'] ?? '',
      type: map['type'] ?? '',
      difficulty: map['difficulty'] ?? '',
      question: map['question'] ?? '',
      correctAnswer: map['correct_answer'] ?? '',
      incorrectAnswers: List<String>.from(map['incorrect_answers'] ?? []),
    );
  }
}
