import 'package:equatable/equatable.dart';

class QuestionRequest extends Equatable {
  final String type;
  final int amount;
  final int category;

  const QuestionRequest({
    required this.type,
    required this.amount,
    required this.category,
  });

  @override
  List<Object> get props => [type, amount, category];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'amount': amount,
      'category': category,
    };
  }
}
