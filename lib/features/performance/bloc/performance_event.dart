part of 'performance_bloc.dart';

abstract class PerformanceEvent extends Equatable {
  const PerformanceEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyPerformanceEvent extends PerformanceEvent {
  const TriggerInitialMyPerformanceEvent();
}

class TriggerLoadingMyPerformanceEvent extends PerformanceEvent {
  const TriggerLoadingMyPerformanceEvent();
}

class TriggerDoneLoadingMyPerformanceEvent extends PerformanceEvent {
  const TriggerDoneLoadingMyPerformanceEvent();
}

class TriggerLoadedMyPerformanceEvent extends PerformanceEvent {
  const TriggerLoadedMyPerformanceEvent(this.subscribeItem);
  final SubscribeItem subscribeItem;
  // List<Ans> answerList;
}
