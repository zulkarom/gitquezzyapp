import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/entities.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  LevelBloc()
      : super(const InitialMyLevelStates(
          levelItem: [],
          levelResultItem: [],
          tempLevel: [],
        )) {
    on<TriggerInitialMyLevelEvent>(_triggerInitialMyLevel);
    on<TriggerLoadingMyLevelEvent>(_triggerLoadingMyLevel);
    on<TriggerLoadedMyLevelEvent>(_triggerLoadedMyLevel);
    on<TriggerDoneLoadingMyLevelEvent>(_triggerDoneLoadingMyLevel);
  }

  void _triggerInitialMyLevel(
      TriggerInitialMyLevelEvent event, Emitter<LevelState> emit) {
    emit(InitialMyLevelStates(
      levelItem: state.levelItem,
      levelResultItem: state.levelResultItem,
      tempLevel: state.tempLevel,
    ));
  }

  void _triggerLoadedMyLevel(
      TriggerLoadedMyLevelEvent event, Emitter<LevelState> emit) {
    final tempLevel = [];
    final listLevel = List<LevelItem>.from(state.levelItem!);

    for (var item in event.levelItem) {
      bool foundMatch = false;

      for (var answer in event.answerList) {
        if (answer.levelId == item.id) {
          listLevel.add(LevelItem(
            id: item.id,
            topic_id: item.topic_id,
            level_number: item.level_number,
            star: answer.starScore,
          ));
          foundMatch = true;
          break; // Exit the inner loop once a match is found
        }
      }

      if (!foundMatch) {
        // If no match was found in the inner loop, add a LevelItem with star: 0
        listLevel.add(LevelItem(
          id: item.id,
          topic_id: item.topic_id,
          level_number: item.level_number,
          star: 0,
        ));
      }
    }

    emit(LoadedMyLevelStates(
      levelItem: listLevel,
      levelResultItem: state.levelResultItem,
      tempLevel: tempLevel,
    ));
  }

  // void _triggerLoadedMyLevel(
  //     TriggerLoadedMyLevelEvent event, Emitter<LevelState> emit) {
  //   final tempLevel = [];

  //   for (var level in event.levelItem) {
  //     for (var result in event.levelResultItem) {
  //       if (level.id == result.levelId) {
  //         tempLevel.add({
  //           "id": level.id,
  //           "level_number": level.level_number,
  //           "topic_id": level.topic_id,
  //           "result_id": result.id, // You can modify this as needed
  //           "studentId": result.studentId,
  //           "isDone": result.isDone,
  //           "totalMark": result.totalMark,
  //         });
  //       } else {
  //         tempLevel.add({
  //           "id": level.id,
  //           "level_number": level.level_number,
  //           "topic_id": level.topic_id,
  //           "result_id": null, // You can modify this as needed
  //           "studentId": null,
  //           "isDone": 0,
  //           "totalMark": null,
  //         });
  //       }
  //     }
  //   }
  //   // print("tempLevel");
  //   // print(tempLevel);

  //   emit(LoadedMyLevelStates(
  //     levelItem: event.levelItem,
  //     levelResultItem: event.levelResultItem,
  //     tempLevel: tempLevel,
  //   ));
  // }

  void _triggerLoadingMyLevel(
      TriggerLoadingMyLevelEvent event, Emitter<LevelState> emit) {
    emit(LoadingMyLevelStates(
      levelItem: state.levelItem,
      levelResultItem: state.levelResultItem,
      tempLevel: state.tempLevel,
    ));
  }

  void _triggerDoneLoadingMyLevel(
      TriggerDoneLoadingMyLevelEvent event, Emitter<LevelState> emit) {
    emit(DoneLoadingMyLevelStates(
      levelItem: state.levelItem,
      levelResultItem: state.levelResultItem,
      tempLevel: state.tempLevel,
    ));
  }
}
