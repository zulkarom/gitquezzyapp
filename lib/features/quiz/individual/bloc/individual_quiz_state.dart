part of 'individual_quiz_bloc.dart';

class IndividualQuizState extends Equatable {
  final List<Question>? question;
  final int? currentQuestionIndex;
  final int score;
  final QuestionItem? selectedAnswer;
  final List<Map<int, QuestionItem>> answerSelected;
  final bool isSelected;
  final PlayerAnswer? answer;

  final double percent;

  const IndividualQuizState({
    this.question,
    this.currentQuestionIndex = 0,
    required this.score,
    this.selectedAnswer,
    this.isSelected = false,
    this.answerSelected = const [],
    this.answer,
    this.percent = 0,
  });

  @override
  List<Object?> get props => [
        question,
        currentQuestionIndex,
        score,
        selectedAnswer,
        isSelected,
        answerSelected,
        answer,
        percent,
      ];

  IndividualQuizState copyWith({
    List<Question>? question,
    int? currentQuestionIndex,
    int? score,
    QuestionItem? selectedAnswer,
    List<Map<int, QuestionItem>>? answerSelected,
    bool? isSelected,
    PlayerAnswer? answer,
    double? percent,
  }) {
    return IndividualQuizState(
      question: question ?? this.question,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      answerSelected: answerSelected ?? this.answerSelected,
      isSelected: isSelected ?? this.isSelected,
      answer: answer ?? this.answer,
      percent: percent ?? this.percent,
    );
  }
}

class InitialMyQuestionsStates extends IndividualQuizState {
  const InitialMyQuestionsStates({
    required super.question,
    required super.score,
    required super.percent,
  });
}

class LoadingMyQuestionsStates extends IndividualQuizState {
  const LoadingMyQuestionsStates({
    required super.question,
    required super.score,
    required super.percent,
  });
}

class DoneLoadingMyQuestionsStates extends IndividualQuizState {
  const DoneLoadingMyQuestionsStates({
    required super.question,
    required super.score,
    required super.percent,
  });
}

class LoadedMyQuestionsStates extends IndividualQuizState {
  const LoadedMyQuestionsStates({
    required super.question,
    required super.score,
    required super.percent,
  });
}

class QuestionScoreSet extends IndividualQuizState {
  const QuestionScoreSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
    required super.percent,
  });
}

class SelectedAnswerSet extends IndividualQuizState {
  const SelectedAnswerSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
    required super.percent,
  });
}

class NextQuestionSet extends IndividualQuizState {
  const NextQuestionSet({
    required super.question,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
    required super.score,
    required super.percent,
  });
}

class RestartQuestionSet extends IndividualQuizState {
  const RestartQuestionSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    required super.percent,
  });
}

class AnswerFailed extends IndividualQuizState {
  final Failure failure;

  const AnswerFailed({
    required super.question,
    required super.score,
    required this.failure,
    required super.percent,
  });
}
