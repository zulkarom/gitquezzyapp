import 'package:flutter_bloc/flutter_bloc.dart';

import 'question_event.dart';
import 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc()
      : super(const InitialMyQuestionsStates(
          question: [],
          score: 0,
        )) {
    on<TriggerInitialMyQuestionsEvent>(_triggerInitialMyQuestions);
    on<TriggerLoadingMyQuestionsEvent>(_triggerLoadingMyQuestions);
    on<TriggerLoadedMyQuestionsEvent>(_triggerLoadedMyQuestions);
    on<TriggerDoneLoadingMyQuestionsEvent>(_triggerDoneLoadingMyQuestions);
    on<SetSelectedAnswerEvent>(_setSelectedAnswer);

    on<SetQuestionScoreEvent>((event, emit) {
      int score = state.score;
      score = score + 1;
      // print(score);
      emit(QuestionScoreSet(
        question: state.question,
        score: score,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        isSelected: state.isSelected,
      ));
    });

    on<NextQuestionEvent>((event, emit) async {
      int currentQuestionIndex = state.currentQuestionIndex!;
      if (event.btnType == 1) {
        currentQuestionIndex = currentQuestionIndex + 1;
      } else {
        currentQuestionIndex = 0;
      }

      emit(NextQuestionSet(
        question: state.question,
        currentQuestionIndex: currentQuestionIndex,
        selectedAnswer: null,
        isSelected: event.isSelected,
        score: state.score,
      ));
    });

    // on<NextQuestionEvent>((event, emit) async {
    //   int currentQuestionIndex = state.currentQuestionIndex!;
    //   if (event.btnType == 1) {
    //     currentQuestionIndex = currentQuestionIndex + 1;
    //   } else {
    //     currentQuestionIndex = 0;
    //   }

    //   // Answer answer = state.answer!;
    //   Uuid uuid = const Uuid();

    //   Answer answer = Answer(
    //     id: uuid.v4(), // Provide appropriate values
    //     studentId: Global.storageService.getStudentId(),
    //     questionId: state.selectedAnswer!.question_id.toString(),
    //     itemId: state.selectedAnswer!.id.toString(),
    //     isAnswer: state.selectedAnswer!.is_answer!,
    //   );

    //   // Perform more data validation on 'answer' if needed
    //   // Check if a document with the same data already exists in Firestore
    //   bool doesDocumentExist =
    //       await AnswerFirestore.checkIfDocumentExists(answer);

    //   if (doesDocumentExist) {
    //     // Handle the case where the data already exists in Firestore
    //     // You can throw an exception, log an error, or take appropriate action
    //     emit(AnswerFailed(
    //       question: state.question,
    //       score: state.score,
    //       failure: Failure('You already answer this question'),
    //     ));
    //   }

    //   try {
    //     // Now, you can store the 'answer' in Firestore
    //     await AnswerFirestore.create(answer: answer);
    //   } catch (error) {
    //     // Handle Firestore errors, if any
    //     // You can log the error or take appropriate action
    //     emit(AnswerFailed(
    //       question: state.question,
    //       score: state.score,
    //       failure: Failure('$error'),
    //     ));
    //   }
    //   emit(NextQuestionSet(
    //     question: state.question,
    //     currentQuestionIndex: currentQuestionIndex,
    //     selectedAnswer: null,
    //     isSelected: event.isSelected,
    //     score: state.score,
    //   ));
    // });

    on<RestartQuestionEvent>((event, emit) {
      emit(RestartQuestionSet(
        question: state.question,
        score: 0,
        currentQuestionIndex: 0,
        selectedAnswer: null,
      ));
    });
  }

  void _triggerInitialMyQuestions(
      TriggerInitialMyQuestionsEvent event, Emitter<QuestionState> emit) {
    emit(InitialMyQuestionsStates(
      score: state.score,
      question: state.question,
    ));
  }

  void _triggerLoadedMyQuestions(
      TriggerLoadedMyQuestionsEvent event, Emitter<QuestionState> emit) {
    emit(LoadedMyQuestionsStates(
      score: state.score,
      question: event.question,
    ));
  }

  void _triggerLoadingMyQuestions(
      TriggerLoadingMyQuestionsEvent event, Emitter<QuestionState> emit) {
    emit(LoadingMyQuestionsStates(
      score: state.score,
      question: state.question,
    ));
  }

  void _triggerDoneLoadingMyQuestions(
      TriggerDoneLoadingMyQuestionsEvent event, Emitter<QuestionState> emit) {
    emit(DoneLoadingMyQuestionsStates(
      score: state.score,
      question: state.question,
    ));
  }

  void _setSelectedAnswer(
      SetSelectedAnswerEvent event, Emitter<QuestionState> emit) {
    print(event.selectedAnswer.answer);

    emit(SelectedAnswerSet(
      question: state.question,
      score: state.score,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: event.selectedAnswer,
      isSelected: event.isSelected,
    ));
  }
}
