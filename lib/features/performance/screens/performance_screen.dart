import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/performance/bloc/performance_bloc.dart';
import 'package:quezzy_app/features/performance/controller/performance_controller.dart';

import '../../reusable/widgets/custom_app_bar.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PerformanceBloc(),
      child: const _PerformanceScaffold(),
    );
  }
}

class _PerformanceScaffold extends StatefulWidget {
  const _PerformanceScaffold();

  @override
  _PerformanceScaffoldState createState() => _PerformanceScaffoldState();
}

class _PerformanceScaffoldState extends State<_PerformanceScaffold> {
  @override
  void didChangeDependencies() {
    PerformanceController(context: context).init();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
      if (state is DoneLoadingMyPerformanceStates) {
        // print("state.subscribeItem?.id");
        // print(state.subscribeItem?.id);
        return Scaffold(
          // backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'Prestasi',
                ),
                BlocBuilder<PerformanceBloc, PerformanceState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.5,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double innerHeight = constraints.maxHeight;
                                  double innerWidth = constraints.maxWidth;
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight * 0.72,
                                          width: innerWidth,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: kLightAccent,
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 80,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  3, // Assuming itemCount is 3
                                                  (starIndex) {
                                                    double starRating = state
                                                            .subscribeItem
                                                            ?.star ??
                                                        0.00;
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
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                state.subscribeItem?.name ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 10,
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
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${state.subscribeItem?.progress! ?? 0}%',
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 25,
                                                      vertical: 8,
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      width: 3,
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
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Markah',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${state.subscribeItem?.progress!.toStringAsFixed(2) ?? 0}%',
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 25,
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
                                          child: Container(
                                            child: Image.asset(
                                              'assets/images/performance/png/platinium2.png',
                                              width: innerWidth * 0.45,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      } else if (state is LoadedMyPerformanceStates) {
        return const SizedBox.shrink();
      } else if (state is LoadingMyPerformanceStates) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
