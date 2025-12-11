part of 'individual_result_bloc.dart';

class IndividualResultEvent extends Equatable {
  const IndividualResultEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyResultsEvent extends IndividualResultEvent {
  const TriggerInitialMyResultsEvent();
}

class TriggerLoadingMyResultsEvent extends IndividualResultEvent {
  const TriggerLoadingMyResultsEvent();
}

class TriggerDoneLoadingMyResultsEvent extends IndividualResultEvent {
  const TriggerDoneLoadingMyResultsEvent();
}

class TriggerLoadedMyResultsEvent extends IndividualResultEvent {
  const TriggerLoadedMyResultsEvent(this.question, this.answer);
  final List<Question> question;
  final List<PlayerAnswer> answer;
}

class GetAnswerEvent extends IndividualResultEvent {
  @override
  List<Object> get props => [];
}
