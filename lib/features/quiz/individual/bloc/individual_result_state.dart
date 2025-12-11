part of 'individual_result_bloc.dart';

class IndividualResultState extends Equatable {
  final List<Question> question;
  final List<PlayerAnswer> answer;
  final List<dynamic> result;
  final int totalScore;
  final int correctAnswer;
  final double starScore;

  const IndividualResultState({
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

class InitialMyResultsStates extends IndividualResultState {
  const InitialMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}

class LoadingMyResultsStates extends IndividualResultState {
  const LoadingMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}

class DoneLoadingMyResultsStates extends IndividualResultState {
  const DoneLoadingMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}

class LoadedMyResultsStates extends IndividualResultState {
  const LoadedMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
    required super.starScore,
  });
}
