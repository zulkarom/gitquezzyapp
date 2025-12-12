
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final StreamController<dynamic> _streamController = StreamController();
  // StreamSubscription? _subscription;

  HomeBloc()
      : super(const InitialMySubjectsStates(
          subjectItem: [],
        )) {
    on<TriggerInitialMySubjectsEvent>(_triggerInitialMySubjects);
    on<TriggerLoadingMySubjectsEvent>(_triggerLoadingMySubjects);
    on<TriggerLoadedMySubjectsEvent>(_triggerLoadedMySubjects);
    on<TriggerDoneLoadingMySubjectsEvent>(_triggerDoneLoadingMySubjects);
  }

  void _triggerInitialMySubjects(
      TriggerInitialMySubjectsEvent event, Emitter<HomeState> emit) {
    emit(InitialMySubjectsStates(
      subjectItem: state.subjectItem,
    ));
  }

  void _triggerLoadedMySubjects(
      TriggerLoadedMySubjectsEvent event, Emitter<HomeState> emit) {
    // final listSubject = List<SubjectItem>.from(state.subjectItem!);

    // for (var item in event.subjectItem) {
    //   int topicDone = 1;
    //   double totalScore = 0;
    //   double starScore = 0;
    //   double progress = 0;
    //   for (var answer in event.answerList) {
    //     if (answer.studentToken ==
    //         Global.storageService.getStudentProfile().token) {
    //       if (answer.subjectId == item.id) {
    //         totalScore =
    //             ((totalScore + (answer.totalScore! / 100)) / item.totalTopic!);
    //         progress = (topicDone / item.totalTopic!) * 100;
    //         topicDone++;
    //       }
    //     }
    //   }
    //   starScore = Global.starCalculation(totalScore);
    //   listSubject.add(SubjectItem(
    //     id: item.id,
    //     name_bm: item.name_bm,
    //     name_eng: item.name_eng,
    //     totalTopic: item.totalTopic,
    //     star: starScore,
    //     progress: progress,
    //   ));
    //   // foundMatch = true;
    //   // break; // Exit the inner loop once a match is found
    // }

    emit(LoadedMySubjectsStates(
      subjectItem: event.subjectItem,
    ));
  }

  void _triggerLoadingMySubjects(
      TriggerLoadingMySubjectsEvent event, Emitter<HomeState> emit) {
    emit(LoadingMySubjectsStates(
      subjectItem: state.subjectItem,
    ));
  }

  void _triggerDoneLoadingMySubjects(
      TriggerDoneLoadingMySubjectsEvent event, Emitter<HomeState> emit) {
    emit(DoneLoadingMySubjectsStates(
      subjectItem: state.subjectItem,
    ));
  }
}



    // on<InitSocket>((event, emit) {
    //   SocketIoService().newSocket();

    //   _subscription = SocketIoService().socketStream.listen((event) {
    //     print(event);
    //     _streamController.add(event);
    //   });

    //   emit(SocketInited());

    //   return emit.forEach(_streamController.stream, onData: (dynamic rawEvent) {
    //     final event = Event.fromJson(rawEvent as Map<String, dynamic>);

    //     if (event.eventName == SocketIoEvent.getPackage.eventName) {
    //       print(event.result);

    //       return SocketInited();
    //     }

    //     return SocketInited();
    //   });
    // });

    // on<RegisterListener>((event, emit) {
    //   _subscription = SocketIoService().socketStream.listen((event) {
    //     _streamController.add(event);
    //   });
    //   emit(ListenerRegistered());
    //   print(_subscription);

    //   return emit.forEach(_streamController.stream, onData: (dynamic rawEvent) {
    //     final event = Event.fromJson(rawEvent as Map<String, dynamic>);
    //     print(event.result);

    //     if (event.eventName == SocketIoEvent.getPackage.eventName) {
    //       final package = Package.fromJson(
    //         event.result,
    //       );
    //     }

    //     return NoEvent();
    //   });
    // });
  // }

  

  // @override
  // Future<void> close() {
  //   _streamController.close();
  //   _subscription?.cancel();
  //   return super.close();
  // }
// }
