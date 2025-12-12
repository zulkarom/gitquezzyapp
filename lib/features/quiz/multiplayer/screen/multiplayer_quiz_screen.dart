import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';
import 'package:quezzy_app/features/quiz/multiplayer/screen/multiplayer_performance_screen.dart';

import '../../../../core/constant/app_dimensions.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/show_snackbar.dart';
import '../../../reusable/widgets/custom_app_bar.dart';
import '../../../reusable/widgets/custom_icon_button.dart';
import '../../../reusable/widgets/custom_snack_bar.dart';
import '../../widgets/question_widget.dart';
import '../bloc/multiplayer_quiz_bloc.dart';
import '../controller/multiplayer_quiz_controller.dart';

class MultiplayerQuizScreen extends StatefulWidget {
  const MultiplayerQuizScreen({super.key});

  @override
  State<MultiplayerQuizScreen> createState() => _MultiplayerQuizScreenState();
}

class _MultiplayerQuizScreenState extends State<MultiplayerQuizScreen> {
  //define the datas
  // List<Question> questionList = getQuestions();

  late MultiplayerQuizController _multiplayerQuizController;
  late var docId;
  late LevelItem levelItem;
  late TopicItem topicItem;
  late SubjectItem subjectItem;
  @override
  void didChangeDependencies() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    docId = data["room_doc_id"];
    subjectItem = data["subjectItem"];
    levelItem = data["levelItem"];
    topicItem = data["topicItem"];
    _multiplayerQuizController = MultiplayerQuizController(context: context);
    _multiplayerQuizController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: BlocProvider<MultiplayerQuizBloc>(
                            create: (context) => MultiplayerQuizBloc(),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: MultiplayerPerformanceScreen(
                                  docId: docId,
                                  question: state.question,
                                  subjectItem: subjectItem,
                                  levelItem: levelItem,
                                  topicItem: topicItem,
                                ))),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.list_alt_outlined),
              ),
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
                  BlocListener<MultiplayerQuizBloc, MultiplayerQuizState>(
                    listener: (context, state) {
                      if (state is RestartQuestionSet) {
                        context
                            .read<MultiplayerQuizBloc>()
                            .add(const TriggerDoneLoadingMyQuestionsEvent());
                      }
                    },
                    child:
                        BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
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
                                          questionWidget(
                                              context,
                                              state.question,
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
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  // _questionWidget() {
  //   return BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
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

  _answerList() {
    return BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
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
    return BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
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
              // if (state.selectedAnswer == null) {
              //for correct answer
              // print("answer.is_answer");
              // print(answer.is_answer);
              if (answer.is_answer == 1) {
                context
                    .read<MultiplayerQuizBloc>()
                    .add(const SetQuestionScoreEvent());
                // state.score++;
              }
              context
                  .read<MultiplayerQuizBloc>()
                  .add(SetSelectedAnswerEvent(answer, true));

              // context
              //     .read<MultiplayerQuizBloc>()
              //     .add(SetSelectedAnswerEvent(answer));
              // setState(() {
              //   selectedAnswer = answer;
              // });
              // }
            },
            child: Text(answer.answer!),
          ),
        );
      },
    );
  }

  _nextButton() {
    return BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
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
                _multiplayerQuizController.sendAnswer(false, 2);
                // context
                //     .read<MultiplayerQuizBloc>()
                //     .add(const NextQuestionEvent(false, 2));

                Navigator.of(context).pushNamed(
                  AppRoutes.QZ_MULTIPLAYER_RESULT,
                  arguments: {
                    "room_doc_id": docId,
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
                  _multiplayerQuizController.sendAnswer(false, 1);
                  // context
                  //     .read<MultiplayerQuizBloc>()
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
          // context.read<MultiplayerQuizBloc>().add(const RestartQuestionEvent());
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
