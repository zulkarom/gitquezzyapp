import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/api/question_api.dart';
import '../../../../global.dart';
import '../bloc/multiplayer_quiz_bloc.dart';

class MultiplayerQuizController {
  late BuildContext context;
  MultiplayerQuizController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  var db = FirebaseFirestore.instance; //cloud firestore
  late var docId;
  late var listener;
  late LevelItem levelItem;
  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    docId = data["room_doc_id"];
    levelItem = data["levelItem"];
    asynLoadQuestionData(levelItem);
  }

  asynLoadQuestionData(LevelItem levelItem) async {
    context
        .read<MultiplayerQuizBloc>()
        .add(const TriggerLoadingMyQuestionsEvent());
    QuestionRequestEntity questionRequestEntity = QuestionRequestEntity();
    //post package_id
    questionRequestEntity.id = levelItem.id;
    var result = await QuestionAPI.questionList(questionRequestEntity);
    if (result.code == 200) {
      // print('question items');
      // print(result.code);
      //save data to shared storage
      if (context.mounted) {
        context.read<MultiplayerQuizBloc>().add(
              TriggerLoadedMyQuestionsEvent(result.data!),
            );

        Future.delayed(
          const Duration(milliseconds: 10),
          () {
            context
                .read<MultiplayerQuizBloc>()
                .add(const TriggerDoneLoadingMyQuestionsEvent());
          },
        );
      }
    }
  }

  sendAnswer(bool isSelected, int btnType) async {
    var state = context.read<MultiplayerQuizBloc>().state;

    final content = Answercontent(
      questionId: state.selectedAnswer!.question_id,
      itemId: state.selectedAnswer!.id,
      isAnswer: state.selectedAnswer!.is_answer!,
    );

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
      final docReference = await db
          .collection("quizRooms")
          .doc(docId)
          .collection("playerlist")
          .doc(playerDocId)
          .collection("answer") // Add another collection here
          .withConverter(
            fromFirestore: Answercontent.fromFirestore,
            toFirestore: (Answercontent ans, options) => ans.toFirestore(),
          )
          .add(content);

      var snapshot = await docReference.get();
      if (snapshot.exists) {
        // Access the first matching document
        var firstMatchingDocument = querySnapshot.docs.first.reference;

        // Retrieve the current value of 'total_question'
        var currentTotalQuestion =
            (await firstMatchingDocument.get())['total_question'];

        // Increment the value by 1
        var newTotalQuestion = currentTotalQuestion + 1;

        // Update the 'total_question' field in the document
        if (btnType == 1) {
          await firstMatchingDocument
              .update({'total_question': newTotalQuestion});
        } else {
          await firstMatchingDocument.update({
            'total_question': newTotalQuestion,
            'status': 40 // 40 = completed
          });
        }

        // Trigger the event regardless of whether the document was added successfully
        if (context.mounted) {
          context.read<MultiplayerQuizBloc>().add(
                NextQuestionEvent(isSelected, btnType),
              );
        }
      }
    } else {
      // print("testtttt answerrrr else");
      // If the document already exists, update it (you can update all matching documents if needed)
      // for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      //   await doc.reference.update({
      //     "item_id": content.itemId,
      //     "is_answer": content.isAnswer,
      //   });
      // }
    }
  }
}
