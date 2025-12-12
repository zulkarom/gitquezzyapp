import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/models/chat/msgcontent.dart';

import 'chat_events.dart';
import 'chat_states.dart';

class ChatBlocs extends Bloc<ChatEvents, ChatStates> {
  ChatBlocs() : super(const ChatStates()) {
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerAddMsgContent>(_triggerAddMsgContent);
  }

  void _triggerMsgContentList(
      TriggerMsgContentList event, Emitter<ChatStates> emit) {
    //get the total messages
    var msgcontentList = state.msgcontentList.toList();
    //below is the single message
    msgcontentList.insert(0, event.msgContentList);

    // var messageGroups = state.messageGroups;
    List<List<Msgcontent>> messageGroups = [];

    // Sort the messages by timestamp or datetime.
    msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

    // Initialize a variable to keep track of the current group's timestamp.
    DateTime? currentTimestamp;

    // Function to check if two DateTime instances are on the same day.
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    // Iterate through the sorted messages to group them by timestamp.
    for (var message in msgcontentList) {
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
    emit(state.copyWith(
        msgcontentList: msgcontentList, messageGroups: messageGroups));
  }

  void _triggerAddMsgContent(
      TriggerAddMsgContent event, Emitter<ChatStates> emit) {
    // Get the current list of messages.
    var msgcontentList = state.msgcontentList.toList();

    // Append the new messages to the end of the list.
    msgcontentList.add(event.msgContent);
    // Sort the messages by timestamp.
    msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

    // Group the messages by timestamp.
    List<List<Msgcontent>> messageGroups =
        groupMessagesByTimestamp(msgcontentList);

    emit(state.copyWith(
      msgcontentList: msgcontentList,
      messageGroups: messageGroups,
    ));
  }

  List<List<Msgcontent>> groupMessagesByTimestamp(List<Msgcontent> messages) {
    List<List<Msgcontent>> messageGroups = [];

    // Initialize a variable to keep track of the current group's timestamp.
    DateTime? currentTimestamp;

    // Function to check if two DateTime instances are on the same day.
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    // Iterate through the sorted messages to group them by timestamp.
    for (var message in messages) {
      if (currentTimestamp == null ||
          !isSameDay(
            currentTimestamp,
            DateTime.fromMillisecondsSinceEpoch(
              message.addtime!.millisecondsSinceEpoch,
            ),
          )) {
        // Create a new group for messages with a different timestamp.
        currentTimestamp = DateTime.fromMillisecondsSinceEpoch(
          message.addtime!.millisecondsSinceEpoch,
        );
        messageGroups.add([message]);
      } else {
        // Add the message to the current group.
        messageGroups.last.add(message);
      }
    }

    return messageGroups;
  }

//   void _triggerAddMsgContent(
//       TriggerAddMsgContent event, Emitter<ChatStates> emit) {
//     var msgcontentList = List<Msgcontent>.from(state.msgcontentList);
//     msgcontentList.add(event.msgContent);

//     // Make a copy of the existing messageGroups.
//     var messageGroups = <List<Msgcontent>>[];
//     var messageGroups = List<List<Msgcontent>>.from(state.messageGroups);

//     // Sort the messages by timestamp.
//     // msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

//     // Function to check if two DateTime instances are on the same day.
//     bool isSameDay(DateTime date1, DateTime date2) {
//       return date1.year == date2.year &&
//           date1.month == date2.month &&
//           date1.day == date2.day;
//     }

// // Initialize a variable to keep track of the current group's timestamp.
//     DateTime? currentTimestamp;

// // Iterate through the sorted messages to group them by timestamp.

//     for (var message in msgcontentList) {
//       DateTime dateTime = message.addtime!.toDate(); // Convert to DateTime
//       DateTime messageDateOnly =
//           DateTime(dateTime.year, dateTime.month, dateTime.day);

//       if (currentTimestamp == null ||
//           !isSameDay(currentTimestamp, messageDateOnly)) {
//         // Create a new group for messages with a different timestamp.
//         currentTimestamp =
//             DateTime(dateTime.year, dateTime.month, dateTime.day);

//         // Check if a group with the same content already exists
//         int existingGroupIndex = messageGroups.indexWhere((group) => isSameDay(
//             DateTime.fromMillisecondsSinceEpoch(
//                 group[0].addtime!.toDate().millisecondsSinceEpoch),
//             DateTime.fromMillisecondsSinceEpoch(
//                 currentTimestamp!.millisecondsSinceEpoch)));

//         if (existingGroupIndex == -1) {
//           // Group doesn't exist, so create a new group and add the message.
//           messageGroups.add([message]);
//         } else {
//           // Group exists, so check if the message is already in the group.
//           bool messageExists = messageGroups[existingGroupIndex]
//               .any((msg) => msg.docId == message.docId);

//           if (!messageExists) {
//             // Message doesn't exist in the group, so add it.
//             messageGroups[existingGroupIndex].add(message);
//           }
//         }
//       } else {
//         // If the timestamp is the same as the current group, add the message to that group.
//         messageGroups.last.add(message);
//       }
//     }

//     emit(state.copyWith(
//         msgcontentList: msgcontentList, messageGroups: messageGroups));
//   }

// void _triggerAddMsgContent(
//       TriggerAddMsgContent event, Emitter<ChatStates> emit) {
//     var msgcontentList = List<Msgcontent>.from(state.msgcontentList);
//     msgcontentList.add(event.msgContent);

//     // Make a copy of the existing messageGroups.
//     var messageGroups = List<List<Msgcontent>>.from(state.messageGroups);

//     // Sort the messages by timestamp.
//     // msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

//     // Function to check if two DateTime instances are on the same day.
//     bool isSameDay(DateTime date1, DateTime date2) {
//       return date1.year == date2.year &&
//           date1.month == date2.month &&
//           date1.day == date2.day;
//     }

// // Initialize a variable to keep track of the current group's timestamp.
//     DateTime? currentTimestamp;

// // Iterate through the sorted messages to group them by timestamp.
//     for (var message in msgcontentList) {
//       DateTime dateTime = message.addtime!.toDate(); // Convert to DateTime
//       DateTime messageDateOnly =
//           DateTime(dateTime.year, dateTime.month, dateTime.day);

//       if (currentTimestamp == null ||
//           !isSameDay(
//             currentTimestamp,
//             messageDateOnly,
//           )) {
//         // Create a new group for messages with a different timestamp.
//         currentTimestamp =
//             DateTime(dateTime.year, dateTime.month, dateTime.day);

//         // Check if a group with the same content already exists
//         int existingGroupIndex = messageGroups.indexWhere((group) => isSameDay(
//             DateTime.fromMillisecondsSinceEpoch(DateTime(
//                     group[0].addtime!.toDate().year,
//                     group[0].addtime!.toDate().month,
//                     group[0].addtime!.toDate().day)
//                 .millisecondsSinceEpoch),
//             DateTime.fromMillisecondsSinceEpoch(
//                 currentTimestamp!.millisecondsSinceEpoch)));

//         print('testtttsdfsdf');
//         print(existingGroupIndex);

//         if (existingGroupIndex == -1) {
//           print('existing');
//           print(event.msgContent.content);
//           // Group doesn't exist, so create a new group and add the message.
//           messageGroups.add([message]);
//         } else {
//           print('not existing yet');
//           print(event.msgContent.content);
//           // Group exists, so check if the message is already in the group.
//           bool messageExists = messageGroups[existingGroupIndex].any((msg) =>
//               msg.docId ==
//               message
//                   .docId); // Adjust the condition as per your message comparison logic.
//           print('messageExist');
//           print(messageExists);

//           if (!messageExists) {
//             // Message doesn't exist in the group, so add it.
//             messageGroups[existingGroupIndex].add(message);
//           }
//         }
//       }
//     }

//     emit(state.copyWith(
//         msgcontentList: msgcontentList, messageGroups: messageGroups));
//   }

// void _triggerAddMsgContent(
//       TriggerAddMsgContent event, Emitter<ChatStates> emit) {
//     var msgcontentList = List<Msgcontent>.from(state.msgcontentList);
//     msgcontentList.add(event.msgContent);

//     // Make a copy of the existing messageGroups.
//     var messageGroups = List<List<Msgcontent>>.from(state.messageGroups);

//     // Sort the messages by timestamp.
//     // msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

//     // Function to check if two DateTime instances are on the same day.
//     bool isSameDay(DateTime date1, DateTime date2) {
//       return date1.year == date2.year &&
//           date1.month == date2.month &&
//           date1.day == date2.day;
//     }

// // Initialize a variable to keep track of the current group's timestamp.
//     DateTime? currentTimestamp;

// // Iterate through the sorted messages to group them by timestamp.
//     for (var message in msgcontentList) {
//       if (currentTimestamp == null ||
//           !isSameDay(
//             currentTimestamp,
//             DateTime.fromMillisecondsSinceEpoch(
//                 message.addtime!.millisecondsSinceEpoch),
//           )) {
//         // Create a new group for messages with a different timestamp.
//         currentTimestamp = DateTime.fromMillisecondsSinceEpoch(
//             message.addtime!.millisecondsSinceEpoch);

//         // Check if a group with the same content already exists
//         int existingGroupIndex = messageGroups.indexWhere((group) => isSameDay(
//             DateTime.fromMillisecondsSinceEpoch(
//                 group[0].addtime!.millisecondsSinceEpoch),
//             currentTimestamp!));
//         print('testtttsdfsdf');
//         print(existingGroupIndex);

//         if (existingGroupIndex == -1) {
//           print('existing');
//           print(event.msgContent.content);
//           // Group doesn't exist, so create a new group and add the message.
//           messageGroups.add([message]);
//         } else {
//           print('not existing yet');
//           print(event.msgContent.content);
//           // Group exists, so check if the message is already in the group.
//           bool messageExists = messageGroups[existingGroupIndex].any((msg) =>
//               msg.docId ==
//               message
//                   .docId); // Adjust the condition as per your message comparison logic.
//           print('messageExist');
//           print(messageExists);

//           if (!messageExists) {
//             // Message doesn't exist in the group, so add it.
//             messageGroups[existingGroupIndex].add(message);
//           }
//         }
//       }
//     }

//     emit(state.copyWith(
//         msgcontentList: msgcontentList, messageGroups: messageGroups));
//   }

//   void _triggerAddMsgContent(
//       TriggerAddMsgContent event, Emitter<ChatStates> emit) {
//     var msgcontentList = List<Msgcontent>.from(state.msgcontentList);
//     msgcontentList.add(event.msgContent);

//     // Make a copy of the existing messageGroups.
//     var messageGroups = List<List<Msgcontent>>.from(state.messageGroups);

//     // Sort the messages by timestamp.
//     // msgcontentList.sort((a, b) => a.addtime!.compareTo(b.addtime!));

//     // Function to check if two DateTime instances are on the same day.
//     bool isSameDay(DateTime date1, DateTime date2) {
//       return date1.year == date2.year &&
//           date1.month == date2.month &&
//           date1.day == date2.day;
//     }

// // Initialize a variable to keep track of the current group's timestamp.
//     DateTime? currentTimestamp;

// // Iterate through the sorted messages to group them by timestamp.
//     for (var message in msgcontentList) {
//       if (currentTimestamp == null ||
//           !isSameDay(
//             currentTimestamp,
//             DateTime.fromMillisecondsSinceEpoch(
//                 message.addtime!.millisecondsSinceEpoch),
//           )) {
//         // Create a new group for messages with a different timestamp.
//         currentTimestamp = DateTime.fromMillisecondsSinceEpoch(
//             message.addtime!.millisecondsSinceEpoch);

//         // Check if a group with the same content already exists
//         int existingGroupIndex = messageGroups.indexWhere((group) => isSameDay(
//             DateTime.fromMillisecondsSinceEpoch(
//                 message.addtime!.millisecondsSinceEpoch),
//             currentTimestamp!));

//         if (existingGroupIndex == -1) {
//           // Group doesn't exist, so create a new group and add the message.
//           messageGroups.add([message]);
//         } else {
//           // Group exists, so check if the message is already in the group.
//           bool messageExists = messageGroups[existingGroupIndex].any((msg) =>
//               msg.docId ==
//               message
//                   .docId); // Adjust the condition as per your message comparison logic.

//           if (!messageExists) {
//             // Message doesn't exist in the group, so add it.
//             messageGroups[existingGroupIndex].add(message);
//           }
//         }
//       }
//     }

//     emit(state.copyWith(
//         msgcontentList: msgcontentList, messageGroups: messageGroups));
//   }
}
