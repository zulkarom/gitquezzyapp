import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

abstract class HomeState extends Equatable {
  final List<SubjectItem>? subjectItem;

  const HomeState({
    this.subjectItem,
  });

  @override
  List<Object?> get props => [subjectItem];
}

class InitialMySubjectsStates extends HomeState {
  const InitialMySubjectsStates({required super.subjectItem});
}

class LoadingMySubjectsStates extends HomeState {
  const LoadingMySubjectsStates({required super.subjectItem});
}

class DoneLoadingMySubjectsStates extends HomeState {
  const DoneLoadingMySubjectsStates({required super.subjectItem});
}

class LoadedMySubjectsStates extends HomeState {
  const LoadedMySubjectsStates({required super.subjectItem});
}



// class ListenerRegistered extends HomeState {
//   ListenerRegistered();
// }

// class SocketInited extends HomeState {
//   SocketInited();
// }

// class NoEvent extends HomeState {
//   NoEvent();
// }
