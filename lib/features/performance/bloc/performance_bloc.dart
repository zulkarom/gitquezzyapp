import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/models/subscribe.dart';
import 'package:flutter_ta_plus/global.dart';

import '../../../core/models/entities.dart';

part 'performance_event.dart';
part 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  PerformanceBloc()
      : super(const InitialMyPerformanceStates(
          subscribeItem: null,
        )) {
    on<TriggerInitialMyPerformanceEvent>(_triggerInitialMyPerformance);
    on<TriggerLoadingMyPerformanceEvent>(_triggerLoadingMyPerformance);
    on<TriggerLoadedMyPerformanceEvent>(_triggerLoadedMyPerformance);
    on<TriggerDoneLoadingMyPerformanceEvent>(_triggerDoneLoadingMyPerformance);
  }

  void _triggerInitialMyPerformance(
      TriggerInitialMyPerformanceEvent event, Emitter<PerformanceState> emit) {
    emit(InitialMyPerformanceStates(
      subscribeItem: state.subscribeItem,
    ));
  }

  void _triggerLoadedMyPerformance(
      TriggerLoadedMyPerformanceEvent event, Emitter<PerformanceState> emit) {
    // if (event.subscribeItem.package_id ==
    //     int.parse(Global.storageService.getPackageId())) {
    //   // int subjectDone = 1;
    //   int answerTotal = 0; // untuk calculate total topic yang dijawab
    //   double totalScore = 0;
    //   double starScore = 0;
    //   double progress = 0;
    //   for (var answer in event.answerList) {
    //     if (answer.packageId ==
    //         int.parse(Global.storageService.getPackageId())) {
    //       totalScore = ((totalScore + (answer.totalScore! / 100)) /
    //           event.subscribeItem.totalAllTopic!);
    //       answerTotal++;
    //     }
    //   }

    //   progress = (answerTotal / event.subscribeItem.totalAllTopic!) * 100;

    //   starScore = Global.starCalculation(totalScore);
    //   // Create a new PackageItem
    //   SubscribeItem subscribeItem = SubscribeItem(
    //     id: event.subscribeItem.id,
    //     name: event.subscribeItem.name,
    //     totalSubject: event.subscribeItem.totalSubject,
    //     star: starScore,
    //     progress: progress.round(),
    //     totalScore: totalScore,
    //   );

    //   print("totalScore2");
    //   print(subscribeItem.totalScore);

    emit(LoadedMyPerformanceStates(
      subscribeItem: event.subscribeItem,
    ));
    // foundMatch = true;
    // break; // Exit the inner loop once a match is found
    // } else {
    //   emit(LoadedMyPerformanceStates(
    //     subscribeItem: state.subscribeItem,
    //   ));
    // }
  }

  void _triggerLoadingMyPerformance(
      TriggerLoadingMyPerformanceEvent event, Emitter<PerformanceState> emit) {
    emit(LoadingMyPerformanceStates(
      subscribeItem: state.subscribeItem,
    ));
  }

  void _triggerDoneLoadingMyPerformance(
      TriggerDoneLoadingMyPerformanceEvent event,
      Emitter<PerformanceState> emit) {
    emit(DoneLoadingMyPerformanceStates(
      subscribeItem: state.subscribeItem,
    ));
  }
}
