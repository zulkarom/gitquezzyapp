import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/entities.dart';
import '../../../../global.dart';
import '../../../reusable/widgets/flutter_toast.dart';
import '../bloc/chat_blocs.dart';
import '../bloc/chat_events.dart';

class ChatController {
  late BuildContext context;

  ChatController({required this.context});

  TextEditingController textEditingController = TextEditingController();
  ScrollController appScrollController = ScrollController();

  //get user profile
  StudentItem userProfile = Global.storageService.getStudentProfile();

  //get databse instance
  final db = FirebaseFirestore.instance;
  late var docId;
  late var listener;
  bool isLoadMore = true;

  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the id between two users and unique
    docId = data["doc_id"];

    _clearMsgNum(docId);
    _chatSnapShots();
  }

  _clearMsgNum(String docId) async {
    var messageRes = await db
        .collection('message')
        .doc(docId)
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .get();
    if (messageRes.data() != null) {
      var item = messageRes.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == userProfile.token) {
        to_msg_num = 0;
      } else {
        from_msg_num = 0;
      }

      await db
          .collection("message")
          .doc(docId)
          .update({"to_msg_num": to_msg_num, "from_msg_num": from_msg_num});
    }
  }

  void dispose() {
    textEditingController.dispose();
    appScrollController.dispose();
    _clearMsgNum(docId);
  }

  Future<void> _chatSnapShots() async {
    if (context.mounted) {
      context.read<ChatBlocs>().add(const TriggerClearMsgList());
    }

    var messages = db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .limit(15);
    //not printable
    //print(jsonEncode(messages));
    //the below method gets called when you come to this chat page or open it
    //or second messages from here
    listener = messages.snapshots().listen(handleSnapshot, onError: (error) {
      toastInfo(msg: 'Listen failed $error');
    });
    //offset starts from 0
    //maxScrollExtent starts from 0 until you start scrolling

    appScrollController.addListener(() {
      print('offset---${appScrollController.offset}---');
      print(
          'maxScrollExtent---${appScrollController.position.maxScrollExtent}---');
      print("isLoadMore");
      //offset starts as you scroll
      //offset tells you how much you scrolled
      if ((appScrollController.offset + 10) >
          (appScrollController.position.maxScrollExtent)) {
        if (isLoadMore) {
          if (context.mounted) {
            context.read<ChatBlocs>().add(const TriggerLoadMsgData(true));
          }

          //trigger loading icon on
          //set isLoadMore to false
          isLoadMore = false;
          //load server data
          _asyncLoadMoreData();
          if (context.mounted) {
            context.read<ChatBlocs>().add(const TriggerLoadMsgData(false));
          }
          //trigger loading icon off
        }
      }
    });
  }

  void handleSnapshot(QuerySnapshot event) {
    List<Msgcontent> tempMsgList = <Msgcontent>[];
    for (var change in event.docChanges) {
      switch (change.type) {
        case DocumentChangeType.added:
          if (kDebugMode) {
            // print('added ---: ${change.doc.data()}');
          }
          if (change.doc.data() != null) {
            tempMsgList.add(change.doc.data()! as Msgcontent);
            if (kDebugMode) {
              //  print('added');
            }
          }
          break;
        case DocumentChangeType.modified:
          // TODO: Handle this case.
          break;
        case DocumentChangeType.removed:
          // TODO: Handle this case.
          break;
      }
    }
    //the zero index contains the last message
    if (kDebugMode) {
      //  print('the length of the chat is ${tempMsgList[0].content}');
    }
    //the bottom one comes to the top
    for (var element in tempMsgList.reversed) {
      if (kDebugMode) {
        print('${element.content}----dgffdgfddg');
      }
      //the last (message) one will stay at the top on the UI because we reversed
      if (context.mounted) {
        context.read<ChatBlocs>().add(TriggerMsgContentList(element));
      }
    }
  }

  // Hi
  // hello
  // .,...
  //.....

  Future<void> _asyncLoadMoreData() async {
    var state = context.read<ChatBlocs>().state;
    var moreMessages = await db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .where("addtime",
            isLessThan: state.msgcontentList.last.addtime) // 13,...10
        .limit(15)
        .get();

    if (moreMessages.docs.isNotEmpty) {
      for (var element in moreMessages.docs) {
        //element.data() refers to a document in msglist
        var data = element.data();
        if (context.mounted) {
          context.read<ChatBlocs>().add(TriggerAddMsgContent(data));
        }
      }

      SchedulerBinding.instance.addPostFrameCallback((_) {
        isLoadMore = true;
      });
    }
  }

  sendMessage() async {
    if (textEditingController.text.isEmpty) {
      toastInfo(msg: "You cannot send an empty message");
    } else {
      String sendContent = textEditingController.text.trim();
      textEditingController.clear();

      // Create a message object with an empty docId field
      final content = Msgcontent(
        token: userProfile.token,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now(),
      );

      // Convert Msgcontent to a Map using the toFirestore method
      Map<String, dynamic> contentMap = content.toFirestore();

      // Reference to the collection where you want to add the message
      CollectionReference messagesCollection =
          db.collection("message").doc(docId).collection("msglist");

      // Add the message to the collection and get the generated document ID
      DocumentReference docRef = await messagesCollection.add(contentMap);
      String generatedDocId = docRef.id;

      // Update the docId field with the generated document ID
      await docRef.update({"docId": generatedDocId});

      // print('---after adding $generatedDocId---');

      var messageRes = await db
          .collection("message")
          .doc(docId)
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .get();

      if (messageRes.data() != null) {
        var item = messageRes.data()!;

        int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
        int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
        if (item.from_token == userProfile.token) {
          //sender message count
          from_msg_num = from_msg_num + 1;
        } else {
          // the other person's message count
          to_msg_num = to_msg_num + 1;
        }

        await db.collection("message").doc(docId).update({
          "to_msg_num": to_msg_num,
          "from_msg_num": from_msg_num,
          "last_time": Timestamp.now(),
          "last_msg": sendContent
        });
      }
    }
  }

/*
  sendMessage() async {
    if (textEditingController.text.isEmpty) {
      toastInfo(msg: "You can not send an empty message");
    } else {
      print('---my sent messages ${textEditingController.text.toString()}---');
      String sendContent = textEditingController.text.trim();
      textEditingController.clear();
      //create a message object
      final content = Msgcontent(
          token: userProfile.token,
          content: sendContent,
          type: "text",
          addtime: Timestamp.now());

      await db
          .collection("message")
          .doc(docId)
          .collection("msglist")
          .withConverter(
              fromFirestore: Msgcontent.fromFirestore,
              toFirestore: (Msgcontent msg, options) => msg.toFirestore())
          .add(content)
          .then((DocumentReference doc) {
        print('---after adding ${doc.id}---');
      });

      var messageRes = await db
          .collection("message")
          .doc(docId)
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .get();

      if (messageRes.data() != null) {
        var item = messageRes.data()!;

        int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
        int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
        if (item.from_token == userProfile.token) {
          //sender message count
          from_msg_num = from_msg_num + 1;
        } else {
          // the other person's message count
          to_msg_num = to_msg_num + 1;
        }

        await db.collection("message").doc(docId).update({
          "to_msg_num": to_msg_num,
          "from_msg_num": from_msg_num,
          "last_time": Timestamp.now(),
          "last_msg": sendContent
        });
      }
    }
  } */
}
