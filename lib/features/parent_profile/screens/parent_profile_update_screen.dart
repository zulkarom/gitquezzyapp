import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/constant/constants.dart';
import 'package:flutter_ta_plus/features/parent_profile/bloc/parent_profile_bloc.dart';
import 'package:flutter_ta_plus/features/parent_profile/controller/parent_profile_controller.dart';
import 'package:flutter_ta_plus/features/parent_profile/widgets/parent_profile_widget.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_app_bar.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_icon_button.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_input_field.dart';

class ParentProfileUpdateScreen extends StatelessWidget {
  const ParentProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Content();
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameController.text =
        context.read<ParentProfileBloc>().state.userItem?.name ?? '';
    emailController.text =
        context.read<ParentProfileBloc>().state.userItem?.email ?? '';
    ParentProfileController(context: context).initAvatar();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Kemaskini Profil Pengguna',
            leading: [
              Center(
                child: CustomIconButton(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     "/student_list_edit", (route) => false);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: AppDimension().kTwentyScreenPixel,
                    color:
                        Theme.of(context).appBarTheme.actionsIconTheme!.color,
                  ),
                ),
              )
            ],
          ),
          BlocListener<ParentProfileBloc, ParentProfileState>(
            listener: (context, state) {
              if (state is AvatarUrlState) {
                state.userItem!.avatar = state.avatarUrl;
                ParentProfileController(context: context).initAvatar();
              }
            },
            child: BlocBuilder<ParentProfileBloc, ParentProfileState>(
              builder: (context, state) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileIconAndEditButton(
                        context,
                        state.userItem?.avatar == ''
                            ? AppConstants.DEFAULT_STUDENT_AVATAR
                            : state.userItem?.avatar!,
                        state.avatarItem,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: nameController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.name,
                                hint: 'Nama Pengguna',
                                fieldIcon: Icons.person,
                                changeHandler: (value) {
                                  context
                                      .read<ParentProfileBloc>()
                                      .add(NameEvent(value));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: emailController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.emailAddress,
                                hint: 'Emel Pengguna',
                                fieldIcon: Icons.email,
                                changeHandler: (value) {
                                  context
                                      .read<ParentProfileBloc>()
                                      .add(EmailEvent(value));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: emailController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.emailAddress,
                                hint: 'Nombor Telefon',
                                fieldIcon: Icons.phone,
                                changeHandler: (value) {
                                  context
                                      .read<ParentProfileBloc>()
                                      .add(EmailEvent(value));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimension().kSixteenScreenHeight),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Hero(
                          tag: "save_btn",
                          child: ElevatedButton(
                            onPressed: () {
                              // ParentProfileController(context: context)
                              //     .asyncPostUpdateStudentData(
                              //   state.studentItem!.id!,
                              //   nameController.text,
                              //   schoolController.text,
                              //   passwordController.text,
                              //   state.studentItem!.avatar == ''
                              //       ? AppConstants.DEFAULT_STUDENT_AVATAR
                              //       : state.studentItem!.avatar!,
                              // );
                              FocusScope.of(context).unfocus();
                            },
                            child: Text(
                              "Simpan".toUpperCase(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
