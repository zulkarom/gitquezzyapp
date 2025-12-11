import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyQuestionsEvent extends QuestionEvent {
  const TriggerInitialMyQuestionsEvent();
}

class TriggerLoadingMyQuestionsEvent extends QuestionEvent {
  const TriggerLoadingMyQuestionsEvent();
}

class TriggerDoneLoadingMyQuestionsEvent extends QuestionEvent {
  const TriggerDoneLoadingMyQuestionsEvent();
}

class TriggerLoadedMyQuestionsEvent extends QuestionEvent {
  const TriggerLoadedMyQuestionsEvent(this.question);
  final List<Question> question;
}

class TriggerReLoadingMyQuestionsEvent extends QuestionEvent {
  const TriggerReLoadingMyQuestionsEvent();
}

class SetQuestionScoreEvent extends QuestionEvent {
  const SetQuestionScoreEvent();
}

class SetSelectedAnswerEvent extends QuestionEvent {
  const SetSelectedAnswerEvent(this.selectedAnswer, this.isSelected);
  final QuestionItem selectedAnswer;
  final bool isSelected;
}

class NextQuestionEvent extends QuestionEvent {
  // final QuestionItem selectedAnswer;
  const NextQuestionEvent(this.isSelected, this.btnType);
  final bool isSelected;
  final int btnType;
}

class RestartQuestionEvent extends QuestionEvent {
  // final QuestionItem selectedAnswer;
  const RestartQuestionEvent();
}
