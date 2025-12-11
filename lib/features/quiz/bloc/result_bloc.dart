import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/entities.dart';
import 'result_event.dart';
import 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc()
      : super(const InitialMyResultsStates(
          question: [],
          answer: [],
          result: [],
          totalScore: 0,
          correctAnswer: 0,
        )) {
    on<TriggerInitialMyResultsEvent>(_triggerInitialMyResults);
    on<TriggerLoadingMyResultsEvent>(_triggerLoadingMyResults);
    on<TriggerLoadedMyResultsEvent>(_triggerLoadedMyResults);
    on<TriggerDoneLoadingMyResultsEvent>(_triggerDoneLoadingMyResults);
    // on<GetAnswerEvent>(_getAnswer);
  }

  void _triggerInitialMyResults(
      TriggerInitialMyResultsEvent event, Emitter<ResultState> emit) {
    emit(InitialMyResultsStates(
      question: state.question,
      answer: state.answer,
      result: state.result,
      totalScore: state.totalScore,
      correctAnswer: state.correctAnswer,
    ));
  }

  void _triggerLoadedMyResults(
      TriggerLoadedMyResultsEvent event, Emitter<ResultState> emit) async {
    // print(event.answer);

    emit(LoadedMyResultsStates(
      question: event.question,
      answer: event.answer,
      result: state.result,
      totalScore: state.totalScore,
      correctAnswer: state.correctAnswer,
    ));
  }

  void _triggerLoadingMyResults(
      TriggerLoadingMyResultsEvent event, Emitter<ResultState> emit) {
    emit(LoadingMyResultsStates(
      question: state.question,
      answer: state.answer,
      result: state.result,
      totalScore: state.totalScore,
      correctAnswer: state.correctAnswer,
    ));
  }

  void _triggerDoneLoadingMyResults(
      TriggerDoneLoadingMyResultsEvent event, Emitter<ResultState> emit) {
    final questionList = List<Question>.from(state.question);
    final answerList = List<Answer>.from(state.answer);
    int score = 0;
    final resultList = [];

    for (var question in questionList) {
      for (var answer in answerList) {
        if (int.parse(answer.questionId) == question.id) {
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

    emit(DoneLoadingMyResultsStates(
      question: state.question,
      answer: state.answer,
      result: resultList,
      totalScore: totalScore.round(),
      correctAnswer: score,
    ));
  }
}
