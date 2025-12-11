import 'package:equatable/equatable.dart';

import '../../../core/error/failures/failure.dart';
import '../../../core/models/entities.dart';

abstract class QuestionState extends Equatable {
  final List<Question>? question;
  final int? currentQuestionIndex;
  final int score;
  final QuestionItem? selectedAnswer;
  final List<Map<int, QuestionItem>> answerSelected;
  final bool isSelected;
  final Answer? answer;

  const QuestionState(
      {this.question,
      this.currentQuestionIndex = 0,
      required this.score,
      this.selectedAnswer,
      this.isSelected = false,
      this.answerSelected = const [],
      this.answer});

  @override
  List<Object?> get props => [
        question,
        currentQuestionIndex,
        score,
        selectedAnswer,
        isSelected,
        answerSelected,
        answer,
      ];
}

class InitialMyQuestionsStates extends QuestionState {
  const InitialMyQuestionsStates(
      {required super.question, required super.score});
}

class LoadingMyQuestionsStates extends QuestionState {
  const LoadingMyQuestionsStates(
      {required super.question, required super.score});
}

class DoneLoadingMyQuestionsStates extends QuestionState {
  const DoneLoadingMyQuestionsStates({
    required super.question,
    required super.score,
  });
}

class LoadedMyQuestionsStates extends QuestionState {
  const LoadedMyQuestionsStates(
      {required super.question, required super.score});
}

class QuestionScoreSet extends QuestionState {
  const QuestionScoreSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
  });
}

class SelectedAnswerSet extends QuestionState {
  const SelectedAnswerSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
  });
}

class NextQuestionSet extends QuestionState {
  const NextQuestionSet(
      {required super.question,
      super.currentQuestionIndex,
      super.selectedAnswer,
      super.isSelected,
      required super.score});
}

class RestartQuestionSet extends QuestionState {
  const RestartQuestionSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
  });
}

class AnswerFailed extends QuestionState {
  final Failure failure;

  const AnswerFailed({
    required super.question,
    required super.score,
    required this.failure,
  });
}
