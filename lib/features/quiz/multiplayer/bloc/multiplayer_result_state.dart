part of 'multiplayer_result_bloc.dart';

class MultiplayerResultState extends Equatable {
  final List<Question> question;
  final List<PlayerAnswer> answer;
  final List<dynamic> result;
  final double totalScore;
  final int correctAnswer;
  final double starScore;

  const MultiplayerResultState({
    required this.question,
    required this.answer,
    required this.result,
    required this.totalScore,
    required this.correctAnswer,
    required this.starScore,
  });

  @override
  List<Object?> get props => [
        question,
        answer,
        result,
        totalScore,
        correctAnswer,
        starScore,
      ];
}

class InitialMyResultsStates extends MultiplayerResultState {
  const InitialMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}

class LoadingMyResultsStates extends MultiplayerResultState {
  const LoadingMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}

class DoneLoadingMyResultsStates extends MultiplayerResultState {
  const DoneLoadingMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}

class LoadedMyResultsStates extends MultiplayerResultState {
  const LoadedMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}
