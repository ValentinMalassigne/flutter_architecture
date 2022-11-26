import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/commons/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodel/cubit/quiz_cubit.dart';

class QuizResults extends StatelessWidget {
  const QuizResults(
      {super.key, required this.state, required this.nbQuestions});
  final QuizState state;
  final int nbQuestions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.nbCorrect}/$nbQuestions',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40.0),
        CustomButton(
            title: "New Quiz",
            onTap: () {
              context.read<QuizCubit>().reset();
            })
      ],
    );
  }
}
