import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/application/bloc/app_bloc.dart';
import 'package:quezzy_app/features/auth/screens/login_screen.dart';
import 'package:quezzy_app/features/billing/screens/billing_detail_screen.dart';
import 'package:quezzy_app/features/info/screens/info_screen.dart';
import 'package:quezzy_app/features/parent_application/bloc/app_parent_bloc.dart'
    as parent;
import 'package:quezzy_app/features/parent_profile/bloc/parent_profile_bloc.dart';
import 'package:quezzy_app/features/parent_profile/screens/parent_profile_password_screen.dart';
import 'package:quezzy_app/features/parent_profile/screens/parent_profile_update_screen.dart';
import 'package:quezzy_app/features/parent_profile/widgets/other_card.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_snack_bar.dart';
import 'package:quezzy_app/global.dart';
import 'package:quezzy_app/utils/show_snackbar.dart';

import '../../reusable/widgets/custom_app_bar.dart';

class ParentProfileScreen extends StatefulWidget {
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ParentProfileBloc>().add(
        TriggerInitialUserItemEvent(Global.storageService.getUserProfile()));
  }

  void removeAllData() {
    context.read<AppBloc>().add(const TriggerAppEvent(0));
    context.read<parent.AppParentBloc>().add(const parent.TriggerAppEvent(0));
    Global.storageService.remove(AppConstants.STORAGE_STUDENT_PROFILE_KEY);
    Global.storageService.remove(AppConstants.STORAGE_STUDENT_ID);
    Global.storageService.remove(AppConstants.STORAGE_TOPIC_KEY);
    Global.storageService.remove(AppConstants.STORAGE_PACKAGE_ID);
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_EMAIL);
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN);
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Profil Pengguna',
          ),
          BlocBuilder<ParentProfileBloc, ParentProfileState>(
            builder: (context, state) {
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
                                              height: 90,
                                            ),
                                            state is InitialUserItemState
                                                ? Text(
                                                    state.userItem!.name!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                  )
                                                : const SizedBox.shrink(),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            state.userItem?.email != null
                                                ? Text(
                                                    state.userItem!.email ?? '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                  )
                                                : const SizedBox.shrink(),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  shape: const StadiumBorder(),
                                                  backgroundColor:
                                                      kPrimaryColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return const ParentProfileUpdateScreen();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                    "Kemaskini Profil"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top:
                                          110, // Adjust for proper alignment at the top
                                      right: 10, // Aligns the icon to the right
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const ParentProfileUpdateScreen();
                                              },
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.settings,
                                          color: Colors.grey[700],
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          child: _buildAvatar(innerWidth, state),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            child: const OtherCard(
                              otherName: "Tukar Kata Laluan",
                              svgIconPath:
                                  'assets/images/settings/svg/language.svg',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ParentProfilePasswordScreen();
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: const OtherCard(
                              otherName: "Maklumat Bil",
                              svgIconPath:
                                  'assets/images/settings/svg/language.svg',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const BillingDetailScreen();
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: const OtherCard(
                              otherName: "Informasi",
                              svgIconPath:
                                  'assets/images/settings/svg/language.svg',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const InfoScreen();
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: const OtherCard(
                              otherName: "Log Keluar",
                              svgIconPath:
                                  'assets/images/settings/svg/language.svg',
                            ),
                            onTap: () {
                              Future.delayed(
                                const Duration(seconds: 0),
                                () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                      "Adakah anda pasti ingin log keluar?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context,
                                              false); // Close the dialog
                                        },
                                        child: Text(
                                          'TIDAK',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          removeAllData();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const LoginScreen();
                                              },
                                            ),
                                            (route) =>
                                                false, // This removes all the previous routes
                                          );
                                          showSnackBar(
                                              context,
                                              customSnackBar(
                                                  content: 'Log Keluar Berjaya',
                                                  color: Colors.green,
                                                  context: context));
                                        },
                                        child: Text(
                                          'YA',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

Widget _buildAvatar(double innerWidth, ParentProfileState state) {
  final String? avatarPath = state.userItem?.avatar;

  // Fallback conditions:
  // - null or empty
  // - paths like 'uploads/...'(not under assets/)
  final bool useDefault = avatarPath == null ||
      avatarPath.isEmpty ||
      !avatarPath.startsWith('assets/');

  final String effectivePath = useDefault
      ? AppConstants.DEFAULT_STUDENT_AVATAR
      : avatarPath;

  return Image.asset(
    effectivePath,
    width: innerWidth * 0.45,
    fit: BoxFit.fitWidth,
  );
}
