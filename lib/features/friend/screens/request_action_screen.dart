import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/dialog_message.dart';

import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../core/constant/colors.dart';
import '../../../utils/show_snackbar.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/custom_snack_bar.dart';
import '../bloc/friend_blocs.dart';
import '../bloc/friend_states.dart';
import '../controller/request_controller.dart';
import '../widgets/action_friend_card.dart';

class RequestActionScreen extends StatefulWidget {
  const RequestActionScreen({super.key});

  @override
  State<RequestActionScreen> createState() => _RequestActionScreenState();
}

class _RequestActionScreenState extends State<RequestActionScreen> {
  @override
  Widget build(BuildContext context) {
    return const _RequestActionScaffold();
  }
}

class _RequestActionScaffold extends StatefulWidget {
  const _RequestActionScaffold();

  @override
  State<_RequestActionScaffold> createState() => __RequestActionScaffoldState();
}

class __RequestActionScaffoldState extends State<_RequestActionScaffold> {
  late RequestController _requestController;
  @override
  void didChangeDependencies() {
    _requestController = RequestController(context: context);
    _requestController.init();
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
                  title: 'Requested Friends',
                  // statelg.language.name == 'eng'
                  //     ? widget.subjectItem.name_eng ?? ''
                  //     : widget.subjectItem.name_bm ?? '',
                  leading: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              size: AppDimension().kTwentyScreenPixel,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .actionsIconTheme!
                                  .color,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                BlocListener<FriendBlocs, FriendStates>(
                  listener: (context, state) {
                    if (state is DoneActionFriendRequestStates) {
                      if (state.message == 'Cancel') {
                        showSnackBar(
                            context,
                            customSnackBar(
                                content: 'Friend Request ${state.message}',
                                context: context));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: BlocBuilder<FriendBlocs, FriendStates>(
                    builder: (context, state) {
                      if (state is DoneLoadingRequestedFriendStates) {
                        return Padding(
                          padding:
                              EdgeInsets.all(AppDimension().kTwelveScreenWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Text(
                              //   'List of Friends',
                              //   // AppLocalizations.of(context)!.listTopic,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .titleLarge!
                              //       .copyWith(
                              //         fontWeight: FontWeight.bold,
                              //         color: Theme.of(context).primaryColor,
                              //       ),
                              // ),
                              SizedBox(
                                  height: AppDimension().kFourScreenHeight),
                              ListView.builder(
                                itemCount: state.requestFriendItem.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                // shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) {
                                          //       return RequestActionScreen(
                                          //           state.topicItem![index]);
                                          //     },
                                          //   ),
                                          // );
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ActionFriendCard(
                                                friendName: state
                                                        .requestFriendItem[
                                                            index]
                                                        .name ??
                                                    '',
                                                friendDesc: state
                                                        .requestFriendItem[
                                                            index]
                                                        .schoolName ??
                                                    '',
                                                image: Image.asset(
                                                  state.requestFriendItem[index]
                                                          .avatar ??
                                                      '',
                                                  width: AppDimension()
                                                      .kFortyEightScreenWidth,
                                                ),
                                                rejectHandler: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            kLightAccent,
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5, // Adjust the fraction as needed
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              7, // Adjust the fraction as needed
                                                          child: DialogMessage(
                                                            message:
                                                                'Cancel Friend Request?',
                                                            leftHandler: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            rightHandler: () {
                                                              _requestController
                                                                  .asyncActionFriendRequest(
                                                                      state.requestFriendItem[
                                                                          index],
                                                                      20,
                                                                      'Cancel');
                                                            },
                                                            leftText: 'CLOSE',
                                                            rightText:
                                                                'CANCEL REQUEST',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                acceptHandler: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            kLightAccent,
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5, // Adjust the fraction as needed
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              7, // Adjust the fraction as needed
                                                          child: DialogMessage(
                                                            message:
                                                                'Accept Friend Request?',
                                                            leftHandler: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            rightHandler: () {
                                                              _requestController
                                                                  .asyncActionFriendRequest(
                                                                      state.requestFriendItem[
                                                                          index],
                                                                      30,
                                                                      'Accepted');
                                                            },
                                                            leftText: 'CLOSE',
                                                            rightText:
                                                                'ACCEPT REQUEST',
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
                                      ),
                                      SizedBox(
                                          height:
                                              AppDimension().kTenScreenHeight),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (state is LoadedRequestedFriendStates) {
                        return const SizedBox.shrink();
                      } else if (state is LoadingRequestedFriendStates) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const SizedBox.shrink();
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
