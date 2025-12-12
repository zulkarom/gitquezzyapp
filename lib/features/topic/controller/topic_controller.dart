import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/firebase_services/answer_firestore.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/global.dart';

import '../../../core/api/topic_api.dart';
import '../bloc/topic_bloc.dart';

class TopicController {
  late BuildContext context;
  TopicController({required this.context});

  void init(int? subjectId) {
    asynLoadTopicListData(subjectId!);
  }

  asynLoadTopicListData(int? subjectId) async {
    context.read<TopicBloc>().add(const TriggerLoadingMyTopicEvent());
    TopicRequestEntity topicRequestEntity = TopicRequestEntity();
    //post subject_id

    topicRequestEntity.student_id =
        Global.storageService.getStudentProfile().id;
    topicRequestEntity.subject_id = subjectId;
    var result = await TopicAPI.topicList(topicRequestEntity);

    if (result.code == 200) {
      //save data to shared storage
      if (context.mounted) {
        context.read<TopicBloc>().add(TriggerLoadedMyTopicEvent2(result.data!));

        Future.delayed(const Duration(milliseconds: 10), () {
          context.read<TopicBloc>().add(const TriggerDoneLoadingMyTopicEvent());
        });
      }
    }
  }

  asynLoadTopicData(int? subjectId) async {
    context.read<TopicBloc>().add(const TriggerLoadingMyTopicEvent());
    TopicRequestEntity topicRequestEntity = TopicRequestEntity();
    //post subject_id
    topicRequestEntity.subject_id = subjectId;
    var result = await TopicAPI.topicList(topicRequestEntity);
    List<Ans> ansList = [];
    if (result.code == 200) {
      await AnswerFirestore.getAllLevelStarScore(
        subjectId: subjectId,
      ).then((value) {
        for (var answer in value) {
          ansList.add(answer);
        }
      });

      //save data to shared storage
      if (context.mounted) {
        context
            .read<TopicBloc>()
            .add(TriggerLoadedMyTopicEvent(result.data!, ansList));

        Future.delayed(const Duration(milliseconds: 10), () {
          context.read<TopicBloc>().add(const TriggerDoneLoadingMyTopicEvent());
        });
      }
    }
  }
}
