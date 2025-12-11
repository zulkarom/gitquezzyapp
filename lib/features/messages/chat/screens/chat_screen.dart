import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/constant/colors.dart';
import '../../../reusable/widgets/custom_app_bar.dart';
import '../../../reusable/widgets/custom_icon_button.dart';
import '../../../reusable/widgets/text_field.dart';
import '../bloc/chat_blocs.dart';
import '../bloc/chat_events.dart';
import '../bloc/chat_states.dart';
import '../controller/chat_controller.dart';
import '../widgets/chat_widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatController _chatController;
  late String avatar;
  late String name;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    avatar = data["to_avatar"];
    name = data["to_name"];
    _chatController = ChatController(context: context);
    Future.delayed(Duration.zero, () {
      _chatController.init();
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocListener<ChatBlocs, ChatStates>(
        listener: (context, state) {},
        child: BlocBuilder<ChatBlocs, ChatStates>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                // backgroundColor: Colors.white,
                // appBar: buildAppBar("Chat"),
                body: Column(children: [
                  CustomAppBar(
                    title: name,
                    leading: [
                      CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
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
                      SizedBox(width: AppDimension().kEightScreenWidth),
                      BlocBuilder<ChatBlocs, ChatStates>(
                        builder: (context, state) {
                          return Container(
                            width: 40.w,
                            height: AppDimension().kFiftyScreenHeight,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                image: avatar.startsWith("assets/")
                                    ? DecorationImage(
                                        image: AssetImage(avatar),
                                        fit: BoxFit.fitHeight,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(avatar),
                                        fit: BoxFit.fitHeight,
                                      ),
                                borderRadius: BorderRadius.circular(15.h)),
                          );
                        },
                      )
                    ],
                    ending: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              // showPopupMenu(context);
                            },
                            child: Icon(
                              Icons.more_vert,
                              size: AppDimension().kTwentyScreenPixel,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .actionsIconTheme!
                                  .color,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        //widgets for showing  messages
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 70.h,
                            ), // margin for chats between with textfield
                            child: CustomScrollView(
                              //default behavior is showing the zero index first
                              //we can change with below set up
                              controller: _chatController.appScrollController,
                              shrinkWrap: true,
                              reverse: true,
                              slivers: [
                                SliverPadding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      var item = state.msgcontentList[index];
                                      if (_chatController.userProfile.token ==
                                          item.token) {
                                        return chatRightWidget(item, context);
                                      }
                                      return chatLeftWidget(item, context);
                                      // print("state.messageGroups.length");
                                      // print(state.messageGroups.length);
                                      // final group = state.messageGroups[index];
                                      // return Column(
                                      //   children: [
                                      //     SizedBox(
                                      //         height: AppDimension()
                                      //             .kTenScreenHeight),
                                      //     // Display the group's timestamp or datetime here.
                                      //     Text(
                                      //       DateFormat('d MMMM y').format(DateTime
                                      //           .fromMillisecondsSinceEpoch(
                                      //               group[0]
                                      //                   .addtime!
                                      //                   .millisecondsSinceEpoch)),
                                      //       style: const TextStyle(
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //     SizedBox(
                                      //         height: AppDimension()
                                      //             .kEightScreenHeight),
                                      //     // Build messages in this group.
                                      //     Column(
                                      //       children: group.map((message) {
                                      //         if (_chatController
                                      //                 .userProfile.token ==
                                      //             message.token) {
                                      //           return chatRightWidget(
                                      //               message, context);
                                      //         } else {
                                      //           return chatLeftWidget(
                                      //               message, context);
                                      //         }
                                      //       }).toList(),
                                      //     ),
                                      //   ],
                                      // );
                                    }, childCount: state.msgcontentList.length),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // context.read<ChatBlocs>().add(moreStatusChanged(false));
                            //to remove keyboard
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),

                        //text fields and send button
                        Positioned(
                            bottom: 0.h,
                            child: Container(
                              color: kLightBg,
                              width: 360.w,
                              //helps going the text fields size
                              constraints: BoxConstraints(
                                  maxHeight: 170.h, minHeight: 70.h),
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  bottom: 0.h,
                                  top: 10.h),
                              child: Row(
                                //space between the text box and the send button
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //text field plus icon button inside the row
                                  Container(
                                    width: 280.w,
                                    constraints: BoxConstraints(
                                        maxHeight: 170.h, minHeight: 50.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: kPrimaryColor),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        //this is for text box
                                        Container(
                                          constraints: BoxConstraints(
                                              maxHeight: 150.h,
                                              minHeight: 30.h),
                                          padding: EdgeInsets.only(left: 5.w),
                                          width: 220.w,
                                          child: appTextField(
                                              "Message..", "none", (value) {},
                                              maxLines: null,
                                              controller: _chatController
                                                  .textEditingController),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //toggle between files
                                            context.read<ChatBlocs>().add(
                                                TriggerMoreStatus(
                                                    state.more_status
                                                        ? false
                                                        : true));
                                          },
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            width: 40.w,
                                            height: 40.h,
                                            child: Image.asset(
                                                "assets/images/others/icons/05.png"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //send button
                                  GestureDetector(
                                    onTap: () {
                                      _chatController.sendMessage();
                                    },
                                    child: Container(
                                      width: 40.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(40.w),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(1, 1))
                                          ]),
                                      child: Image.asset(
                                          "assets/images/others/icons/send2.png"),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        state.more_status
                            ? Positioned(
                                right: 82.w,
                                bottom: 70.h,
                                height: 100.h,
                                width: 40.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    chatFileButtons(
                                        "assets/images/others/icons/file.png"),
                                    chatFileButtons(
                                        "assets/images/others/icons/photo.png"),
                                  ],
                                ))
                            : Container()
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
