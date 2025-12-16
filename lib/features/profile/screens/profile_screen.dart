import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/application/bloc/app_bloc.dart';
import 'package:quezzy_app/features/more/bloc/more_bloc.dart';
import 'package:quezzy_app/features/more/controllers/more_controller.dart';
import 'package:quezzy_app/features/package/widgets/package_card.dart';
import 'package:quezzy_app/features/profile/bloc/profile_bloc.dart';
import 'package:quezzy_app/features/profile/screens/profile_update_screen.dart';
import 'package:quezzy_app/global.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    MoreController(context: context).init();
    final profileBloc = context.read<ProfileBloc>();
    if (profileBloc.state.studentItem == null) {
      profileBloc.add(
        TriggerInitialStudentItemEvent(Global.storageService.getStudentProfile()),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Profil',
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is TriggerInitialStudentItemEvent) {}
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                final student = state.studentItem;
                return Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.42,
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
                                                height: 78,
                                              ),
                                              Text(
                                                student?.name ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              student?.schoolName !=
                                                      null
                                                  ? Text(
                                                      student?.schoolName ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              student?.schoolName !=
                                                      null
                                                  ? const SizedBox(
                                                      height: 20,
                                                    )
                                                  : const SizedBox.shrink(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        const StadiumBorder(),
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return const ProfileUpdateScreen();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                      "Kemaskini Profil"),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 10),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      shape:
                                                          const StadiumBorder(),
                                                      side: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      foregroundColor: Theme.of(
                                                              context)
                                                          .primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .maybePop();
                                                    },
                                                    child: const Text(
                                                        'Back to Parent Page'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 18,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: Container(
                                            child: student != null
                                                ? _buildStudentAvatar(
                                                    innerWidth, state)
                                                : const SizedBox.shrink(),
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
                            Text(
                              "Senarai Pakej Dilanggan",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<MoreBloc, MoreState>(
                              builder: (context, state) {
                                List<Widget> packageCards = [];
                                for (var subscribeItem
                                    in state.subPackageItem) {
                                  packageCards.add(
                                    PackageCard(
                                      packageName: subscribeItem.name!,
                                      textName: "Tukar",
                                      image: subscribeItem.imageUrl != null
                                          ? Image.asset(
                                              subscribeItem.imageUrl!,
                                              width: AppDimension()
                                                  .kFortyEightScreenWidth,
                                            )
                                          : Image.asset(
                                              "assets/images/categories/png/English.png",
                                              width: AppDimension()
                                                  .kFortyEightScreenWidth,
                                            ),
                                      packageDescription:
                                          subscribeItem.description,
                                      onTap: () {
                                        Global.storageService.setString(
                                            AppConstants.STORAGE_PACKAGE_ID,
                                            jsonEncode(
                                                subscribeItem.package_id));
                                        Global.storageService.setString(
                                            AppConstants.STORAGE_PACKAGE_NAME,
                                            subscribeItem.name ?? '');
                                        Global.storageService.setString(
                                            AppConstants.STORAGE_STUDENT_ID,
                                            jsonEncode(Global.storageService
                                                .getStudentId()));
                                        context
                                            .read<AppBloc>()
                                            .add(const TriggerAppEvent(0));
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          "/application",
                                          (route) => false,
                                        );
                                      },
                                    ),
                                  );
                                  packageCards.add(
                                    const SizedBox(
                                        height:
                                            16), // Adjust the height as needed
                                  );
                                }
                                // Remove the last SizedBox to avoid extra space at the end
                                if (packageCards.isNotEmpty) {
                                  packageCards.removeLast();
                                }
                                return Column(
                                  children: packageCards,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStudentAvatar(double innerWidth, ProfileState state) {
    final String? avatarPath = state.studentItem?.avatar;

    final bool useDefault = avatarPath == null ||
        avatarPath.isEmpty ||
        !avatarPath.startsWith('assets/');

    final String effectivePath = useDefault
        ? AppConstants.DEFAULT_STUDENT_AVATAR
        : avatarPath;

    final double size = (innerWidth * 0.28).clamp(80.0, 110.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          effectivePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
