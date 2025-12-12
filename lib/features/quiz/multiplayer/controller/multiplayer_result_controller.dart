import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quezzy_app/core/api/level_api.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/features/quiz/multiplayer/bloc/multiplayer_result_bloc.dart';

import '../../../../core/api/result_api.dart';
import '../../../../core/firebase_services/answer_firestore.dart';
import '../../../../global.dart';
import '../../../reusable/widgets/flutter_toast.dart';

class MultiplayerResultController {
  late BuildContext context;
  MultiplayerResultController({required this.context});
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  late var docId;
  late LevelItem levelItem;
  var db = FirebaseFirestore.instance; //cloud firestore
  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    docId = data["room_doc_id"];
    levelItem = data["levelItem"];

    asynLoadResultData(levelItem);
  }

  setTotalScore(double? totalScore) async {
    // var state = context.read<MultiplayerResultBloc>().state;

    // Step 1: Check if the document already exists in the "playerlist" subcollection
    QuerySnapshot querySnapshot = await db
        .collection("quizRooms")
        .doc(docId)
        .collection("playerlist")
        .where("student_token", isEqualTo: studentProfile.token)
        .limit(1)
        .get();

    // Step 2: Determine whether to add a new document or update an existing one
    if (querySnapshot.docs.isNotEmpty) {
      // Retrieve the document ID from the first document in the query result
      String playerDocId = querySnapshot.docs.first.id;
      // If the document doesn't exist, add a new one
      final docReference = db
          .collection("quizRooms")
          .doc(docId)
          .collection("playerlist")
          .doc(playerDocId)
          .collection("answer") // Add another collection here
          .limit(1);

      var snapshot = await docReference.get();
      if (snapshot.docs.isNotEmpty) {
        // Access the first matching document
        var firstMatchingDocument = querySnapshot.docs.first.reference;

        await firstMatchingDocument.update({'total_mark': totalScore});
      }
    }
  }

  asynLoadResultData(LevelItem levelItem) async {
    context
        .read<MultiplayerResultBloc>()
        .add(const TriggerLoadingMyResultsEvent());
    QuestionRequestEntity questionRequestEntity = QuestionRequestEntity();
    //post levelId
    questionRequestEntity.id = levelItem.id;
    var result = await ResultAPI.questionList(questionRequestEntity);
    if (result.code == 200) {
      List<PlayerAnswer> answerList = [];

      await AnswerFirestore.getAnswerM(
        roomDocId: docId,
      ).then((value) {
        for (var answer in value) {
          answerList.add(answer);
        }
      });
      //save data to shared storage
      if (context.mounted) {
        context
            .read<MultiplayerResultBloc>()
            .add(TriggerLoadedMyResultsEvent(result.data!, answerList));

        Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<MultiplayerResultBloc>()
              .add(const TriggerDoneLoadingMyResultsEvent());
          // print('question itemsfdsffdds');
          // print(result.code);
        });
      }
    }
  }

  //Method for copy answer from multiplayer to individual answer.
  //After user finish the quiz game with his friends, the latest answer for each level will be copy to individual answer.
  asyncCopyAnswer(
      LevelItem levelItem,
      TopicItem topicItem,
      List<PlayerAnswer> listAnswer,
      double starScore,
      double totalScore) async {
    await AnswerFirestore.updateScore(
      levelItem: levelItem,
      topicItem: topicItem,
      studentProfile: Global.storageService.getStudentProfile(),
      starScore: starScore,
      totalScore: totalScore,
    ).then((value) async {
      if (value != null) {
        for (var answer in listAnswer) {
          await AnswerFirestore.sendAnswer(
              answer.questionId, answer.itemId, answer.isAnswer, value);
        }
      } else {
        if (kDebugMode) {
          print("error message here");
        }
      }
    });
  }

  Future<bool> asyncPostLevelResultData(
      int totalMark, LevelItem levelItem) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final levelResultItem = LevelResultItem();
      levelResultItem.studentId =
          int.parse(Global.storageService.getStudentId());
      levelResultItem.levelId = levelItem.id;
      levelResultItem.totalMark = totalMark;

      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await LevelAPI.addResultLevel(params: levelResultItem);
      if (result.code == 200) {
        try {
          if (context.mounted) {
            // Navigator.of(context)
            //     .pushNamedAndRemoveUntil("/student", (route) => false);
            EasyLoading.dismiss();
          }

          return true; // Return true to indicate successful creation
        } catch (e) {
          print("saving local storage error ${e.toString()}");
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed creation
  }
}
