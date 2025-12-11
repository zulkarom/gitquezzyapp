part of 'multiplayer_quiz_bloc.dart';

class MultiplayerQuizState extends Equatable {
  final List<Question>? question;
  final int? currentQuestionIndex;
  final int score;
  final QuestionItem? selectedAnswer;
  final List<Map<int, QuestionItem>> answerSelected;
  final bool isSelected;
  final PlayerAnswer? answer;
  final List<Player>? playerList;
  final double percent;
  final List<Map<String, String>> listPerformance;

  const MultiplayerQuizState({
    this.question,
    this.currentQuestionIndex = 0,
    required this.score,
    this.selectedAnswer,
    this.isSelected = false,
    this.answerSelected = const [],
    this.answer,
    this.playerList,
    this.percent = 0,
    this.listPerformance = const [],
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
        playerList,
        percent,
        listPerformance,
      ];

  MultiplayerQuizState copyWith({
    List<Question>? question,
    int? currentQuestionIndex,
    int? score,
    QuestionItem? selectedAnswer,
    List<Map<int, QuestionItem>>? answerSelected,
    bool? isSelected,
    PlayerAnswer? answer,
    List<Player>? playerList,
    double? percent,
    List<Map<String, String>>? listPerformance,
  }) {
    return MultiplayerQuizState(
      question: question ?? this.question,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      answerSelected: answerSelected ?? this.answerSelected,
      isSelected: isSelected ?? this.isSelected,
      answer: answer ?? this.answer,
      playerList: playerList ?? this.playerList,
      percent: percent ?? this.percent,
      listPerformance: listPerformance ?? this.listPerformance,
    );
  }
}

class InitialMyQuestionsStates extends MultiplayerQuizState {
  const InitialMyQuestionsStates({
    required super.question,
    required super.score,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class LoadingMyQuestionsStates extends MultiplayerQuizState {
  const LoadingMyQuestionsStates({
    required super.question,
    required super.score,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class DoneLoadingMyQuestionsStates extends MultiplayerQuizState {
  const DoneLoadingMyQuestionsStates({
    required super.question,
    required super.score,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class LoadedMyQuestionsStates extends MultiplayerQuizState {
  const LoadedMyQuestionsStates({
    required super.question,
    required super.score,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class QuestionScoreSet extends MultiplayerQuizState {
  const QuestionScoreSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class SelectedAnswerSet extends MultiplayerQuizState {
  const SelectedAnswerSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class NextQuestionSet extends MultiplayerQuizState {
  const NextQuestionSet({
    required super.question,
    super.currentQuestionIndex,
    super.selectedAnswer,
    super.isSelected,
    required super.score,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class RestartQuestionSet extends MultiplayerQuizState {
  const RestartQuestionSet({
    required super.question,
    required super.score,
    super.currentQuestionIndex,
    super.selectedAnswer,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class AnswerFailed extends MultiplayerQuizState {
  final Failure failure;

  const AnswerFailed({
    required super.question,
    required super.score,
    required this.failure,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

//Performance
class DonePlayerListStates extends MultiplayerQuizState {
  const DonePlayerListStates({
    required super.question,
    required super.score,
    required super.currentQuestionIndex,
    required super.selectedAnswer,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class DoneUpdatePlayerListStates extends MultiplayerQuizState {
  const DoneUpdatePlayerListStates({
    required super.question,
    required super.score,
    required super.currentQuestionIndex,
    required super.selectedAnswer,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class DoneSetPerformanceStates extends MultiplayerQuizState {
  const DoneSetPerformanceStates({
    required super.question,
    required super.score,
    required super.currentQuestionIndex,
    required super.selectedAnswer,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}

class DoneUpdatePlayersStates extends MultiplayerQuizState {
  const DoneUpdatePlayersStates({
    required super.question,
    required super.score,
    required super.currentQuestionIndex,
    required super.selectedAnswer,
    required super.playerList,
    required super.percent,
    required super.listPerformance,
  });
}
