import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quezzy_app/features/quiz/individual/bloc/individual_quiz_bloc.dart';

import '../../../../core/api/question_api.dart';
import '../../../../global.dart';

class IndividualQuizController {
  late BuildContext context;
  IndividualQuizController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  var db = FirebaseFirestore.instance; //cloud firestore
  late String answerDocId;
  late LevelItem levelItem;
  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    answerDocId = data["answer_doc_id"];
    levelItem = data["levelItem"];
    asynLoadQuestionData(levelItem);
  }

  asynLoadQuestionData(LevelItem? levelItem) async {
    context
        .read<IndividualQuizBloc>()
        .add(const TriggerLoadingMyQuestionsEvent());
    QuestionRequestEntity questionRequestEntity = QuestionRequestEntity();
    //post package_id
    questionRequestEntity.id = levelItem!.id;
    var result = await QuestionAPI.questionList(questionRequestEntity);
    if (result.code == 200) {
      // print('question items');
      // print(result.code);
      //save data to shared storage
      if (context.mounted) {
        context.read<IndividualQuizBloc>().add(
              TriggerLoadedMyQuestionsEvent(result.data!),
            );

        Future.delayed(
          const Duration(milliseconds: 10),
          () {
            context
                .read<IndividualQuizBloc>()
                .add(const TriggerDoneLoadingMyQuestionsEvent());
          },
        );
      }
    }
  }

  sendAnswer(bool isSelected, int btnType) async {
    var state = context.read<IndividualQuizBloc>().state;

    final content = Answercontent(
      questionId: state.selectedAnswer!.question_id,
      itemId: state.selectedAnswer!.id,
      isAnswer: state.selectedAnswer!.is_answer!,
    );

    // Step 1: Check if the document already exists in the "answerlist" subcollection
    QuerySnapshot querySnapshot = await db
        .collection("answer")
        .doc(answerDocId)
        .collection("answerlist")
        .where("question_id", isEqualTo: content.questionId)
        .get();

    // Step 2: Determine whether to add a new document or update an existing one
    if (querySnapshot.docs.isEmpty) {
      // print("testtttt answerrrr");
      // If the document doesn't exist, add a new one
      await db
          .collection("answer")
          .doc(answerDocId)
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
        .doc(answerDocId)
        .withConverter(
            fromFirestore: Ans.fromFirestore,
            toFirestore: (Ans ans, options) => ans.toFirestore())
        .get();

    // print(answerRes.data()!.avatar);

    if (answerRes.data() != null) {
      if (context.mounted) {
        context.read<IndividualQuizBloc>().add(
              NextQuestionEvent(isSelected, btnType),
            );
      }
    }
  }
}
