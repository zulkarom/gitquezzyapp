import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../../core/models/entities.dart';
import '../../../../global.dart';

part 'individual_quiz_event.dart';
part 'individual_quiz_state.dart';

class IndividualQuizBloc
    extends Bloc<IndividualQuizEvent, IndividualQuizState> {
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  IndividualQuizBloc()
      : super(const InitialMyQuestionsStates(
          question: [],
          score: 0,
          percent: 0,
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
        percent: state.percent,
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
        percent: state.percent,
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

    on<RestartIndividualQuizEvent>((event, emit) {
      emit(RestartQuestionSet(
        question: state.question,
        score: 0,
        currentQuestionIndex: 0,
        selectedAnswer: null,
        percent: state.percent,
      ));
    });
  }

  void _triggerInitialMyQuestions(
      TriggerInitialMyQuestionsEvent event, Emitter<IndividualQuizState> emit) {
    emit(InitialMyQuestionsStates(
      score: state.score,
      question: state.question,
      percent: state.percent,
    ));
  }

  void _triggerLoadedMyQuestions(
      TriggerLoadedMyQuestionsEvent event, Emitter<IndividualQuizState> emit) {
    emit(LoadedMyQuestionsStates(
      score: state.score,
      question: event.question,
      percent: state.percent,
    ));
  }

  void _triggerLoadingMyQuestions(
      TriggerLoadingMyQuestionsEvent event, Emitter<IndividualQuizState> emit) {
    emit(LoadingMyQuestionsStates(
      score: state.score,
      question: state.question,
      percent: state.percent,
    ));
  }

  void _triggerDoneLoadingMyQuestions(TriggerDoneLoadingMyQuestionsEvent event,
      Emitter<IndividualQuizState> emit) {
    emit(DoneLoadingMyQuestionsStates(
      score: state.score,
      question: state.question,
      percent: state.percent,
    ));
  }

  void _setSelectedAnswer(
      SetSelectedAnswerEvent event, Emitter<IndividualQuizState> emit) {
    print(event.selectedAnswer.answer);

    emit(SelectedAnswerSet(
      question: state.question,
      score: state.score,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: event.selectedAnswer,
      isSelected: event.isSelected,
      percent: state.percent,
    ));
  }
}
