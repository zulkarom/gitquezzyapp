part of 'topic_bloc.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyTopicEvent extends TopicEvent {
  const TriggerInitialMyTopicEvent();
}

class TriggerLoadingMyTopicEvent extends TopicEvent {
  const TriggerLoadingMyTopicEvent();
}

class TriggerDoneLoadingMyTopicEvent extends TopicEvent {
  const TriggerDoneLoadingMyTopicEvent();
}

class TriggerLoadedMyTopicEvent extends TopicEvent {
  const TriggerLoadedMyTopicEvent(this.topicItem, this.answerList);
  final List<TopicItem> topicItem;
  final List<Ans> answerList;
}

class TriggerLoadedMyTopicEvent2 extends TopicEvent {
  const TriggerLoadedMyTopicEvent2(this.topicItem);
  final List<TopicItem> topicItem;
}
