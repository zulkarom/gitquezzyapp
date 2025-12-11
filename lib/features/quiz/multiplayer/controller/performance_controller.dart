import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ta_plus/core/api/quiz_room_api.dart';
import 'package:flutter_ta_plus/features/quiz/multiplayer/bloc/multiplayer_quiz_bloc.dart';
import 'package:flutter_ta_plus/features/quiz_room/bloc/quiz_room_bloc.dart';

import '../../../../core/models/entities.dart';
import '../../../../global.dart';
import '../../../reusable/widgets/flutter_toast.dart';

class PerformanceController {
  late BuildContext context;
  PerformanceController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();

  //get databse instance
  final db = FirebaseFirestore.instance;
  // late String docId;
  late var listener;
  void init(String docId) {
    // final data = ModalRoute.of(context)!.settings.arguments as Map;
    // // This is the doc_id obtained from the previous page
    // docId = data["doc_id"];
    // print(docId);

    _listOfFriendSnapShots(docId);
  }

  // Define a private function to listen to list of friends changes
  Future<void> _listOfFriendSnapShots(String docId) async {
    if (context.mounted) {
      context.read<MultiplayerQuizBloc>().add(const TriggerClearPlayerList());
    }

    var friends = db
        .collection("quizRooms")
        .doc(docId)
        .collection("playerlist")
        .withConverter(
            fromFirestore: Player.fromFirestore,
            toFirestore: (Player ply, options) => ply.toFirestore())
        .orderBy("status", descending: true);

    listener = friends.snapshots().listen(handleSnapshot, onError: (error) {
      toastInfo(msg: 'Listen failed $error');
    });
  }

  // Define a function to handle Firestore snapshot updates
  void handleSnapshot(QuerySnapshot event) {
    // print('receiving trigger from firebase');
    List<Player> tempPlyList = <Player>[];
    for (var change in event.docChanges) {
      switch (change.type) {
        case DocumentChangeType.added:
          // if (kDebugMode) {
          //   print('added ---: ${change.doc.data()}');
          // }
          if (change.doc.data() != null) {
            tempPlyList.add(change.doc.data() as Player? ?? Player());
            // Use Player() or a default Player constructor

            // if (kDebugMode) {
            //   //  print('added');
            // }
          }
          break;
        case DocumentChangeType.modified:
          // if (kDebugMode) {
          print('modified ---: ${change.doc.data()}');

          context
              .read<MultiplayerQuizBloc>()
              .add(TriggerUpdatePlayerList(change.doc.data() as Player));

          // if (kDebugMode) {
          //   // Optionally print a message indicating the removal.
          //   // print('Document removed: ${change.doc.id}');
          // }
          // }
          break;
        case DocumentChangeType.removed:
          print('removed ---: ${change.doc.data()}');

          // if (kDebugMode) {
          //   // Optionally print a message indicating the removal.
          //   // print('Document removed: ${change.doc.id}');
          // }
          break;
      }
    }
    if (tempPlyList.isNotEmpty) {
      tempPlyList.sort((a, b) {
        // First, compare by total_mark in descending order
        int compareByTotalMark = b.totalMark!.compareTo(a.totalMark!);

        // If total_mark is the same, compare by totalQuestion in descending order
        int compareByTotalQuestion =
            b.totalQuestion!.compareTo(a.totalQuestion!);

        // Return the result of the comparison
        return compareByTotalMark != 0
            ? compareByTotalMark
            : compareByTotalQuestion;
      });
    }
    for (var element in tempPlyList) {
      if (kDebugMode) {
        print('${element.name}');
        print('${element.totalQuestion}');
      }
      if (context.mounted) {
        context.read<MultiplayerQuizBloc>().add(TriggerPlayerList(element));
      }
    }
  }

  // Function to calculate the total number of questions
  int getTotalQuestions(List<Map<String, String>> listPerformance) {
    int totalQuestions = 0;
    for (var performance in listPerformance) {
      totalQuestions += int.parse(performance['totalQuestion'].toString());
    }
    return totalQuestions;
  }

  // Function to dispose of resources
  void dispose() {
    listener.cancel();
  }
}
