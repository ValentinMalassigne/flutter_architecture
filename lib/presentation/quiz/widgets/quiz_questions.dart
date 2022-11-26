import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_character_entities/html_character_entities.dart';

import '../../../domain/entities/question.dart';
import '../viewmodel/cubit/quiz_cubit.dart';
import 'answer_card.dart';

class QuizQuestions extends StatelessWidget {
  const QuizQuestions(
      {super.key,
      required this.pageController,
      required this.state,
      required this.questions});
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xff2E415A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  HtmlCharacterEntities.decode(question.category),
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 5),
                  child: Text(
                    '${index + 1}/${questions.length}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: LinearProgressIndicator(
                value: index / questions.length,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xffE6812F),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Center(
                child: Text(
                  HtmlCharacterEntities.decode(question.question),
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4),
                itemCount: question.answers.length,
                itemBuilder: ((context, index) {
                  final answer = question.answers[index];
                  return AnswerCard(
                    answer: answer,
                    isSelected: answer == state.selectedAnswer,
                    isCorrect: answer == question.correctAnswer,
                    isDisplayingAnswer: state.answered,
                    onTap: () => context
                        .read<QuizCubit>()
                        .submitAnswer(question, answer),
                  );
                }),
              ),
            )
          ],
        );
      },
    );
  }
}
