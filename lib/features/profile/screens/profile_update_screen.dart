import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/profile/bloc/profile_bloc.dart';
import 'package:quezzy_app/features/profile/controllers/profile_controller.dart';
import 'package:quezzy_app/features/profile/widgets/profile_widget.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_app_bar.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_icon_button.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_input_field.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

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
  late final TextEditingController schoolController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    schoolController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameController.text = context.read<ProfileBloc>().state.studentItem!.name!;
    schoolController.text =
        context.read<ProfileBloc>().state.studentItem!.schoolName!;
    ProfileController(context: context).initAvatar();
  }

  @override
  void dispose() {
    nameController.dispose();
    schoolController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Kemaskini Profil',
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
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is AvatarUrlState) {
                state.studentItem!.avatar = state.avatarUrl;
                ProfileController(context: context).initAvatar();
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileIconAndEditButton(
                        context,
                        state.studentItem!.avatar == ''
                            ? AppConstants.DEFAULT_STUDENT_AVATAR
                            : state.studentItem!.avatar!,
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
                                hint: 'Nama Pelajar',
                                fieldIcon: Icons.person,
                                changeHandler: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(NameEvent(value));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: schoolController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.name,
                                hint: 'Nama Sekolah',
                                fieldIcon: Icons.school,
                                changeHandler: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(SchoolEvent(value));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: passwordController,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.visiblePassword,
                                hint: 'Pin Number (optional)',
                                fieldIcon: Icons.lock,
                                changeHandler: (value) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(PinEvent(value));
                                },
                              ),
                            )
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
                              ProfileController(context: context)
                                  .asyncPostUpdateStudentData(
                                state.studentItem!.id!,
                                nameController.text,
                                schoolController.text,
                                passwordController.text,
                                state.studentItem!.avatar == ''
                                    ? AppConstants.DEFAULT_STUDENT_AVATAR
                                    : state.studentItem!.avatar!,
                              );
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
