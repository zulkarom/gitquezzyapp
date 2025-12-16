import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import 'package:quezzy_app/features/parent_profile/bloc/parent_profile_bloc.dart';
import 'package:quezzy_app/features/parent_profile/controller/parent_profile_controller.dart';
import 'package:quezzy_app/features/parent_profile/widgets/parent_profile_widget.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_app_bar.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_icon_button.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_input_field.dart';

class ParentProfilePasswordScreen extends StatelessWidget {
  const ParentProfilePasswordScreen({super.key});

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
  late final TextEditingController oldPassController;
  late final TextEditingController newPassController;
  late final TextEditingController repeatNewPassController;

  @override
  void initState() {
    super.initState();
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
    repeatNewPassController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // nameController.text =
    //     context.read<ParentProfileBloc>().state.userItem?.name ?? '';
    // emailController.text =
    //     context.read<ParentProfileBloc>().state.userItem?.email ?? '';
    // ParentProfileController(context: context).initAvatar();
  }

  @override
  void dispose() {
    // nameController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Kemaskini Kata Laluan',
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
              // if (state is AvatarUrlState) {
              //   state.userItem!.avatar = state.avatarUrl;
              //   ParentProfileController(context: context).initAvatar();
              // }
            },
            child: BlocBuilder<ParentProfileBloc, ParentProfileState>(
              builder: (context, state) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileIcon(
                          context,
                          state.userItem?.avatar == ''
                              ? AppConstants.DEFAULT_STUDENT_AVATAR
                              : state.userItem?.avatar!),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: oldPassController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.visiblePassword,
                                hint: 'Kata Laluan Lama',
                                isPassword: true,
                                fieldIcon: Icons.lock,
                                changeHandler: (value) {
                                  context
                                      .read<ParentProfileBloc>()
                                      .add(OldPasswordEvent(value));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: newPassController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.visiblePassword,
                                hint: 'Kata Laluan Baru',
                                isPassword: true,
                                fieldIcon: Icons.lock,
                                changeHandler: (value) {
                                  context
                                      .read<ParentProfileBloc>()
                                      .add(NewPasswordEvent(value));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultPadding,
                              ),
                              child: CustomInputField(
                                controller: repeatNewPassController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.visiblePassword,
                                hint: 'Ulang Kata Laluan Baru',
                                isPassword: true,
                                fieldIcon: Icons.lock,
                                changeHandler: (value) {
                                  context
                                      .read<ParentProfileBloc>()
                                      .add(ReNewPasswordEvent(value));
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
                              ParentProfileController(context: context)
                                  .changePassword();

                              FocusScope.of(context).unfocus();
                            },
                            child: Text(
                              "Tukar Kata Laluan".toUpperCase(),
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
