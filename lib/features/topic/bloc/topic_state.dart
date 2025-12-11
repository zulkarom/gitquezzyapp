part of 'topic_bloc.dart';

abstract class TopicState extends Equatable {
  final List<TopicItem>? topicItem;
  const TopicState({
    this.topicItem,
  });

  @override
  List<Object?> get props => [topicItem];
}

class InitialMyTopicStates extends TopicState {
  const InitialMyTopicStates({required super.topicItem});
}

class LoadingMyTopicStates extends TopicState {
  const LoadingMyTopicStates({required super.topicItem});
}

class DoneLoadingMyTopicStates extends TopicState {
  const DoneLoadingMyTopicStates({required super.topicItem});
}

class LoadedMyTopicStates extends TopicState {
  const LoadedMyTopicStates({required super.topicItem});
}
