import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/features/level/bloc/level_bloc.dart';
import 'package:quezzy_app/features/level/controller/level_controller.dart';
import 'package:quezzy_app/features/messages/message/message_screen.dart';
import 'package:quezzy_app/features/topic/screens/topic_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/models/entities.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../widgets/level_board.dart';

class LevelScreen extends StatefulWidget {
  final SubjectItem subjectItem;
  final TopicItem topicItem;
  const LevelScreen(this.subjectItem, this.topicItem, {super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LevelBloc(),
      child: _LevelScaffold(widget.subjectItem, widget.topicItem),
    );
  }
}

class _LevelScaffold extends StatefulWidget {
  final SubjectItem subjectItem;
  final TopicItem topicItem;
  const _LevelScaffold(
    this.subjectItem,
    this.topicItem,
  );

  @override
  _LevelScaffoldState createState() => _LevelScaffoldState();
}

class _LevelScaffoldState extends State<_LevelScaffold> {
  late LevelController _levelController;
  @override
  void didChangeDependencies() {
    _levelController = LevelController(context: context);
    _levelController.init(widget.topicItem);
    super.didChangeDependencies();
  }

  get kLightField => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const MessageScreen();
                },
              ),
            );
          },
          // foregroundColor: customizations[index].$1,
          // backgroundColor: customizations[index].$2,
          // shape: customizations[index].$3,
          child: const Icon(Icons.chat),
        ),
        body: Column(
          children: [
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, statelg) {
                return CustomAppBar(
                  title: statelg.language.name == 'eng'
                      ? widget.topicItem.name_eng ?? ''
                      : widget.topicItem.name_bm ?? '',
                  leading: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TopicScreen(widget.subjectItem);
                              },
                            ),
                          );
                        },
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
                );
              },
            ),
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, statelg) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.all(AppDimension().kTwelveScreenWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          BlocBuilder<LevelBloc, LevelState>(
                              builder: (context, state) {
                            if (state is DoneLoadingMyLevelStates) {
                              // print("state.levelItem!.length");
                              // print(state.levelItem!.length);
                              return GridView.builder(
                                itemCount: state.levelItem!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.height -
                                              50 -
                                              25) /
                                          (4 * 240),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                              ),
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (state.levelItem !=
                                                          null) {
                                                        _levelController
                                                            .goAnswer(
                                                          widget.subjectItem,
                                                          state.levelItem![
                                                              index],
                                                          widget.topicItem,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      // decoration:
                                                      //     const BoxDecoration(
                                                      //   border: Border(
                                                      //     bottom: BorderSide(
                                                      //         color:
                                                      //             Colors.grey),
                                                      //   ),
                                                      // ),
                                                      child: const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            "Individual",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15.0),
                                                    child: Divider(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        height: 0),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (state.levelItem !=
                                                          null) {
                                                        _levelController
                                                            .createRoom(
                                                          widget.subjectItem,
                                                          state.levelItem![
                                                              index],
                                                          widget.topicItem,
                                                        );
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          bottom:
                                                              60), // Add margin after the last child
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: const Row(
                                                          children: [
                                                            Icon(
                                                              Icons.group,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(width: 8),
                                                            Text(
                                                              "Multiplayer",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );

                                        // Navigator.pop(context);
                                        // Navigator.of(context)
                                        //     .pushNamedAndRemoveUntil(
                                        //   "/question",
                                        //   (route) => false,
                                        //   arguments: {
                                        //     "levelItem": state.levelItem![index]
                                        //   },
                                        // );

                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return QuestionScreen(
                                        //           state.levelItem![index],
                                        //           widget.topicItem);
                                        //     },
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        width: AppDimension().kFortyScreenWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kLightField,
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              LevelBoard(state.levelItem![index]
                                                  .level_number),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                children: List.generate(
                                                  3, // Assuming itemCount is 3
                                                  (starIndex) {
                                                    double starRating = state
                                                        .levelItem![index]
                                                        .star!;
                                                    if (starIndex <
                                                        starRating.floor()) {
                                                      // Fully filled star
                                                      return const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 30,
                                                      );
                                                    } else if (starIndex ==
                                                            starRating
                                                                .floor() &&
                                                        starRating % 1 != 0) {
                                                      // Half-filled star
                                                      return const Icon(
                                                        Icons.star_half,
                                                        color: Colors.amber,
                                                        size: 30,
                                                      );
                                                    } else {
                                                      // Empty star
                                                      return const Icon(
                                                        Icons.star_border,
                                                        color: Colors.grey,
                                                        size: 30,
                                                      );
                                                    }
                                                  },
                                                ),
                                              )
                                              // RatingBar.builder(
                                              //   initialRating:
                                              //       state.levelItem![index].star!,
                                              //   minRating: 0,
                                              //   itemSize: 30.0,
                                              //   direction: Axis.horizontal,
                                              //   allowHalfRating: true,
                                              //   itemCount: 3,
                                              //   itemBuilder: (context, _) =>
                                              //       const Icon(
                                              //     Icons.star,
                                              //     color: Colors.amber,
                                              //     size:
                                              //         30, // Adjust the size of the star icons as needed
                                              //   ),
                                              //   onRatingUpdate: (rating) {},
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ));
                                }),
                              );
                            } else if (state is LoadedMyLevelStates) {
                              return const SizedBox.shrink();
                            } else if (state is LoadingMyLevelStates) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
