import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/features/friend/widgets/friend_card.dart';
import 'package:flutter_ta_plus/features/quiz_room/bloc/quiz_room_bloc.dart';
import 'package:flutter_ta_plus/features/quiz_room/controllers/quiz_room_controller.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/custom_input_field.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key, required this.docId});
  final String docId;

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizRoomBloc(),
      child: _FriendListScaffold(widget.docId),
    );
  }
}

class _FriendListScaffold extends StatefulWidget {
  const _FriendListScaffold(this.docId);
  final String docId;

  @override
  _FriendListScaffoldState createState() => _FriendListScaffoldState();
}

class _FriendListScaffoldState extends State<_FriendListScaffold> {
  late QuizRoomController _quizRoomController;
  late final TextEditingController searchController;
  @override
  void didChangeDependencies() {
    searchController = TextEditingController();
    _quizRoomController = QuizRoomController(context: context);
    _quizRoomController.asynLoadListSearchFriends('', widget.docId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, statelg) {
          return BlocBuilder<QuizRoomBloc, QuizRoomState>(
            builder: (context, state) {
              return Scaffold(
                body: Column(
                  children: [
                    CustomAppBar(
                      title: 'Invite Friends',
                      ending: [
                        Center(
                          child: CustomIconButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
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
                          hint: 'Carian rakan',
                          fieldIcon: Icons.search,
                          changeHandler: (value) {
                            // if (value.isNotEmpty) {
                            _quizRoomController.asynLoadListSearchFriends(
                                value, widget.docId);
                            // }
                          },
                          submitHandler: (value) {
                            if (value.isNotEmpty) {
                              _quizRoomController.asynLoadListSearchFriends(
                                  value, widget.docId);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.friendItem!.length,
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
                                friendName: state.friendItem![index].name ?? '',
                                friendDesc:
                                    state.friendItem![index].schoolName ?? '',
                                image: Image.asset(
                                  state.friendItem![index].avatar ?? '',
                                  width: AppDimension().kFortyEightScreenWidth,
                                ),
                                btnName: state.friendItem![index].status == 10
                                    ? '    Cancel    '
                                    : 'Invite',
                                // btnName: state.friendItemOne?.status == null
                                //     ? 'Add Friend'
                                //     : 'Requested',
                                buttonHandler: () {
                                  // print(state.invitedFriendList.length);
                                  _quizRoomController.sendInvitation(
                                      state.friendItem![index], widget.docId);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
