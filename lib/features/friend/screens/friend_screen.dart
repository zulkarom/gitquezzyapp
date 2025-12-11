import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/features/friend/widgets/friend_card.dart';

import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/custom_input_field.dart';
import '../bloc/friend_blocs.dart';
import '../bloc/friend_states.dart';
import '../controller/friend_controller.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  late FriendController _friendController;
  late final TextEditingController searchController;
  @override
  void didChangeDependencies() {
    searchController = TextEditingController();
    _friendController = FriendController(context: context);
    _friendController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, statelg) {
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(
                  title: 'Friends',
                  // statelg.language.name == 'eng'
                  //     ? widget.subjectItem.name_eng ?? ''
                  //     : widget.subjectItem.name_bm ?? '',
                  leading: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
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
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //   color: kLightField,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: AppDimension().kTwelveScreenWidth,
                        left: AppDimension().kTwelveScreenWidth),
                    child: CustomInputField(
                      controller: searchController,
                      textInputAction: TextInputAction.done,
                      inputType: TextInputType.emailAddress,
                      hint: 'Carian rakan mengunakan nama atau username....',
                      fieldIcon: Icons.search,
                      changeHandler: (value) {
                        if (value.isNotEmpty) {
                          FriendController(context: context)
                              .asynLoadListSearchFriends(value);
                        }
                      },
                      submitHandler: (value) {
                        if (value.isNotEmpty) {
                          FriendController(context: context)
                              .asynLoadListSearchFriends(value);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<FriendBlocs, FriendStates>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: state.friendItem.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // Handle the tap on the list item
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: AppDimension().kTwelveScreenWidth,
                                  left: AppDimension().kTwelveScreenWidth,
                                  bottom: AppDimension().kTwelveScreenHeight),
                              child: FriendCard(
                                friendName: state.friendItem[index].name ?? '',
                                friendDesc:
                                    state.friendItem[index].schoolName ?? '',
                                image: Image.asset(
                                  state.friendItem[index].avatar ?? '',
                                  width: AppDimension().kFortyEightScreenWidth,
                                ),
                                btnName: state.friendItem[index].status == 10
                                    ? '    Cancel    '
                                    : 'Add Friend',
                                // btnName: state.friendItemOne?.status == null
                                //     ? 'Add Friend'
                                //     : 'Requested',
                                buttonHandler: () {
                                  FriendController(context: context)
                                      .asyncPostFriendRequest(
                                          state.friendItem[index]);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
