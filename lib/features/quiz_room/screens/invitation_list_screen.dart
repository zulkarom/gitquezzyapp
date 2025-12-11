import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/features/quiz_room/bloc/quiz_room_bloc.dart';
import 'package:flutter_ta_plus/features/quiz_room/controllers/invitation_controller.dart';
import 'package:flutter_ta_plus/features/quiz_room/widgets/invitation_card.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';

class InvitationListScreen extends StatefulWidget {
  const InvitationListScreen({super.key});

  @override
  State<InvitationListScreen> createState() => _InvitationListScreenState();
}

class _InvitationListScreenState extends State<InvitationListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizRoomBloc(),
      child: const _FriendListScaffold(),
    );
  }
}

class _FriendListScaffold extends StatefulWidget {
  const _FriendListScaffold();

  @override
  _FriendListScaffoldState createState() => _FriendListScaffoldState();
}

class _FriendListScaffoldState extends State<_FriendListScaffold> {
  late InvitationController _invitationController;
  @override
  void didChangeDependencies() {
    _invitationController = InvitationController(context: context);
    _invitationController.asynLoadInvitationList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, statelg) {
          return BlocListener<QuizRoomBloc, QuizRoomState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is DoneLoadingMyInvitationStates) {
                print('DoneLoadingMyInvitationStates');
                print(state.invitedLobby.length);
              }
            },
            child: BlocBuilder<QuizRoomBloc, QuizRoomState>(
              builder: (context, state) {
                return Scaffold(
                  body: Column(
                    children: [
                      CustomAppBar(
                        title: 'List of Invited Lobby',
                        leading: [
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
                      BlocBuilder<QuizRoomBloc, QuizRoomState>(
                        builder: (context, state) {
                          if (state is DoneLoadingMyInvitationStates) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: state.invitedLobby.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final invitedLobby = state.invitedLobby;
                                  return GestureDetector(
                                    onTap: () {
                                      // Handle the tap on the list item
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right:
                                              AppDimension().kTwelveScreenWidth,
                                          left:
                                              AppDimension().kTwelveScreenWidth,
                                          bottom: AppDimension()
                                              .kTwelveScreenHeight),
                                      child: InvitationCard(
                                        invitationName: invitedLobby[index]
                                            .packageId
                                            .toString(),
                                        invitationDesc: invitedLobby[index]
                                            .topicItem!
                                            .name_bm
                                            .toString(),
                                        btnName:
                                            invitedLobby[index].status == 10
                                                ? '    Join    '
                                                : 'Game Started',
                                        buttonHandler: () {
                                          // print(state.invitedFriendList.length);
                                          _invitationController
                                              .joinLobby(invitedLobby[index]);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is LoadedMyInvitationStates) {
                            return const SizedBox.shrink();
                          } else if (state is LoadingMyInvitationStates) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
