import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/models/answer/answercontent.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../../core/api/question_api.dart';
import '../../../core/models/answer/ans.dart';
import '../../../global.dart';
import '../bloc/question_bloc.dart';
import '../bloc/question_event.dart';

class QuestionController {
  late BuildContext context;
  QuestionController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  var db = FirebaseFirestore.instance; //cloud firestore
  late var docId;
  late var listener;

  void init(int? levelId) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    docId = data["doc_id"];
    asynLoadQuestionData(levelId);
  }

  asynLoadQuestionData(int? levelId) async {
    context.read<QuestionBloc>().add(const TriggerLoadingMyQuestionsEvent());
    QuestionRequestEntity questionRequestEntity = QuestionRequestEntity();
    //post package_id
    questionRequestEntity.id = levelId;
    var result = await QuestionAPI.questionList(questionRequestEntity);
    if (result.code == 200) {
      // print('question items');
      // print(result.code);
      //save data to shared storage
      if (context.mounted) {
        context.read<QuestionBloc>().add(
              TriggerLoadedMyQuestionsEvent(result.data!),
            );

        Future.delayed(
          const Duration(milliseconds: 10),
          () {
            context
                .read<QuestionBloc>()
                .add(const TriggerDoneLoadingMyQuestionsEvent());
          },
        );
      }
    }
  }

  // sendAnswer(bool isSelected, int btnType) async {
  //   var state = context.read<QuestionBloc>().state;

  //   final content = Answercontent(
  //     questionId: state.selectedAnswer!.question_id,
  //     itemId: state.selectedAnswer!.id,
  //     isAnswer: state.selectedAnswer!.is_answer!,
  //   );

  //   DocumentReference docRef = await addAnswerToCollection(content, docId);

  //   String generatedDocId = docRef.id;

  //   // Update the docId field with the generated document ID
  //   await docRef.update({"docId": generatedDocId});

  //   var answerRes = await db
  //       .collection("answer")
  //       .doc(docId)
  //       .withConverter(
  //           fromFirestore: Ans.fromFirestore,
  //           toFirestore: (Ans ans, options) => ans.toFirestore())
  //       .get();

  //   // print(answerRes.data()!.avatar);

  //   if (answerRes.data() != null) {
  //     if (context.mounted) {
  //       context.read<QuestionBloc>().add(
  //             NextQuestionEvent(isSelected, btnType),
  //           );
  //     }
  //   }
  // }

  sendAnswer(bool isSelected, int btnType) async {
    var state = context.read<QuestionBloc>().state;

    final content = Answercontent(
      questionId: state.selectedAnswer!.question_id,
      itemId: state.selectedAnswer!.id,
      isAnswer: state.selectedAnswer!.is_answer!,
    );

    // Step 1: Check if the document already exists in the "answerlist" subcollection
    QuerySnapshot querySnapshot = await db
        .collection("answer")
        .doc(docId)
        .collection("answerlist")
        .where("question_id", isEqualTo: content.questionId)
        .get();

    // Step 2: Determine whether to add a new document or update an existing one
    if (querySnapshot.docs.isEmpty) {
      // print("testtttt answerrrr");
      // If the document doesn't exist, add a new one
      await db
          .collection("answer")
          .doc(docId)
          .collection("answerlist")
          .withConverter(
              fromFirestore: Answercontent.fromFirestore,
              toFirestore: (Answercontent ans, options) => ans.toFirestore())
          .add(content);
    } else {
      // print("testtttt answerrrr else");
      // If the document already exists, update it (you can update all matching documents if needed)
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.update({
          "item_id": content.itemId,
          "is_answer": content.isAnswer,
        });
      }
    }
    var answerRes = await db
        .collection("answer")
        .doc(docId)
        .withConverter(
            fromFirestore: Ans.fromFirestore,
            toFirestore: (Ans ans, options) => ans.toFirestore())
        .get();

    // print(answerRes.data()!.avatar);

    if (answerRes.data() != null) {
      if (context.mounted) {
        context.read<QuestionBloc>().add(
              NextQuestionEvent(isSelected, btnType),
            );
      }
    }
  }

  //XXXXXXXXXXXXXXXXXXX//
  Future<DocumentReference> addAnswerToCollection(
      Answercontent content, String docId) async {
    final docRef = await db
        .collection("answer")
        .doc(docId)
        .collection("answerlist")
        .withConverter(
            fromFirestore: Answercontent.fromFirestore,
            toFirestore: (Answercontent ans, options) => ans.toFirestore())
        .add(content);

    // print('---after adding ${docRef.id}---');

    return docRef; // Return the DocumentReference
  }

  // sendAnswer(bool isSelected, int btnType) async {
  //   var state = context.read<QuestionBloc>().state;
  //   // print('kskkdskkdskskds');
  //   // Uuid uuid = const Uuid();

  //   // Create a message object with an empty docId field
  //   final content = Answercontent(
  //     questionId: state.selectedAnswer!.question_id,
  //     itemId: state.selectedAnswer!.id,
  //     isAnswer: state.selectedAnswer!.is_answer!,
  //   );
  //   // print(content.itemId);
  //   // print(state.selectedAnswer!.is_answer);

  //   // Convert Msgcontent to a Map using the toFirestore method
  //   Map<String, dynamic> contentMap = content.toFirestore();

  //   // Reference to the collection where you want to add the message
  //   CollectionReference messagesCollection =
  //       db.collection("answer").doc(docId).collection("answerlist");

  //   // Add the message to the collection and get the generated document ID
  //   DocumentReference docRef = await messagesCollection.add(contentMap);
  //   String generatedDocId = docRef.id;

  //   // Update the docId field with the generated document ID
  //   await docRef.update({"docId": generatedDocId});

  //   print('---after adding $generatedDocId---');

  //   var answerRes = await db
  //       .collection("answer")
  //       .doc(docId)
  //       .withConverter(
  //           fromFirestore: Ans.fromFirestore,
  //           toFirestore: (Ans ans, options) => ans.toFirestore())
  //       .get();
  //   print(answerRes.data()!.avatar);
  //   if (answerRes.data() != null) {
  //     if (context.mounted) {
  //       context.read<QuestionBloc>().add(
  //             NextQuestionEvent(isSelected, btnType),
  //           );
  //     }
  //   }
  // }
}
