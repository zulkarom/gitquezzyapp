import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMySubjectsEvent extends HomeEvent {
  const TriggerInitialMySubjectsEvent();
}

class TriggerLoadingMySubjectsEvent extends HomeEvent {
  const TriggerLoadingMySubjectsEvent();
}

class TriggerDoneLoadingMySubjectsEvent extends HomeEvent {
  const TriggerDoneLoadingMySubjectsEvent();
}

class TriggerLoadedMySubjectsEvent extends HomeEvent {
  const TriggerLoadedMySubjectsEvent(this.subjectItem);
  //const TriggerLoadedMySubjectsEvent(this.subjectItem, this.answerList);
  final List<SubjectItem> subjectItem;
  //final List<Ans> answerList;
}
