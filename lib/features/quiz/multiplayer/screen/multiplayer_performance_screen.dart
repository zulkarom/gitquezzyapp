import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/quiz/multiplayer/controller/performance_controller.dart';
import 'package:quezzy_app/global.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/bloc/language/language_bloc.dart';
import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/models/entities.dart';
import '../../../reusable/widgets/custom_app_bar.dart';
import '../../../reusable/widgets/custom_icon_button.dart';
import '../bloc/multiplayer_quiz_bloc.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';

class MultiplayerPerformanceScreen extends StatefulWidget {
  const MultiplayerPerformanceScreen({
    super.key,
    required this.docId,
    this.question,
    this.totalScore,
    this.subjectItem,
    this.levelItem,
    this.topicItem,
  });
  final String docId;
  final List<Question>? question;
  final double? totalScore;
  final SubjectItem? subjectItem;
  final LevelItem? levelItem;
  final TopicItem? topicItem;

  @override
  State<MultiplayerPerformanceScreen> createState() =>
      _MultiplayerPerformanceScreenState();
}

class _MultiplayerPerformanceScreenState
    extends State<MultiplayerPerformanceScreen> {
  late PerformanceController _performanceController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _performanceController = PerformanceController(context: context);
    _performanceController.init(widget.docId);
  }

  @override
  void dispose() {
    // Dispose of resources, close streams, etc.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, statelg) {
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(
                  title: 'Players',
                  // statelg.language.name == 'eng'
                  //     ? widget.subjectItem.name_eng ?? ''
                  //     : widget.subjectItem.name_bm ?? '',
                  ending: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
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
                    if (state is DonePlayerListStates) {
                      //print(state.listPerformance);
                    }
                  },
                  child: BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, stateLg) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      stateLg.language.name == 'eng'
                                          ? widget.subjectItem!.name_eng ?? ''
                                          : widget.subjectItem!.name_bm ?? '',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      stateLg.language.name == 'eng'
                                          ? widget.topicItem!.name_eng ?? ''
                                          : widget.topicItem!.name_bm ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      // style: TextStyle(
                                      //   fontSize: 22,
                                      //   fontWeight: FontWeight.w600,
                                      //   color: Colors.black.withOpacity(0.6),
                                    ),
                                    // Text(
                                    //   topicItem.name_bm!,
                                    //   style: TextStyle(
                                    //     fontSize: 18,
                                    //     fontStyle: FontStyle.italic,
                                    //   ),
                                    // ),
                                    Text(
                                      // "Level 1",
                                      "Level ${widget.levelItem!.level_number}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: const Text(
                                            "Players",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.24,
                                          child: const Text(
                                            "Status",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          child: const Text(
                                            "Performance",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.35, // screen height, // Set a specific height for the list container
                                      child: BlocBuilder<MultiplayerQuizBloc,
                                          MultiplayerQuizState>(
                                        builder: (context, state) {
                                          return ListView.builder(
                                            itemCount: state.playerList!.length,
                                            itemBuilder: (context, index) {
                                              final friend =
                                                  state.playerList![index];
                                              final percent = (friend
                                                          .totalQuestion! /
                                                      widget.question!.length) *
                                                  100;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: Text(
                                                      friend.name!,
                                                    ),
                                                  ),
                                                  // Add some spacing between name and status
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: friend
                                                                      .status! ==
                                                                  10
                                                              ? Colors.red
                                                              : friend.status! ==
                                                                      20
                                                                  ? Colors.blue
                                                                  : friend.status! ==
                                                                          30
                                                                      ? Colors
                                                                          .orange
                                                                      : Colors
                                                                          .green, // Customize the background color
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8), // Add rounded corners
                                                        ),
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8,
                                                            vertical:
                                                                4), // Add padding
                                                        child: Text(
                                                          Global.playerStatus(
                                                              friend.status!),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .white, // Customize text color
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 15.0),
                                                      child: Column(
                                                        children: [
                                                          friend.status != 40
                                                              ? Text(
                                                                  ' ${AppLocalizations.of(context)!.question} ${friend.totalQuestion}/${widget.question!.length.toString()}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .copyWith(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                )
                                                              : const Text(''),
                                                          friend.status != 40
                                                              ? LinearPercentIndicator(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      290,
                                                                  animation:
                                                                      true,
                                                                  lineHeight:
                                                                      18.0,
                                                                  animationDuration:
                                                                      2000,
                                                                  percent:
                                                                      percent /
                                                                          100,
                                                                  center: Text(
                                                                      '${(percent).toStringAsFixed(1)}%'),
                                                                  barRadius:
                                                                      const Radius
                                                                          .circular(
                                                                          10.0),
                                                                  progressColor:
                                                                      Colors
                                                                          .redAccent,
                                                                )
                                                              : Text(
                                                                  '${friend.totalMark!.roundToDouble().toStringAsFixed(2)}%',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
