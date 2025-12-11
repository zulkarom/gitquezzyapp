import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../../core/models/entities.dart';
import '../../../../global.dart';

part 'multiplayer_quiz_event.dart';
part 'multiplayer_quiz_state.dart';

class MultiplayerQuizBloc
    extends Bloc<MultiplayerQuizEvent, MultiplayerQuizState> {
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  MultiplayerQuizBloc()
      : super(const InitialMyQuestionsStates(
          question: [],
          score: 0,
          playerList: [],
          percent: 0,
          listPerformance: [],
        )) {
    on<TriggerInitialMyQuestionsEvent>(_triggerInitialMyQuestions);
    on<TriggerLoadingMyQuestionsEvent>(_triggerLoadingMyQuestions);
    on<TriggerLoadedMyQuestionsEvent>(_triggerLoadedMyQuestions);
    on<TriggerDoneLoadingMyQuestionsEvent>(_triggerDoneLoadingMyQuestions);
    on<SetSelectedAnswerEvent>(_setSelectedAnswer);
    on<TriggerClearPlayerList>(_triggerClearPlayerList);
    on<TriggerPlayerList>(_triggerPlayerList);
    on<TriggerUpdatePlayerList>(_triggerUpdatePlayerList);

    //Performance
    on<SetPerformanceEvent>(_setPerformanceEvent);
    on<UpdatePlayers>(_updatePlayers);
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
        playerList: state.playerList,
        percent: state.percent,
        listPerformance: state.listPerformance,
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
        playerList: state.playerList,
        percent: state.percent,
        listPerformance: state.listPerformance,
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

    on<RestartMultiplayerQuizEvent>((event, emit) {
      emit(RestartQuestionSet(
        question: state.question,
        score: 0,
        currentQuestionIndex: 0,
        selectedAnswer: null,
        playerList: state.playerList,
        percent: state.percent,
        listPerformance: state.listPerformance,
      ));
    });
  }

  void _triggerInitialMyQuestions(TriggerInitialMyQuestionsEvent event,
      Emitter<MultiplayerQuizState> emit) {
    emit(InitialMyQuestionsStates(
      score: state.score,
      question: state.question,
      playerList: state.playerList,
      percent: state.percent,
      listPerformance: state.listPerformance,
    ));
  }

  void _triggerLoadedMyQuestions(
      TriggerLoadedMyQuestionsEvent event, Emitter<MultiplayerQuizState> emit) {
    emit(LoadedMyQuestionsStates(
      score: state.score,
      question: event.question,
      playerList: state.playerList,
      percent: state.percent,
      listPerformance: state.listPerformance,
    ));
  }

  void _triggerLoadingMyQuestions(TriggerLoadingMyQuestionsEvent event,
      Emitter<MultiplayerQuizState> emit) {
    emit(LoadingMyQuestionsStates(
      score: state.score,
      question: state.question,
      playerList: state.playerList,
      percent: state.percent,
      listPerformance: state.listPerformance,
    ));
  }

  void _triggerDoneLoadingMyQuestions(TriggerDoneLoadingMyQuestionsEvent event,
      Emitter<MultiplayerQuizState> emit) {
    emit(DoneLoadingMyQuestionsStates(
      score: state.score,
      question: state.question,
      playerList: state.playerList,
      percent: state.percent,
      listPerformance: state.listPerformance,
    ));
  }

  void _setSelectedAnswer(
      SetSelectedAnswerEvent event, Emitter<MultiplayerQuizState> emit) {
    // print(event.selectedAnswer.answer);

    emit(SelectedAnswerSet(
      question: state.question,
      score: state.score,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: event.selectedAnswer,
      isSelected: event.isSelected,
      playerList: state.playerList,
      percent: state.percent,
      listPerformance: state.listPerformance,
    ));
  }

  //Performance
  void _triggerClearPlayerList(
      TriggerClearPlayerList event, Emitter<MultiplayerQuizState> emit) {
    emit(state.copyWith(playerList: []));
  }

  void _triggerPlayerList(
      TriggerPlayerList event, Emitter<MultiplayerQuizState> emit) {
    //get the total player
    var playerListNew = state.playerList!.toList();
    //below is the single player
    playerListNew.add(event.player); //append in the end of the list
    // playerListNew.insert(0, event.player); //begining of the list

    emit(DonePlayerListStates(
      question: state.question,
      score: state.score,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: state.selectedAnswer,
      playerList: playerListNew,
      percent: state.percent,
      listPerformance: [
        ...state.listPerformance,
        {
          'studentToken': event.player.studentToken!,
          'totalQuestion': event.player.totalQuestion!.toString(),
        }
      ],
    ));
  }

  void _triggerUpdatePlayerList(
    TriggerUpdatePlayerList event,
    Emitter<MultiplayerQuizState> emit,
  ) {
    // Copy the existing list to avoid modifying the original list
    var playerListNew = state.playerList!.toList();

    // Update the status using the private method
    for (int i = 0; i < playerListNew.length; i++) {
      if (playerListNew[i].studentToken == event.player.studentToken) {
        playerListNew[i] = playerListNew[i].copyWith(
          totalQuestion: event.player.totalQuestion,
          status: event.player.status,
          totalMark: event.player.totalMark,
        );

        // Optional: Print the updated details
        // print("Optional: Print the updated details");
        // print(playerListNew[i].totalQuestion);
      }
    }
    // Sort playerListNew based on the status
    if (playerListNew.isNotEmpty) {
      playerListNew.sort((a, b) {
        // First, compare by total_mark in descending order
        int compareByTotalMark = b.totalMark!.compareTo(a.totalMark!);

        // If total_mark is the same, compare by totalQuestion in descending order
        int compareByTotalQuestion =
            b.totalQuestion!.compareTo(a.totalQuestion!);

        // Return the result of the comparison
        return compareByTotalMark != 0
            ? compareByTotalMark
            : compareByTotalQuestion;
      });
    }

    emit(DoneUpdatePlayerListStates(
        question: state.question,
        score: state.score,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        playerList: playerListNew,
        percent: state.percent,
        listPerformance: state.listPerformance));
  }

  void _setPerformanceEvent(
      SetPerformanceEvent event, Emitter<MultiplayerQuizState> emit) {
    emit(DoneSetPerformanceStates(
      question: state.question,
      score: state.score,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: state.selectedAnswer,
      playerList: state.playerList,
      percent: state.percent,
      listPerformance: state.listPerformance,
    ));
  }

  void _updatePlayers(
    UpdatePlayers event,
    Emitter<MultiplayerQuizState> emit,
  ) {
    // Copy the existing list to avoid modifying the original list
    var playerList = List<Player>.from(state.playerList!);

    // Update the status using the private method
    for (int i = 0; i < playerList.length; i++) {
      if (playerList[i].studentToken == event.updatedPlayer.studentToken) {
        playerList[i] = playerList[i].copyWith(
          status: event.updatedPlayer.status,
        );
      }
    }
    emit(
      DoneUpdatePlayersStates(
        question: state.question,
        score: state.score,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        playerList: playerList,
        percent: state.percent,
        listPerformance: state.listPerformance,
      ),
    );
  }
}
