import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/question/bloc/question_bloc.dart';
import 'package:quezzy_app/features/question/widget/circular_painter.dart';
import 'package:quezzy_app/features/question/widget/result_data.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // late PackageController _packageController;
  late Map questionId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    questionId = ModalRoute.of(context)!.settings.arguments as Map;
    // print("questionId/////");
    // print(questionId);
    // PackageController(context: context).initSubscribe(studentId["id"]);
    // Future.delayed(const Duration(seconds: 3), () {
    //   _packageController = PackageController(context: context);
    //   _packageController.initSubscribe(studentId["id"]);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionBloc(),
      child: _ResultScaffold(
        result: ResultData.result,
      ),
    );
  }
}

class _ResultScaffold extends StatefulWidget {
  final List<ResultData> result;
  const _ResultScaffold({required this.result});

  @override
  State<_ResultScaffold> createState() => __ResultScaffoldState();
}

class __ResultScaffoldState extends State<_ResultScaffold> {
  @override
  Widget build(BuildContext context) {
    // int oMarks = (widget.result).map((e) => e.obtainedMarks).sum.toInt();
    // int tMarks = (widget.result).map((e) => e.totalMarks).sum.toInt();

    return SafeArea(
      child: Scaffold(
          backgroundColor: kLightAccent,
          body: Column(
            children: [
              CustomAppBar(
                backgroundColor: kLightAccent,
                title: 'Your Result',
                leading: [
                  Center(
                    child: CustomIconButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
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
              Expanded(
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
                            '90%',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'You are excellent',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    Text(
                      'Iqram!!',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    SizedBox(height: 40.h),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: kTopBorderRadius,
                        color: kPrimaryColor,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(AppDimension().defaultPadding),
                        itemCount: widget.result.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: AppDimension().defaultPadding),
                            padding: EdgeInsets.all(
                                AppDimension().defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: kOtherColor,
                              borderRadius: BorderRadius.circular(
                                  AppDimension().defaultPadding),
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.result[index].subjectName,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${widget.result[index].obtainedMarks} / ${widget.result[index].totalMarks}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              width: 2.h,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[700],
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      AppDimension()
                                                          .defaultPadding),
                                                  bottomRight: Radius.circular(
                                                      AppDimension()
                                                          .defaultPadding),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 12.h,
                                              width: widget
                                                  .result[index].obtainedMarks
                                                  .toDouble(),
                                              decoration: BoxDecoration(
                                                color: widget.result[index]
                                                            .grade ==
                                                        '0'
                                                    ? kErrorBorderColor
                                                    : kPrimaryColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      AppDimension()
                                                          .defaultPadding),
                                                  bottomRight: Radius.circular(
                                                      AppDimension()
                                                          .defaultPadding),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          widget.result[index].grade,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
