import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/friend_api.dart';
import '../../../core/models/entities.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';
import '../bloc/friend_blocs.dart';
import '../bloc/friend_events.dart';

class FriendController {
  late BuildContext context;
  FriendController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();

  void init() {
    // asynLoadListSearchFriends();
    context.read<FriendBlocs>().add(const TriggerSearchEvents([]));
  }

  Future<void> asynLoadListSearchFriends(String item) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = item;
    searchRequestEntity.token = studentProfile.token;
    var result = await FriendAPI.searchfriend(params: searchRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<FriendBlocs>().add(TriggerSearchEvents(result.data!));
      }

      // print('${jsonEncode(result.data!)}');
    } else {
      toastInfo(msg: 'Internet error');
    }
  }

  // asynLoadListSearchFriends() async {
  //   context.read<FriendBloc>().add(const TriggerLoadingMyFriendEvent());
  //   StudentRequestEntity studentRequestEntity = StudentRequestEntity();

  //   var result = await FriendAPI.searchfriendList(studentRequestEntity);
  //   if (result.code == 200) {
  //     //save data to shared storage
  //     if (context.mounted) {
  //       context
  //           .read<FriendBloc>()
  //           .add(TriggerLoadedMyFriendEvent(result.data!));

  //       Future.delayed(const Duration(milliseconds: 10), () {
  //         context
  //             .read<FriendBloc>()
  //             .add(const TriggerDoneLoadingMyFriendEvent());
  //       });
  //     }
  //   }
  // }

  Future<bool> asyncPostFriendRequest(StudentItem item) async {
    // print(studentProfile);
    if (Global.storageService.getUserToken().isNotEmpty) {
      final friendItem = FriendItem();
      friendItem.studentToken = studentProfile.token;
      friendItem.friendToken =
          item.token; // to store friend token (get from student token)
      //0 = Add Friend || 10 = Requested || 20 = Unfriend || 30 = Friend
      if (item.status == 0 || item.status == 20) {
        friendItem.status = 10;
      } else if (item.status == 10) {
        friendItem.status = 20;
      } else {
        friendItem.status = 10;
      }

      // print(friendItem.studentToken);
      // print(friendItem.friendToken);

      var result = await FriendAPI.friendRequest(params: friendItem);
      if (result.code == 200) {
        try {
          if (context.mounted) {
            context
                .read<FriendBlocs>()
                .add(SendFriendRequestEvent(result.data!));
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
}
