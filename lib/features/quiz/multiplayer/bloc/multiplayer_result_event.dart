part of 'multiplayer_result_bloc.dart';

class MultiplayerResultEvent extends Equatable {
  const MultiplayerResultEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyResultsEvent extends MultiplayerResultEvent {
  const TriggerInitialMyResultsEvent();
}

class TriggerLoadingMyResultsEvent extends MultiplayerResultEvent {
  const TriggerLoadingMyResultsEvent();
}

class TriggerDoneLoadingMyResultsEvent extends MultiplayerResultEvent {
  const TriggerDoneLoadingMyResultsEvent();
}

class TriggerLoadedMyResultsEvent extends MultiplayerResultEvent {
  const TriggerLoadedMyResultsEvent(this.question, this.answer);
  final List<Question> question;
  final List<PlayerAnswer> answer;
}

class GetAnswerEvent extends MultiplayerResultEvent {
  @override
  List<Object> get props => [];
}
