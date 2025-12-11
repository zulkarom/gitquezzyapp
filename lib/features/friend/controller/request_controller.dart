import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/friend_api.dart';
import '../../../core/models/entities.dart';
import '../../../global.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/flutter_toast.dart';
import '../bloc/friend_blocs.dart';
import '../bloc/friend_events.dart';

class RequestController {
  late BuildContext context;
  RequestController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  var db = FirebaseFirestore.instance; //cloud firestore

  void init() {
    asynLoadListRequestedFriends();
  }

  asynLoadListRequestedFriends() async {
    context.read<FriendBlocs>().add(const TriggerLoadingRequestedFriendEvent());
    FriendRequestEntity friendRequestEntity = FriendRequestEntity();
    friendRequestEntity.token = studentProfile.token;

    var result = await FriendAPI.requestedfriendList(friendRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context
            .read<FriendBlocs>()
            .add(TriggerLoadedRequestedFriendEvent(result.data!));

        Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<FriendBlocs>()
              .add(const TriggerDoneLoadingRequestedFriendEvent());
        });
      }
    }
  }

  Future<bool> asyncActionFriendRequest(
      FriendItem item, int status, String message) async {
    // print(studentProfile);
    if (Global.storageService.getUserToken().isNotEmpty) {
      final friendItem = FriendItem();
      friendItem.id = item.id;
      friendItem.status =
          status; // to store friend token (get from student token)
      //0 = Add Friend || 10 = Requested || 20 = Unfriend || 30 = Friend

      var result = await FriendAPI.actionFriendRequest(params: friendItem);
      if (result.code == 200) {
        try {
          if (context.mounted) {
            context
                .read<FriendBlocs>()
                .add(ActionFriendRequestEvent(result.data!, message));
            if (status == 30) {
              goChat(item);
            }
          }
          return true; // Return true to indicate successful creation
        } catch (e) {
          toastInfo(msg: "Saving local storage error ${e.toString()}");
        }
      } else if (result.code == 400) {
        // EasyLoading.dismiss();
        toastInfo(msg: "Incorrect");
      } else {
        // EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed creation
  }

  Future<void> goChat(FriendItem friend) async {
    // print('--${friend.friendToken}--');
    // if (author.token == userProfile.token) {
    //   toastInfo(msg: "Can't chat to yourself");
    //   return;
    // }
    var nav = Navigator.of(context);
    //you sent to someone special
    var fromMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_token',
            isEqualTo: studentProfile.token) //the one trying to chat
        .where("to_token",
            isEqualTo: friend.friendToken) //the one trying to chat to
        .get();
    //someone special sent messages to you
    var toMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('to_token', isEqualTo: studentProfile.token) //sending to you
        .where("from_token",
            isEqualTo: friend.friendToken) //from the certain guy
        .get();
    //check if we had a chat before
    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      // print("token check");
      // print(studentProfile.token);
      // print(friend.friendToken);
      //we never had a chat
      var msgData = Msg(
          from_token: studentProfile.token,
          to_token: friend
              .studentToken, //editable friend.friendToken -> friend.studentToken
          from_name: studentProfile.name,
          to_name: friend.name,
          from_avatar: studentProfile.avatar,
          to_avatar: friend.avatar,
          from_online: studentProfile.online,
          to_online: friend.online,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);
      var docId = await db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgData);

      nav.pushNamed(AppRoutes.CHAT, arguments: {
        "doc_id": docId.id,
        "to_token": friend.friendToken ?? "",
        "to_name": friend.name ?? "",
        "to_avatar": friend.avatar ?? "",
        "to_online": friend.online.toString()
      });

      //navigate to chat page
    } else {
      if (fromMessages.docs.isNotEmpty) {
        nav.pushNamed(AppRoutes.CHAT, arguments: {
          "doc_id": fromMessages.docs.first.id,
          "to_token": friend.friendToken ?? "",
          "to_name": friend.name ?? "",
          "to_avatar": friend.avatar ?? "",
          "to_online": friend.online.toString()
        });
      }

      if (toMessages.docs.isNotEmpty) {
        nav.pushNamed(AppRoutes.CHAT, arguments: {
          "doc_id": toMessages.docs.first.id,
          "to_token": friend.friendToken ?? "",
          "to_name": friend.name ?? "",
          "to_avatar": friend.avatar ?? "",
          "to_online": friend.online.toString()
        });
      }
    }
    toastInfo(msg: "Redirecting to chat page...");
  }
}
