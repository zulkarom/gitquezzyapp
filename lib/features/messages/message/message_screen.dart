import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import 'cubit/message_cubits.dart';
import 'cubit/message_states.dart';
import 'message_controller.dart';
import 'widgets/message_widgets.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MessageCubits>(
      create: (context) => MessageCubits(),
      child: const _MessagesScaffold(),
    );
  }
}

class _MessagesScaffold extends StatefulWidget {
  const _MessagesScaffold({Key? key}) : super(key: key);

  @override
  State<_MessagesScaffold> createState() => _MessagesScaffoldState();
}

class _MessagesScaffoldState extends State<_MessagesScaffold> {
  late MessagesController _messagesController;

  @override
  void didChangeDependencies() {
    _messagesController = MessagesController(context: context);
    _messagesController.init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          BlocBuilder<MessageCubits, MessageStates>(builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.white,
          // appBar: buildAppBar("Messages"),
          body: Column(
            children: [
              CustomAppBar(
                title: "Messages",
                leading: [
                  Center(
                    child: CustomIconButton(
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
                  )
                ],
                ending: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          showPopupMenu(context);
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
              state.loadStatus == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 0.h),
                            sliver: SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                var item = state.message.elementAt(index);
                                // print("message length");
                                // print(state.message.length);
                                return buildChatList(
                                  context,
                                  item,
                                  _messagesController,
                                );
                              }, childCount: state.message.length),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
