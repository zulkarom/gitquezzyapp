import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_ta_plus/features/quiz/individual/bloc/individual_quiz_bloc.dart';
import 'package:flutter_ta_plus/features/quiz/individual/controller/individual_quiz_controller.dart';
import 'package:flutter_ta_plus/features/quiz/widgets/question_widget.dart';
import '../../../../core/constant/app_dimensions.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/show_snackbar.dart';
import '../../../reusable/widgets/custom_app_bar.dart';
import '../../../reusable/widgets/custom_icon_button.dart';
import '../../../reusable/widgets/custom_snack_bar.dart';

class IndividualQuizScreen extends StatefulWidget {
  const IndividualQuizScreen({super.key});

  @override
  State<IndividualQuizScreen> createState() => _IndividualQuizScreenState();
}

class _IndividualQuizScreenState extends State<IndividualQuizScreen> {
  //define the datas
  // List<Question> questionList = getQuestions();
  bool _initialized = false;
  late IndividualQuizController _individualQuizController;
  late SubjectItem subjectItem;
  late LevelItem levelItem;
  late TopicItem topicItem;
  late String answerDocId;
  late Map? data;
  @override
  void didChangeDependencies() {
    if (!_initialized) {
      final data = ModalRoute.of(context)!.settings.arguments as Map;
      subjectItem = data["subjectItem"];
      levelItem = data["levelItem"];
      topicItem = data["topicItem"];
      answerDocId = data["answer_doc_id"];

      _individualQuizController = IndividualQuizController(context: context);
      _individualQuizController.init();
      _initialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<IndividualQuizBloc, IndividualQuizState>(
        builder: (context, state) {
          return Scaffold(
              body: Column(
            children: [
              CustomAppBar(
                title: AppLocalizations.of(context)!.question,
                leading: [
                  Center(
                    child: CustomIconButton(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: AppDimension().kTwentyScreenPixel,
                        color: Theme.of(context)
                            .appBarTheme
                            .actionsIconTheme!
                            .color,
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<IndividualQuizBloc, IndividualQuizState>(
                builder: (context, state) {
                  if (state is DoneLoadingMyQuestionsStates ||
                      state is SelectedAnswerSet ||
                      state is NextQuestionSet) {
                    return Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Column(
                                  children: [
                                    // Text(
                                    //   'Simple Quiz App',
                                    //   style: Theme.of(context).textTheme.headline5!.copyWith(
                                    //         fontWeight: FontWeight.bold,
                                    //         color: Theme.of(context).primaryColor,
                                    //       ),
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (context) {
                                    //         return AlertDialog(
                                    //           title: const Text("Petikan"),
                                    //           actions: <Widget>[
                                    //             TextButton(
                                    //               onPressed: () {
                                    //                 Navigator.of(context).pop();
                                    //               },
                                    //               child: const Text('Close'),
                                    //             ),
                                    //           ],
                                    //         );
                                    //       },
                                    //     );
                                    //   },
                                    //   child: Text(
                                    //     "Lihat Petikan",
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .headlineSmall!
                                    //         .copyWith(
                                    //           color: Theme.of(context)
                                    //               .primaryColor,
                                    //         ),
                                    //   ),
                                    // ),
                                    questionWidget(context, state.question,
                                        state.currentQuestionIndex),
                                    _answerList(),
                                    const SizedBox(height: 10),
                                    _nextButton(),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    );
                  } else if (state is LoadedMyQuestionsStates) {
                    return const SizedBox.shrink();
                  } else if (state is LoadingMyQuestionsStates) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ));
        },
      ),
    );
  }

  _answerList() {
    return BlocBuilder<IndividualQuizBloc, IndividualQuizState>(
      builder: (context, state) {
        return Column(
          children: state.question![state.currentQuestionIndex!].questionItems!
              .map(
                (e) => _answerButton(e),
              )
              .toList(),
        );
      },
    );
  }

  Widget _answerButton(QuestionItem answer) {
    return BlocBuilder<IndividualQuizBloc, IndividualQuizState>(
      buildWhen: (previous, current) =>
          current is DoneLoadingMyQuestionsStates ||
          current is SelectedAnswerSet ||
          current is NextQuestionSet,
      builder: (context, state) {
        //check if answer is selected
        bool isSelected = answer == state.selectedAnswer;
        // print(isSelected);
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: isSelected ? Colors.white : Colors.black,
              shape: const StadiumBorder(),
              backgroundColor: isSelected ? Colors.orangeAccent : Colors.white,
            ),
            onPressed: () {
              //for correct answer
              // print("answer.is_answer");
              // print(answer.is_answer);
              if (answer.is_answer == 1) {
                context
                    .read<IndividualQuizBloc>()
                    .add(const SetQuestionScoreEvent());
                // state.score++;
              }
              context
                  .read<IndividualQuizBloc>()
                  .add(SetSelectedAnswerEvent(answer, true));

              // context
              //     .read<IndividualQuizBloc>()
              //     .add(SetSelectedAnswerEvent(answer));
              // setState(() {
              //   selectedAnswer = answer;
              // });
            },
            child: Text(answer.answer!),
          ),
        );
      },
    );
  }

  // _questionWidget() {
  //   return BlocBuilder<IndividualQuizBloc, IndividualQuizState>(
  //     builder: (context, state) {
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             ' ${AppLocalizations.of(context)!.question} ${state.currentQuestionIndex! + 1}/${state.question!.length.toString()}',
  //             style: Theme.of(context).textTheme.headlineSmall!.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                   color: Theme.of(context).primaryColor,
  //                 ),
  //           ),
  //           const SizedBox(height: 10),
  //           state.question![state.currentQuestionIndex!].text_bm != null
  //               ? Center(
  //                   child: InkWell(
  //                     onTap: () {
  //                       showDialog(
  //                         context: context,
  //                         builder: (BuildContext context) {
  //                           return AlertDialog(
  //                             title: const Text("Petikan"),
  //                             content: SizedBox(
  //                               // width: double.infinity,
  //                               child: SingleChildScrollView(
  //                                 child: Column(
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: [
  //                                     Text(
  //                                       state
  //                                           .question![
  //                                               state.currentQuestionIndex!]
  //                                           .text_bm!,
  //                                       style: const TextStyle(fontSize: 16.0),
  //                                     ),
  //                                     // Add more widgets if needed
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             actions: <Widget>[
  //                               TextButton(
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 child: const Text('Close'),
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     },
  //                     child: Text(
  //                       "Lihat Petikan",
  //                       style:
  //                           Theme.of(context).textTheme.headlineSmall!.copyWith(
  //                                 color: Theme.of(context).primaryColor,
  //                               ),
  //                     ),
  //                   ),
  //                 )
  //               : const SizedBox.shrink(),
  //           const SizedBox(height: 5),
  //           state.question![state.currentQuestionIndex!].imageUrl != null
  //               ? Center(
  //                   child: Container(
  //                     width: 325.w,
  //                     height: 200.h,
  //                     decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                             fit: BoxFit.fitWidth,
  //                             image: NetworkImage(
  //                                 "${AppConstants.SERVER_UPLOADS}${state.question![state.currentQuestionIndex!].imageUrl}"))),
  //                   ),
  //                 )
  //               : const SizedBox.shrink(),
  //           const SizedBox(height: 20),
  //           Container(
  //             alignment: Alignment.center,
  //             width: double.infinity,
  //             padding: const EdgeInsets.all(32),
  //             decoration: BoxDecoration(
  //               color: Colors.orangeAccent,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Text(
  //               state.question![state.currentQuestionIndex!].soalan_bm ?? '',
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  _nextButton() {
    return BlocBuilder<IndividualQuizBloc, IndividualQuizState>(
      // buildWhen: (previous, current) => current is DoneLoadingMyQuestionsStates,
      builder: (context, state) {
        bool isLastQuestion = false;
        if (state.currentQuestionIndex == state.question!.length - 1) {
          isLastQuestion = true;
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              if (isLastQuestion) {
                //display score
                _individualQuizController.sendAnswer(false, 2);
                // context
                //     .read<IndividualQuizBloc>()
                //     .add(const NextQuestionEvent(false, 2));

                Navigator.of(context).pushNamed(
                  AppRoutes.QZ_INDIVIDUAL_RESULT,
                  arguments: {
                    "answerDocId": answerDocId,
                    "subjectItem": subjectItem,
                    "levelItem": levelItem,
                    "topicItem": topicItem,
                  },
                );

                // showDialog(
                //     context: context,
                //     builder: (_) =>
                //         _showScoreDialog(state.question!, state.score));
              } else {
                if (state.isSelected == false) {
                  showSnackBar(
                      context,
                      customSnackBar(
                          content: 'Please choose your answer!',
                          context: context));
                } else {
                  //next question
                  _individualQuizController.sendAnswer(false, 1);
                  // context
                  //     .read<IndividualQuizBloc>()
                  //     .add(const NextQuestionEvent(false, 1));
                }

                // setState(() {
                //   selectedAnswer = null;
                //   currentQuestionIndex++;
                // });
              }
            },
            child: Text(isLastQuestion ? "Submit" : "Next"),
          ),
        );
      },
    );
  }

  Widget _showScoreDialog(List<Question> question, int score) {
    bool isPassed = false;
    if (score >= question.length * 0.6) {
      //pass if 60 %
      isPassed = true;
    }
    String title = isPassed ? "Passed " : "Failed";

    return AlertDialog(
      title: Text(
        "$title | Score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: ElevatedButton(
        child: const Text("Restart"),
        onPressed: () {
          Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return const ResultScreen();
          //     },
          //   ),
          // );
          // Navigator.of(context).pushNamed(
          //   AppRoutes.RESULT,
          //   arguments: {"id": state.studentItem.elementAt(studentIndex).id},
          // );
          // context.read<IndividualQuizBloc>().add(const RestartQuestionEvent());
          // setState(() {
          //   currentQuestionIndex = 0;
          //   score = 0;
          //   selectedAnswer = null;
          // });
        },
      ),
    );
  }
}
