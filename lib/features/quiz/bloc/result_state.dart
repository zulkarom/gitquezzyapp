import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

abstract class ResultState extends Equatable {
  final List<Question> question;
  final List<Answer> answer;
  final List<dynamic> result;
  final int totalScore;
  final int correctAnswer;

  const ResultState({
    required this.question,
    required this.answer,
    required this.result,
    required this.totalScore,
    required this.correctAnswer,
  });

  @override
  List<Object?> get props => [
        question,
        answer,
        result,
        totalScore,
        correctAnswer,
      ];
}

class InitialMyResultsStates extends ResultState {
  const InitialMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
  });
}

class LoadingMyResultsStates extends ResultState {
  const LoadingMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
  });
}

class DoneLoadingMyResultsStates extends ResultState {
  const DoneLoadingMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
  });
}

class LoadedMyResultsStates extends ResultState {
  const LoadedMyResultsStates({
    required super.question,
    required super.answer,
    required super.result,
    required super.totalScore,
    required super.correctAnswer,
  });
}
