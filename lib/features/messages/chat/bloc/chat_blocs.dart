import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/models/chat/msgcontent.dart';

import 'chat_events.dart';
import 'chat_states.dart';

class ChatBlocs extends Bloc<ChatEvents, ChatStates> {
  ChatBlocs() : super(const ChatStates()) {
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerMsgContentListByDate>(_triggerMsgContentListByDate);
    on<TriggerAddMsgContent>(_triggerAddMsgContent);
    on<TriggerMoreStatus>(_triggerMoreStatus);
    on<TriggerClearMsgList>(_triggerClearMsgList);
    on<TriggerLoadMsgData>(_triggerLoadMsgData);
  }

  void _triggerMsgContentList(
      TriggerMsgContentList event, Emitter<ChatStates> emit) {
    //get the total messages
    var msgcontentList = state.msgcontentList.toList();
    //below is the single message
    msgcontentList.insert(0, event.msgContentList);

    // // var messageGroups = state.messageGroups;
    // List<List<Msgcontent>> messageGroups = [];

    // // Sort the messages by timestamp or datetime.
    // msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

    // // Initialize a variable to keep track of the current group's timestamp.
    // DateTime? currentTimestamp;

    // // Function to check if two DateTime instances are on the same day.
    // bool isSameDay(DateTime date1, DateTime date2) {
    //   return date1.year == date2.year &&
    //       date1.month == date2.month &&
    //       date1.day == date2.day;
    // }

    // Iterate through the sorted messages to group them by timestamp.
    // for (var message in msgcontentList) {
    //   if (currentTimestamp == null ||
    //       !isSameDay(
    //           currentTimestamp,
    //           DateTime.fromMillisecondsSinceEpoch(
    //               message.addtime!.millisecondsSinceEpoch))) {
    //     // Create a new group for messages with a different timestamp.
    //     currentTimestamp = DateTime.fromMillisecondsSinceEpoch(
    //         message.addtime!.millisecondsSinceEpoch);
    //     messageGroups.add([message]);
    //   } else {
    //     // Add the message to the current group.
    //     messageGroups.last.add(message);
    //   }
    // }

    //res.add(event.msgContentList);
    emit(state.copyWith(
        msgcontentList: msgcontentList, messageGroups: state.messageGroups));
  }

  void _triggerMsgContentListByDate(
      TriggerMsgContentListByDate event, Emitter<ChatStates> emit) {
    var messageGroups = state.messageGroups;
    // Sort the messages by timestamp or datetime.

    state.msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

    // Initialize a variable to keep track of the current group's timestamp.
    DateTime? currentTimestamp;

    // Function to check if two DateTime instances are on the same day.
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    // Iterate through the sorted messages to group them by timestamp.
    for (var message in state.msgcontentList) {
      if (currentTimestamp == null ||
          !isSameDay(
              currentTimestamp,
              DateTime.fromMillisecondsSinceEpoch(
                  message.addtime!.millisecondsSinceEpoch))) {
        // Create a new group for messages with a different timestamp.
        currentTimestamp = DateTime.fromMillisecondsSinceEpoch(
            message.addtime!.millisecondsSinceEpoch);
        messageGroups.add([message]);
      } else {
        // Add the message to the current group.
        messageGroups.last.add(message);
      }
    }

    //res.add(event.msgContentList);
    emit(state.copyWith(messageGroups: messageGroups));
  }

  void _triggerAddMsgContent(
      TriggerAddMsgContent event, Emitter<ChatStates> emit) {
    var res = state.msgcontentList.toList();
    res.add(event.msgContent);
    emit(state.copyWith(msgcontentList: res));
  }

  void _triggerMoreStatus(TriggerMoreStatus event, Emitter<ChatStates> emit) {
    emit(state.copyWith(more_status: event.moreStatus));
  }

  //we need to trigger to null or empty the list, otherwise we will have duplicate message
  void _triggerClearMsgList(
      TriggerClearMsgList event, Emitter<ChatStates> emit) {
    emit(state.copyWith(msgcontentList: [], messageGroups: []));
  }

  void _triggerLoadMsgData(TriggerLoadMsgData event, Emitter<ChatStates> emit) {
    emit(state.copyWith(
        is_loading: event.isloading, messageGroups: state.messageGroups));
  }
}
