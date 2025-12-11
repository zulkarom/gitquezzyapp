import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/core/constant/constants.dart';
import '../../reusable/widgets/custom_app_bar.dart';

class ParentPerformanceScreen extends StatefulWidget {
  const ParentPerformanceScreen({super.key});

  @override
  State<ParentPerformanceScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<ParentPerformanceScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // StudentController(context: context).init();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(
              title: AppConstants.APPS_NAME,
              // ending: [
              //   Center(
              //     child: CustomIconButton(
              //       onTap: () {
              //         Navigator.of(context).pushNamedAndRemoveUntil(
              //             "/student_list_edit", (route) => false);
              //       },
              //       child: Icon(
              //         Icons.edit,
              //         size: AppDimension().kTwentyScreenPixel,
              //         color:
              //             Theme.of(context).appBarTheme.actionsIconTheme!.color,
              //       ),
              //     ),
              //   ),
              // ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text("Prestasi Pelajar",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                )),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 20.w),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.74,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return SizedBox(
                              // height: size.height * 0.5,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double innerHeight = constraints.maxHeight;
                                  double innerWidth = constraints.maxWidth;
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        //top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight * 0.8,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: kLightAccent,
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  3, // Assuming itemCount is 3
                                                  (starIndex) {
                                                    return const Icon(
                                                      Icons.star_border,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Iqram',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Progress',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      const Text(
                                                        '10%',
                                                        // '${state.subscribeItem?.progress! ?? 0}%',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 15,
                                                      vertical: 8,
                                                    ),
                                                    child: Container(
                                                      height: 20,
                                                      width: 2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Purata',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Markah',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      const Text(
                                                        '15%',
                                                        // '${state.subscribeItem?.totalScore!.toStringAsFixed(2)}%',
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/performance/png/platinium2.png',
                                            width: innerWidth * 0.45,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                          childCount: 4,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
