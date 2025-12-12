import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quezzy_app/core/api/level_api.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/features/quiz/individual/bloc/individual_result_bloc.dart';

import '../../../../core/api/result_api.dart';
import '../../../../core/firebase_services/answer_firestore.dart';
import '../../../../global.dart';
import '../../../reusable/widgets/flutter_toast.dart';

class IndividualResultController {
  late BuildContext context;
  IndividualResultController({required this.context});
  late var answerDocId;
  late LevelItem levelItem;
  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //this is the doc_id get from previous page
    answerDocId = data["answerDocId"];
    levelItem = data["levelItem"];
    // print("levelItem.level_number");
    // print(levelItem.level_number);

    asynLoadResultData(levelItem);
  }

  asynLoadResultData(LevelItem levelItem) async {
    context
        .read<IndividualResultBloc>()
        .add(const TriggerLoadingMyResultsEvent());
    QuestionRequestEntity questionRequestEntity = QuestionRequestEntity();
    //post levelId
    questionRequestEntity.id = levelItem.id;
    var result = await ResultAPI.questionList(questionRequestEntity);
    if (result.code == 200) {
      List<PlayerAnswer> answerList = [];
      // print("answerDocIdsss");
      // print(answerDocId);
      await AnswerFirestore.getAnswerI(
        answerDocId: answerDocId,
      ).then((value) {
        for (var answer in value) {
          answerList.add(answer);
        }
      });
      //save data to shared storage
      if (context.mounted) {
        context
            .read<IndividualResultBloc>()
            .add(TriggerLoadedMyResultsEvent(result.data!, answerList));
        print("somethinggg");
        Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<IndividualResultBloc>()
              .add(const TriggerDoneLoadingMyResultsEvent());
          // print('question itemsfdsffdds');
          // print(result.code);
        });
      }
    }
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

  asyncUpdateAnswer(
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
        if (kDebugMode) {
          print('success');
        }
      } else {
        if (kDebugMode) {
          print("error message here");
        }
      }
    });
  }
}
