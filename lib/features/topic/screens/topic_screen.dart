import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/features/level/screens/level_screen.dart';
import 'package:quezzy_app/features/topic/controller/topic_controller.dart';
import 'package:quezzy_app/features/topic/widgets/topic_card.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';
import 'package:quezzy_app/global.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../bloc/topic_bloc.dart';

class TopicScreen extends StatefulWidget {
  final SubjectItem subjectItem;
  const TopicScreen(this.subjectItem, {super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopicBloc(),
      child: _TopicScaffold(widget.subjectItem),
    );
  }
}

class _TopicScaffold extends StatefulWidget {
  final SubjectItem subjectItem;
  const _TopicScaffold(
    this.subjectItem,
  );

  @override
  _TopicScaffoldState createState() => _TopicScaffoldState();
}

class _TopicScaffoldState extends State<_TopicScaffold> {
  late TopicController _topicController;
  @override
  void didChangeDependencies() {
    _topicController = TopicController(context: context);
    _topicController.init(widget.subjectItem.id!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, statelg) {
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(
                  title: statelg.language.name == 'eng'
                      ? widget.subjectItem.name_eng ?? ''
                      : widget.subjectItem.name_bm ?? '',
                  leading: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.of(context).pop();
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
                ),
                BlocBuilder<TopicBloc, TopicState>(
                  builder: (context, state) {
                    if (state is DoneLoadingMyTopicStates) {
                      return Padding(
                        padding:
                            EdgeInsets.all(AppDimension().kTwelveScreenWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.listTopic,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            state.topicItem!.isEmpty
                                ? Text(
                                    AppLocalizations.of(context)!.noResult,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                                height: AppDimension().kSixteenScreenHeight),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 187,
                              child: ListView.builder(
                                itemCount: state.topicItem!.length,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return LevelScreen(
                                                  widget.subjectItem,
                                                  state.topicItem![index]);
                                            },
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TopicCard(
                                                topicName: statelg.language.name == 'eng'
                                                    ? state.topicItem![index]
                                                            .name_eng ??
                                                        ''
                                                    : state.topicItem![index]
                                                            .name_bm ??
                                                        '',
                                                topicDesc: statelg.language.name ==
                                                        'eng'
                                                    ? state.topicItem![index]
                                                            .description_eng ??
                                                        ''
                                                    : state.topicItem![index]
                                                            .description_bm ??
                                                        '',
                                                image: Image.asset(
                                                  "assets/images/categories/png/English.png",
                                                  width: AppDimension()
                                                      .kFortyEightScreenWidth,
                                                ),
                                                star: Global.starCalculation(
                                                    state.topicItem![index]
                                                            .progress! /
                                                        100),
                                                progress: context
                                                    .read<TopicBloc>()
                                                    .state
                                                    .topicItem![index]
                                                    .progress!

                                                // state
                                                //     .topicItem![index].progress!,
                                                ),
                                          ),
                                          SizedBox(width: size.width * .02),
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
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );

    // return SafeArea(
    //   child: Background(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const Text(
    //             "Senarai Topik",
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           SizedBox(height: AppDimension().kSixteenScreenHeight * 2),
    //           TopicCard(
    //             topicName: 'Topik 1',
    //             topicDesc: 'Deskripsi topik 1',
    //             image: SvgPicture.asset(
    //               "assets/images/categories/png/English.png",
    //               width: AppDimension().kFortyEightScreenWidth,
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
