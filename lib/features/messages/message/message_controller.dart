import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/entities.dart';
import '../../../global.dart';
import '../../../routes/routes.dart';
import 'cubit/message_cubits.dart';

class MessagesController {
  late BuildContext context;
  MessagesController({required this.context});
  final db = FirebaseFirestore.instance;
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  StreamSubscription<QuerySnapshot<Object?>>? listener1;
  StreamSubscription<QuerySnapshot<Object?>>? listener2;

  void init() {
    _snapShots();
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
      int toMsgNum = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int fromMsgNum = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == studentProfile.token) {
        toMsgNum = 0;
      } else {
        fromMsgNum = 0;
      }

      await db
          .collection("message")
          .doc(docId)
          .update({"to_msg_num": toMsgNum, "from_msg_num": fromMsgNum});
    }
  }

  Future<void> goChat(Message item) async {
    var nav = Navigator.of(context);
    if (item.doc_id != null) {
      if (listener1 != null && listener2 != null) {
        await listener1?.cancel();
        await listener2?.cancel();
      }
    }
    nav.pushNamed(AppRoutes.CHAT, arguments: {
      "doc_id": item.doc_id,
      "to_token": item.token!,
      "to_name": item.name!,
      "to_avatar": item.avatar!,
      "to_online": item.online!,
    }).then((value) => _snapShots());
  }

  void _snapShots() {
    var token = studentProfile.token;
    print('user token $token');

    final toMessageRef = db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: token);

    final fromMessageRef = db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token);
    listener1 = toMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });

    listener2 = fromMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });
  }

  _asyncLoadMsgData() async {
    var msgContext = context.read<MessageCubits>();

    final fromMessageRef = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: studentProfile.token)
        .get();
    // print("fromMessageRef.docs.length");
    // print(fromMessageRef.docs.length);

    final toMessageRef = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: studentProfile.token)
        .get();
    // print("toMessageRef.docs.length");
    // print(toMessageRef.docs.length);

    List<Message> messageList = <Message>[];
    if (fromMessageRef.docs.isNotEmpty) {
      var message = await _addMessage(fromMessageRef.docs);
      messageList.addAll(message);
    }
    if (toMessageRef.docs.isNotEmpty) {
      var message = await _addMessage(toMessageRef.docs);
      messageList.addAll(message);
    }
    //sorting the message according to the time
    messageList.sort((a, b) {
      if (b.last_time == null) return 0;
      if (a.last_time == null) return 0;
      //List x = ["ab", "a", "abc", "", "abcd"];
      //because of this, the latest or the newest chat would be at the top
      return b.last_time!.compareTo(a.last_time!);
    });
    msgContext.messageChanged(messageList);
    msgContext.loadStatusChanged(false);
  }

  Future<List<Message>> _addMessage(
      List<QueryDocumentSnapshot<Msg>> data) async {
    List<Message> messageList = <Message>[];
    for (var element in data) {
      //refers to main document
      var item = element.data();
      Message message = Message();
      message.doc_id = element.id;
      message.last_time = item.last_time;
      message.msg_num = item.msg_num;
      message.last_msg = item.last_msg;

      if (item.from_token == studentProfile.token) {
        //since the token match we are pulling out other guy's or teacher
        //information. Because you don't need to pull your own information
        //and show on the screen
        message.name = item.to_name;
        message.avatar = item.to_avatar;
        message.online = item.to_online ?? 0;
        message.msg_num = item.to_msg_num ?? 0;
        message.token = item.to_token;
      } else {
        message.name = item.from_name;
        message.avatar = item.from_avatar;
        message.online = item.from_online ?? 0;
        message.msg_num = item.from_msg_num ?? 0;
        message.token = item.from_token;
      }
      messageList.add(message);
    }

    return messageList;
  }
}
