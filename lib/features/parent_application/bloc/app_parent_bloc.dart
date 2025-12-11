import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_parent_event.dart';
part 'app_parent_state.dart';

class AppParentBloc extends Bloc<AppParentEvent, AppParentState> {
  AppParentBloc() : super(const AppParentState()) {
    on<TriggerAppEvent>((event, emit) {
      emit(AppParentState(index: event.index));
    });
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
  }

  void _passwordEvent(PasswordEvent event, Emitter<AppParentState> emit) {
    // print("${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(RePasswordEvent event, Emitter<AppParentState> emit) {
    // print("${event.rePassword}");
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
