import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/core/helper/text_scale.dart';
import 'package:quezzy_app/features/application/application_page.dart';
import 'package:quezzy_app/features/application/bloc/app_bloc.dart';
import 'package:quezzy_app/features/more/bloc/more_bloc.dart';
import 'package:quezzy_app/features/quiz_room/screens/invitation_list_screen.dart';
import 'package:quezzy_app/features/reusable/widgets/parent_password_field.dart';
import 'package:quezzy_app/features/student/screens/password_form.dart';
import 'package:quezzy_app/global.dart';
import 'package:quezzy_app/routes/routes.dart';
import 'package:page_transition/page_transition.dart';

import '../controllers/more_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Home',
              textScaleFactor: ScaleSize.textScaleFactor(context),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const ApplicationPage(),
                ),
              );
            },
          ),
          BlocBuilder<MoreBloc, MoreState>(
            builder: (context, state) {
              return Column(
                children: [
                  ExpansionTile(
                    title: const Text("Students"),
                    children: [
                      for (var studentItem in state.studentItem)
                        if (studentItem.id !=
                            Global.storageService.getStudentProfile().id)
                          Column(
                            children: [
                              ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      studentItem.name.toString(),
                                      textScaleFactor:
                                          ScaleSize.textScaleFactor(context),
                                    ),
                                    // Adjust the space as needed
                                    if (studentItem.password != null)
                                      Image.asset(
                                        "assets/images/others/icons/lock.png",
                                        color: kPrimaryColor,
                                        width:
                                            15, // Set the desired width for the icon
                                        height:
                                            15, // Set the desired height for the icon
                                      ),
                                  ],
                                ),
                                onTap: () {
                                  if (studentItem.password != null) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          backgroundColor: kLightAccent,
                                          child: SizedBox(
                                            width: 300, // Set the desired width
                                            height:
                                                200, // Set the desired height
                                            child: PasswordForm(studentItem, 2),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.PACKAGE_SELECTED,
                                      arguments: {
                                        "id": studentItem.id,
                                        "studentItem": studentItem,
                                        "type": 2,
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Change Packages"),
                    children: [
                      for (var subscribeItem in state.subPackageItem)
                        Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subscribeItem.name.toString(),
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Global.storageService.setString(
                                    AppConstants.STORAGE_PACKAGE_ID,
                                    jsonEncode(subscribeItem.package_id));
                                Global.storageService.setString(
                                    AppConstants.STORAGE_PACKAGE_NAME,
                                    subscribeItem.name ?? '');
                                Global.storageService.setString(
                                    AppConstants.STORAGE_STUDENT_ID,
                                    jsonEncode(
                                        Global.storageService.getStudentId()));
                                context
                                    .read<AppBloc>()
                                    .add(const TriggerAppEvent(0));
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/application",
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Invitation Page",
                          textScaleFactor: ScaleSize.textScaleFactor(context),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle onTap for "Invitation Page"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const InvitationListScreen();
                          },
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Back To Parent Page",
                          textScaleFactor: ScaleSize.textScaleFactor(context),
                        ),
                        // Add your icon here
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            backgroundColor: kLightAccent,
                            child: SizedBox(
                              width: 300, // Set the desired width
                              height: 200, // Set the desired height
                              child: ParentPasswordField(
                                msg: 'Enter your parent account password.',
                                passwordHandler: (String password) {
                                  // Accepts a String parameter

                                  MoreController(context: context)
                                      .asyncPostParentPassword(
                                    password,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
