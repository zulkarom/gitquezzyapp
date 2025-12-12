import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quezzy_app/core/models/entities.dart';

import '../../../global.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/flutter_toast.dart';

class CopyCont {
  late BuildContext context;
  CopyCont({required this.context});
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  var db = FirebaseFirestore.instance; // cloud firestore

  Future<void> goChat(StudentItem student) async {
    print('--${student.token}--');
    if (student.token == studentProfile.token) {
      toastInfo(msg: "Can't chat to yourself");
    }

    //you send messages to someone (get)
    var fromMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_token',
            isEqualTo: studentProfile.token) // the one trying to chat
        .where('to_token',
            isEqualTo: student.token) // the one trying to chat to
        .get();

    //someone send messages to you (get )
    var toMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('to_Token', isEqualTo: studentProfile.token) // sending to you
        .where('from_token', isEqualTo: student.token) // from the certain guy
        .get();

    //check if we had a chat before
    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      //we never had a chat
      var msgData = Msg(
          from_token: studentProfile.token,
          to_token: student.token,
          from_name: studentProfile.name,
          to_name: student.name,
          from_avatar: studentProfile.avatar,
          to_avatar: student.avatar,
          from_online: studentProfile.online,
          to_online: student.online,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);
      var docId = await db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgData);

      //navigate to chat page
      Navigator.of(context).pushNamed(AppRoutes.CHAT, arguments: {
        "doc_id": docId.id,
        "to_token": student.token ?? "",
        "to_name": student.name ?? "",
        "to_avatar": student.avatar ?? "",
        "to_online": student.online.toString(),
      });
      //
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Navigator.of(context).pushNamed(AppRoutes.CHAT, arguments: {
          "doc_id": fromMessages.docs.first.id,
          "to_token": student.token ?? "",
          "to_name": student.name ?? "",
          "to_avatar": student.avatar ?? "",
          "to_online": student.online.toString(),
        });
      }

      if (toMessages.docs.isNotEmpty) {
        Navigator.of(context).pushNamed(AppRoutes.CHAT, arguments: {
          "doc_id": toMessages.docs.first.id,
          "to_token": student.token ?? "",
          "to_name": student.name ?? "",
          "to_avatar": student.avatar ?? "",
          "to_online": student.online.toString(),
        });
      }
    }
  }
}
