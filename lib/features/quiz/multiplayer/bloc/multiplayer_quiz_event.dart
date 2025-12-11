part of 'multiplayer_quiz_bloc.dart';

class MultiplayerQuizEvent extends Equatable {
  const MultiplayerQuizEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyQuestionsEvent extends MultiplayerQuizEvent {
  const TriggerInitialMyQuestionsEvent();
}

class TriggerLoadingMyQuestionsEvent extends MultiplayerQuizEvent {
  const TriggerLoadingMyQuestionsEvent();
}

class TriggerDoneLoadingMyQuestionsEvent extends MultiplayerQuizEvent {
  const TriggerDoneLoadingMyQuestionsEvent();
}

class TriggerLoadedMyQuestionsEvent extends MultiplayerQuizEvent {
  const TriggerLoadedMyQuestionsEvent(this.question);
  final List<Question> question;
}

class TriggerReLoadingMyQuestionsEvent extends MultiplayerQuizEvent {
  const TriggerReLoadingMyQuestionsEvent();
}

class SetQuestionScoreEvent extends MultiplayerQuizEvent {
  const SetQuestionScoreEvent();
}

class SetSelectedAnswerEvent extends MultiplayerQuizEvent {
  const SetSelectedAnswerEvent(this.selectedAnswer, this.isSelected);
  final QuestionItem selectedAnswer;
  final bool isSelected;
}

class NextQuestionEvent extends MultiplayerQuizEvent {
  // final QuestionItem selectedAnswer;
  const NextQuestionEvent(this.isSelected, this.btnType);
  final bool isSelected;
  final int btnType;
}

class RestartMultiplayerQuizEvent extends MultiplayerQuizEvent {
  // final QuestionItem selectedAnswer;
  const RestartMultiplayerQuizEvent();
}

//performance

class TriggerClearPlayerList extends MultiplayerQuizEvent {
  const TriggerClearPlayerList();

  @override
  List<Object> get props => [];
}

class TriggerPlayerList extends MultiplayerQuizEvent {
  const TriggerPlayerList(this.player);
  final Player player;

  @override
  List<Object> get props => [player];
}

class TriggerUpdatePlayerList extends MultiplayerQuizEvent {
  const TriggerUpdatePlayerList(this.player);
  final Player player;

  @override
  List<Object> get props => [player];
}

class SetPerformanceEvent extends MultiplayerQuizEvent {
  const SetPerformanceEvent(
    this.totalQuestion,
  );
  final int totalQuestion;
}

class UpdatePlayers extends MultiplayerQuizEvent {
  const UpdatePlayers(this.updatedPlayer);
  final Player updatedPlayer;

  @override
  List<Object> get props => [updatedPlayer];
}
