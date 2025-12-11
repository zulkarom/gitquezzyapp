import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/global.dart';

import '../../../../core/models/entities.dart';

part 'multiplayer_result_event.dart';
part 'multiplayer_result_state.dart';

class MultiplayerResultBloc
    extends Bloc<MultiplayerResultEvent, MultiplayerResultState> {
  MultiplayerResultBloc()
      : super(const InitialMyResultsStates(
          question: [],
          answer: [],
          result: [],
          totalScore: 0,
          correctAnswer: 0,
          starScore: 0,
        )) {
    on<TriggerInitialMyResultsEvent>(_triggerInitialMyResults);
    on<TriggerLoadingMyResultsEvent>(_triggerLoadingMyResults);
    on<TriggerLoadedMyResultsEvent>(_triggerLoadedMyResults);
    on<TriggerDoneLoadingMyResultsEvent>(_triggerDoneLoadingMyResults);
    // on<GetAnswerEvent>(_getAnswer);
  }

  void _triggerInitialMyResults(TriggerInitialMyResultsEvent event,
      Emitter<MultiplayerResultState> emit) {
    emit(InitialMyResultsStates(
      question: state.question,
      answer: state.answer,
      result: state.result,
      totalScore: state.totalScore,
      correctAnswer: state.correctAnswer,
      starScore: state.starScore,
    ));
  }

  void _triggerLoadedMyResults(TriggerLoadedMyResultsEvent event,
      Emitter<MultiplayerResultState> emit) async {
    // print(event.answer);

    emit(LoadedMyResultsStates(
      question: event.question,
      answer: event.answer,
      result: state.result,
      totalScore: state.totalScore,
      correctAnswer: state.correctAnswer,
      starScore: state.starScore,
    ));
  }

  void _triggerLoadingMyResults(TriggerLoadingMyResultsEvent event,
      Emitter<MultiplayerResultState> emit) {
    emit(LoadingMyResultsStates(
      question: state.question,
      answer: state.answer,
      result: state.result,
      totalScore: state.totalScore,
      correctAnswer: state.correctAnswer,
      starScore: state.starScore,
    ));
  }

  void _triggerDoneLoadingMyResults(TriggerDoneLoadingMyResultsEvent event,
      Emitter<MultiplayerResultState> emit) {
    final questionList = List<Question>.from(state.question);
    final answerList = List<PlayerAnswer>.from(state.answer);
    int score = 0;
    final resultList = [];
    // print('this is to test the length');
    // print(questionList.length);
    // print(answerList.length);

    for (var question in questionList) {
      for (var answer in answerList) {
        if (answer.questionId == question.id) {
          if (answer.isAnswer == 1) {
            score = score + 1;
          }

          // print(question.questionItems!.map((e) => e.id));
          // question.questionItems!.map((e) => e.is_answer);
          // Create a new map with the desired key-value pairs and add it to resultList
          resultList.add({
            "questionId": question.id, // You can modify this as needed
            "soalan_bm": question.soalan_bm, // You can modify this as needed
            "soalan_eng": question.soalan_eng,
            "itemId": answer.itemId,
            "is_answer": answer.isAnswer,
            "questionItems": question.questionItems,
            "imageUrl": question.imageUrl,
          });
        }
      }
    }
    //calculate total score for every level.
    double totalScore = (score / questionList.length) * 100;
    double starScore = Global.starCalculation(totalScore / 100);

    emit(DoneLoadingMyResultsStates(
      question: state.question,
      answer: state.answer,
      result: resultList,
      totalScore: totalScore,
      correctAnswer: score,
      starScore: starScore,
    ));
  }
}
