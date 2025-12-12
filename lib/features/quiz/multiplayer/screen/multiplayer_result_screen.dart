import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/level/screens/level_screen.dart';
import 'package:quezzy_app/features/question/widget/circular_painter.dart';
import 'package:quezzy_app/features/quiz/multiplayer/bloc/multiplayer_quiz_bloc.dart';
import 'package:quezzy_app/features/quiz/multiplayer/screen/multiplayer_performance_screen.dart';
import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/models/entities.dart';
import '../../../reusable/widgets/custom_app_bar.dart';
import '../../widgets/result_widget.dart';
import '../bloc/multiplayer_result_bloc.dart';
import '../controller/multiplayer_result_controller.dart';

class MultiplayerResultScreen extends StatefulWidget {
  const MultiplayerResultScreen({super.key});

  @override
  State<MultiplayerResultScreen> createState() =>
      _MultiplayerResultScreenState();
}

class _MultiplayerResultScreenState extends State<MultiplayerResultScreen> {
  @override
  Widget build(BuildContext context) {
    return const _ResultScaffold();
  }
}

class _ResultScaffold extends StatefulWidget {
  const _ResultScaffold();

  @override
  State<_ResultScaffold> createState() => __ResultScaffoldState();
}

class __ResultScaffoldState extends State<_ResultScaffold> {
  late SubjectItem subjectItem;
  late LevelItem levelItem;
  late TopicItem topicItem;
  late String docId;
  late MultiplayerResultController _multiplayerResultController;

  @override
  void didChangeDependencies() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    docId = data["room_doc_id"];
    subjectItem = data["subjectItem"];
    levelItem = data["levelItem"];
    topicItem = data["topicItem"];
    _multiplayerResultController =
        MultiplayerResultController(context: context);
    _multiplayerResultController.init();
    // Future.delayed(const Duration(seconds: 3), () {
    //   _packageController = PackageController(context: context);
    //   _packageController.initSubscribe(studentId["id"]);
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // int oMarks = (widget.result).map((e) => e.obtainedMarks).sum.toInt();
    // int tMarks = (widget.result).map((e) => e.totalMarks).sum.toInt();

    return SafeArea(
      child: BlocBuilder<MultiplayerQuizBloc, MultiplayerQuizState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: kLightAccent,
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
                                  totalScore: context
                                      .read<MultiplayerResultBloc>()
                                      .state
                                      .totalScore,
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
                    backgroundColor: kLightAccent,
                    title: 'Your Result',
                    leading: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LevelScreen(
                                          subjectItem, topicItem);
                                    },
                                  ),
                                );

                                // showDialog(
                                //   context: context,
                                //   builder: (_) {
                                //     return Dialog(
                                //       backgroundColor: kLightAccent,
                                //       child: SizedBox(
                                //           width: 300 / 2, // Set the desired width
                                //           height: 200 / 2, // Set the desired height
                                //           child: showTextDialog(context, 0)),
                                //     );
                                //   },
                                // );
                              },
                              child: reusableText("Back")),
                        ),
                      )
                    ],
                    ending: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Dialog(
                                      backgroundColor: kLightAccent,
                                      child: SizedBox(
                                          width:
                                              300 / 2, // Set the desired width
                                          height:
                                              200 / 2, // Set the desired height
                                          child: showTextDialog(context, 1)),
                                    );
                                  },
                                );
                              },
                              child: reusableText("Next")),
                        ),
                      )
                    ],
                  ),
                  BlocListener<MultiplayerResultBloc, MultiplayerResultState>(
                    listener: (context, state) {
                      if (state is DoneLoadingMyResultsStates) {
                        _multiplayerResultController
                            .setTotalScore(state.totalScore);
                        _multiplayerResultController.asyncCopyAnswer(
                            levelItem,
                            topicItem,
                            state.answer,
                            state.starScore,
                            state.totalScore);

                        print("state.totalScore");
                        print(state.totalScore);
                      }
                    },
                    child: BlocBuilder<MultiplayerResultBloc,
                        MultiplayerResultState>(
                      builder: (context, state) {
                        // print("sdfdsfdsfdsfdsfdsfewfewew");
                        // print(state.question!.length);
                        if (state is DoneLoadingMyResultsStates) {
                          MultiplayerResultController(context: context)
                              .asyncPostLevelResultData(
                                  state.totalScore.round(), levelItem);
                          return Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 150.h,
                                  margin: EdgeInsets.all(20.h),
                                  child: CustomPaint(
                                    foregroundPainter: CircularPainter(
                                        backgroundColor: kPrimaryColor,
                                        lineColor: kOtherColor,
                                        width: 15.w),
                                    child: Center(
                                      child: Text(
                                        "${state.totalScore.round().toString()}%",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Your Correct Answer Is',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                Text(
                                  "${state.correctAnswer.toString()} / ${state.question.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                // AppDimension().sizedBox,
                                // AppDimension().sizedBox,
                                // Text(
                                //   'You are excellent',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headlineSmall!
                                //       .copyWith(
                                //         fontWeight: FontWeight.bold,
                                //         color: Theme.of(context).primaryColor,
                                //       ),
                                // ),
                                // Text(
                                //   'Iqram!!',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headlineSmall!
                                //       .copyWith(
                                //         fontWeight: FontWeight.bold,
                                //         color: Theme.of(context).primaryColor,
                                //       ),
                                // ),
                                SizedBox(height: 40.h),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: kTopBorderRadius,
                                    color: kPrimaryColor,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15.h),
                                      Text(
                                        'Review Your Answer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                            ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(
                                              AppDimension().defaultPadding),
                                          itemCount: state.result.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: AppDimension()
                                                      .defaultPadding),
                                              padding: EdgeInsets.all(
                                                  AppDimension()
                                                          .defaultPadding /
                                                      2),
                                              decoration: BoxDecoration(
                                                color: kOtherColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimension()
                                                            .defaultPadding),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: kTextLightColor,
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  state.result[index]
                                                              ["imageUrl"] !=
                                                          null
                                                      ? Center(
                                                          child: Container(
                                                            width: 325.w / 1.5,
                                                            height: 200.h / 1.5,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    image: NetworkImage(
                                                                        "${AppConstants.SERVER_UPLOADS}${state.result[index]["imageUrl"]}"))),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          state.result[index]
                                                              ["soalan_bm"],
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: state
                                                            .result[index][
                                                                "questionItems"]
                                                            .map<Widget>(
                                                              (e) => Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  e.answer!,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleMedium!
                                                                      .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: state.result[index]["itemId"].toString() ==
                                                                                e.id.toString()
                                                                            ? Colors.green
                                                                            : e.is_answer == 1
                                                                                ? Colors.red
                                                                                : Theme.of(context).primaryColor,
                                                                      ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                      state.result[index][
                                                                  "is_answer"] ==
                                                              1
                                                          ? Icon(
                                                              Icons.check,
                                                              size: AppDimension()
                                                                  .kFortyScreenPixel,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : Icon(
                                                              Icons.close,
                                                              size: AppDimension()
                                                                  .kFortyScreenPixel,
                                                              color: Colors.red,
                                                            ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        } else if (state is LoadedMyResultsStates) {
                          return const SizedBox.shrink();
                        } else if (state is LoadingMyResultsStates) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
