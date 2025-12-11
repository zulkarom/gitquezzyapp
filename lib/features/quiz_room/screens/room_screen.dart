import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/features/quiz_room/bloc/quiz_room_bloc.dart';
import 'package:flutter_ta_plus/features/quiz_room/controllers/quiz_room_controller.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/info_dialog.dart';
import 'package:flutter_ta_plus/global.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../core/models/entities.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/dialog_message.dart';
import '../widgets/timer_dialog.dart';
import 'friend_list_screen.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late QuizRoomController _quizRoomController;
  late String docId;
  late SubjectItem subjectItem;
  late TopicItem topicItem;
  late LevelItem levelItem;
  StudentItem studentProfile = Global.storageService.getStudentProfile();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    // This is the doc_id obtained from the previous page
    docId = data["doc_id"];
    subjectItem = data["subjectItem"];
    topicItem = data["topicItem"];
    levelItem = data["levelItem"];
    _quizRoomController = QuizRoomController(context: context);
    _quizRoomController.init();
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
                  title: 'Quiz Lobby',
                  // statelg.language.name == 'eng'
                  //     ? widget.subjectItem.name_eng ?? ''
                  //     : widget.subjectItem.name_bm ?? '',
                  ending: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          _quizRoomController.changeAdmin();
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
                BlocListener<QuizRoomBloc, QuizRoomState>(
                  listener: (context, state) {
                    if (state is DoneStatusInvitedFriendStates) {
                      print("DoneStatusInvitedFriendStates");
                    }
                    if (state is DoneTriggerChangeAdminStates) {
                      if (state.adminToken == studentProfile.token) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const InfoDialog(
                                title:
                                    'You have been assign as a leader for this lobby.');
                          },
                        );
                      }
                    }
                    if (state is DoneTriggerPlayButtonStates) {
                      _showTimerDialog(context);
                    }
                    if (state is DoneRemovedInvitedFriendStates) {
                      // if (!state.invitedFriendList
                      //     .map((e) => e.studentToken)
                      //     .contains(state.playerToken)) {
                      if (state.removePlayerToken == studentProfile.token) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const InfoDialog(
                                title:
                                    'You have been removed from this lobby.');
                          },
                        );
                      }
                    }
                  },
                  child: BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, stateLg) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      stateLg.language.name == 'eng'
                                          ? subjectItem.name_eng ?? ''
                                          : subjectItem.name_bm ?? '',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      stateLg.language.name == 'eng'
                                          ? topicItem.name_eng ?? ''
                                          : topicItem.name_bm ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      // style: TextStyle(
                                      //   fontSize: 22,
                                      //   fontWeight: FontWeight.w600,
                                      //   color: Colors.black.withOpacity(0.6),
                                    ),
                                    // Text(
                                    //   topicItem.name_bm!,
                                    //   style: TextStyle(
                                    //     fontSize: 18,
                                    //     fontStyle: FontStyle.italic,
                                    //   ),
                                    // ),
                                    Text(
                                      "Level ${levelItem.level_number}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            "Players",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "Leader",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "Status",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        BlocBuilder<QuizRoomBloc,
                                            QuizRoomState>(
                                          builder: (context, state) {
                                            if (state.adminToken ==
                                                studentProfile.token!) {
                                              return Expanded(
                                                child: Align(
                                                  child: InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        builder: (context) =>
                                                            SingleChildScrollView(
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              bottom: MediaQuery
                                                                      .of(context)
                                                                  .viewInsets
                                                                  .bottom,
                                                            ),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16),
                                                              ),
                                                            ),
                                                            child: BlocProvider<
                                                                    QuizRoomBloc>(
                                                                create: (context) =>
                                                                    QuizRoomBloc(),
                                                                child:
                                                                    Container(
                                                                        width:
                                                                            MediaQuery.of(context).size.width *
                                                                                1,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.7,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                        ),
                                                                        child: FriendListScreen(
                                                                            docId:
                                                                                docId))),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.5),
                                                        child: Text(
                                                          "Add Friends",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.45, // screen height, // Set a specific height for the list container
                                      child: BlocBuilder<QuizRoomBloc,
                                          QuizRoomState>(
                                        builder: (context, state) {
                                          return ListView.builder(
                                            itemCount:
                                                state.invitedFriendList.length,
                                            itemBuilder: (context, index) {
                                              final friend = state
                                                  .invitedFriendList[index];
                                              return Padding(
                                                padding: state.adminToken ==
                                                        studentProfile.token
                                                    ? const EdgeInsets.all(0)
                                                    : const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        friend.name!,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        Global.playerAdmin(
                                                            friend.isAdmin!),
                                                      ),
                                                    ),
                                                    // Add some spacing between name and status
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: friend
                                                                        .status! ==
                                                                    10
                                                                ? Colors.red
                                                                : friend.status! ==
                                                                        20
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .orange, // Customize the background color
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Add rounded corners
                                                          ),
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 8,
                                                              vertical:
                                                                  4), // Add padding
                                                          child: Text(
                                                            Global.playerStatus(
                                                                friend.status!),
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .white, // Customize text color
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    state.adminToken ==
                                                            studentProfile.token
                                                        ? Expanded(
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              onPressed: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return Dialog(
                                                                      backgroundColor:
                                                                          kLightAccent,
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width /
                                                                            5, // Adjust the fraction as needed
                                                                        height: MediaQuery.of(context).size.height /
                                                                            5, // Adjust the fraction as needed
                                                                        child:
                                                                            DialogMessage(
                                                                          message:
                                                                              'Remove this player from this lobby?',
                                                                          subMessage:
                                                                              friend.name,
                                                                          leftHandler:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          rightHandler:
                                                                              () {
                                                                            _quizRoomController.removePlayer(friend.studentToken!);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          leftText:
                                                                              'NO',
                                                                          rightText:
                                                                              'YES',
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              );
                                              // return ListTile(
                                              //   title:
                                              //   trailing: IconButton(
                                              //     icon: const Icon(
                                              //         Icons.remove),
                                              //     onPressed: () {
                                              //       setState(() {
                                              //         invitedFriends
                                              //             .removeAt(index);
                                              //       });
                                              //     },
                                              //   ),
                                              // );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<QuizRoomBloc, QuizRoomState>(
                  builder: (context, state) {
                    if (state.adminToken == studentProfile.token) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Handle play button click
                            _quizRoomController.playQuiz(levelItem);
                          },
                          child: const Text(
                            "Play",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showTimerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Set to false to prevent dismissal by tapping outside or pressing the back button
      builder: (BuildContext context) {
        return BlocBuilder<QuizRoomBloc, QuizRoomState>(
          builder: (context, state) {
            return Center(
                child: TimerDialog(
                    roomDocId: state.roomDocId,
                    subjectItem: subjectItem,
                    levelItem: state.levelItem!,
                    topicItem: topicItem));
          },
        );
      },
    );
  }
}
