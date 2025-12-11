import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

abstract class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyResultsEvent extends ResultEvent {
  const TriggerInitialMyResultsEvent();
}

class TriggerLoadingMyResultsEvent extends ResultEvent {
  const TriggerLoadingMyResultsEvent();
}

class TriggerDoneLoadingMyResultsEvent extends ResultEvent {
  const TriggerDoneLoadingMyResultsEvent();
}

class TriggerLoadedMyResultsEvent extends ResultEvent {
  const TriggerLoadedMyResultsEvent(this.question, this.answer);
  final List<Question> question;
  final List<Answer> answer;
}

class GetAnswerEvent extends ResultEvent {
  @override
  List<Object> get props => [];
}
