part of 'individual_quiz_bloc.dart';

class IndividualQuizEvent extends Equatable {
  const IndividualQuizEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyQuestionsEvent extends IndividualQuizEvent {
  const TriggerInitialMyQuestionsEvent();
}

class TriggerLoadingMyQuestionsEvent extends IndividualQuizEvent {
  const TriggerLoadingMyQuestionsEvent();
}

class TriggerDoneLoadingMyQuestionsEvent extends IndividualQuizEvent {
  const TriggerDoneLoadingMyQuestionsEvent();
}

class TriggerLoadedMyQuestionsEvent extends IndividualQuizEvent {
  const TriggerLoadedMyQuestionsEvent(this.question);
  final List<Question> question;
}

class TriggerReLoadingMyQuestionsEvent extends IndividualQuizEvent {
  const TriggerReLoadingMyQuestionsEvent();
}

class SetQuestionScoreEvent extends IndividualQuizEvent {
  const SetQuestionScoreEvent();
}

class SetSelectedAnswerEvent extends IndividualQuizEvent {
  const SetSelectedAnswerEvent(this.selectedAnswer, this.isSelected);
  final QuestionItem selectedAnswer;
  final bool isSelected;
}

class NextQuestionEvent extends IndividualQuizEvent {
  // final QuestionItem selectedAnswer;
  const NextQuestionEvent(this.isSelected, this.btnType);
  final bool isSelected;
  final int btnType;
}

class RestartIndividualQuizEvent extends IndividualQuizEvent {
  // final QuestionItem selectedAnswer;
  const RestartIndividualQuizEvent();
}
