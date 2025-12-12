import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/global.dart';

import '../../../core/models/entities.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc()
      : super(const InitialMyTopicStates(
          topicItem: [],
        )) {
    on<TriggerInitialMyTopicEvent>(_triggerInitialMyTopic);
    on<TriggerLoadingMyTopicEvent>(_triggerLoadingMyTopic);
    on<TriggerLoadedMyTopicEvent>(_triggerLoadedMyTopic);
    on<TriggerLoadedMyTopicEvent2>(_triggerLoadedMyTopic2);
    on<TriggerDoneLoadingMyTopicEvent>(_triggerDoneLoadingMyTopic);
  }

  void _triggerInitialMyTopic(
      TriggerInitialMyTopicEvent event, Emitter<TopicState> emit) {
    emit(InitialMyTopicStates(
      topicItem: state.topicItem,
    ));
  }

  void _triggerLoadedMyTopic2(
      TriggerLoadedMyTopicEvent2 event, Emitter<TopicState> emit) {
    print("event.topicItem");
    print(event.topicItem.length);
    emit(LoadedMyTopicStates(
      topicItem: event.topicItem,
    ));
  }

  void _triggerLoadedMyTopic(
      TriggerLoadedMyTopicEvent event, Emitter<TopicState> emit) {
    final listTopic = List<TopicItem>.from(state.topicItem!);

    for (var item in event.topicItem) {
      int levelDone = 1;
      double totalScore = 0;
      double starScore = 0;
      double progress = 0;
      for (var answer in event.answerList) {
        if (answer.topicId == item.id) {
          totalScore =
              ((totalScore + (answer.totalScore! / 100)) / item.totalLevel!);
          progress = (levelDone / item.totalLevel!) * 100;
          levelDone++;
        }
      }
      starScore = Global.starCalculation(totalScore);

      listTopic.add(TopicItem(
        id: item.id,
        subjectId: item.subjectId,
        name_bm: item.name_bm,
        name_eng: item.name_eng,
        description_bm: item.description_bm,
        description_eng: item.description_eng,
        star: starScore,
        progress: progress,
      ));
      // foundMatch = true;
      // break; // Exit the inner loop once a match is found
    }

    emit(LoadedMyTopicStates(
      topicItem: listTopic,
    ));
  }

  void _triggerLoadingMyTopic(
      TriggerLoadingMyTopicEvent event, Emitter<TopicState> emit) {
    emit(LoadingMyTopicStates(
      topicItem: state.topicItem,
    ));
  }

  void _triggerDoneLoadingMyTopic(
      TriggerDoneLoadingMyTopicEvent event, Emitter<TopicState> emit) {
    print("heheheheheheheheheheheheh");
    print(state.topicItem!.length);
    emit(DoneLoadingMyTopicStates(
      topicItem: state.topicItem,
    ));
  }
}
