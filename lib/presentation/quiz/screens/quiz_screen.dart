import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/commons/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/cubit/quiz_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/question.dart';
import '../../commons/widgets/error.dart';
import '../widgets/quiz_questions.dart';
import '../widgets/quiz_results.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF22293E),
      ),
      child: BlocProvider<QuizCubit>(
        create: (context) => QuizCubit(),
        child: SafeArea(
          child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              if (state.questions.isEmpty) {
                context.read<QuizCubit>().getQuestions();
                return const Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: _buildBody(
                      context, state, pageController, state.questions),
                  bottomSheet:
                      state.answered && pageController.positions.isNotEmpty
                          ? bottomSheet(pageController, context)
                          : const SizedBox.shrink(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(PageController pageController, BuildContext context) {
    final currentIndex = pageController.page?.toInt() ?? 0;
    final questions = context.read<QuizCubit>().state.questions;

    return CustomButton(
      title:
          currentIndex + 1 < questions.length ? "Next Question" : "See results",
      onTap: () {
        context.read<QuizCubit>().nextQuestion(questions, currentIndex);
        if (currentIndex + 1 < questions.length) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    QuizState state,
    PageController pageController,
    List<Question> questions,
  ) {
    if (questions.isEmpty) {
      return CustomError(
        message: "No questions found",
        callback: () {},
      );
    }
    return state.status == QuizStatus.complete
        ? QuizResults(state: state, nbQuestions: questions.length)
        : QuizQuestions(
            pageController: pageController,
            state: state,
            questions: questions,
          );
  }
}
