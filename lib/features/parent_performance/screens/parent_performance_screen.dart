import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/performance/bloc/performance_bloc.dart';
import 'package:quezzy_app/features/performance/controller/performance_controller.dart';
import '../../../core/bloc/data/cubit/data_cubit.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final int? selectedStudentId = context.watch<DataCubit>().state.studentId;

    return BlocProvider(
      create: (context) => PerformanceBloc(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const CustomAppBar(
                title: AppConstants.APPS_NAME,
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    PerformanceController(
                      context: context,
                      studentId: selectedStudentId,
                    ).init();

                    return BlocBuilder<PerformanceBloc, PerformanceState>(
                      builder: (context, state) {
                        if (selectedStudentId == null) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 18.h, horizontal: 20.w),
                              child: Text(
                                'Sila pilih pelajar dahulu',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          );
                        }

                        if (state is LoadingMyPerformanceStates) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is DoneLoadingMyPerformanceStates) {
                          final subscribeItem = state.subscribeItem;
                          if (subscribeItem == null) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 18.h, horizontal: 20.w),
                                child: Text(
                                  'Tiada data prestasi',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            );
                          }

                          final double starRating = subscribeItem.star ?? 0.0;
                          final double progress = subscribeItem.progress ?? 0.0;

                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15.w),
                            child: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                    child: SizedBox(height: 10.h)),
                                SliverToBoxAdapter(
                                  child: Center(
                                    child: Text(
                                      "Prestasi Pelajar",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                    child: SizedBox(height: 10.h)),
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18.h, horizontal: 20.w),
                                  sliver: SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: size.height * 0.42,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          final double innerHeight =
                                              constraints.maxHeight;
                                          final double innerWidth =
                                              constraints.maxWidth;

                                          return Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  height: innerHeight * 0.8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: kLightAccent,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children:
                                                            List.generate(
                                                          3,
                                                          (starIndex) {
                                                            if (starIndex <
                                                                starRating
                                                                    .floor()) {
                                                              return const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size: 25,
                                                              );
                                                            } else if (starIndex ==
                                                                    starRating
                                                                        .floor() &&
                                                                starRating % 1 !=
                                                                    0) {
                                                              return const Icon(
                                                                Icons.star_half,
                                                                color: Colors
                                                                    .amber,
                                                                size: 25,
                                                              );
                                                            }
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
                                                        subscribeItem.name ??
                                                            '',
                                                        style: Theme.of(context)
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
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                'Progress',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${progress.toStringAsFixed(0)}%',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          39,
                                                                          105,
                                                                          171,
                                                                          1),
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 15,
                                                              vertical: 8,
                                                            ),
                                                            child: Container(
                                                              height: 20,
                                                              width: 2,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                'Purata',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Markah',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${(subscribeItem.totalScore ?? 0.0).toStringAsFixed(2)}%',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          39,
                                                                          105,
                                                                          171,
                                                                          1),
                                                                  fontFamily:
                                                                      'Nunito',
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
                                                    width: innerWidth * 0.35,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
