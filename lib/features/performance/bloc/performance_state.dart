part of 'performance_bloc.dart';

abstract class PerformanceState extends Equatable {
  final SubscribeItem? subscribeItem;
  const PerformanceState({
    this.subscribeItem,
  });

  @override
  List<Object?> get props => [subscribeItem];
}

class InitialMyPerformanceStates extends PerformanceState {
  const InitialMyPerformanceStates({required super.subscribeItem});
}

class LoadingMyPerformanceStates extends PerformanceState {
  const LoadingMyPerformanceStates({required super.subscribeItem});
}

class DoneLoadingMyPerformanceStates extends PerformanceState {
  const DoneLoadingMyPerformanceStates({required super.subscribeItem});
}

class LoadedMyPerformanceStates extends PerformanceState {
  const LoadedMyPerformanceStates({required super.subscribeItem});
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
