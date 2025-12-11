import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/models/student.dart';
import 'package:flutter_ta_plus/core/models/subscribe.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreBloc() : super(const MoreState()) {
    on<StudentListItem>(_studentListItem);
    on<SubscribeListItem>(_subscribeListItem);
    on<PinEvent>(_pinEvent);
  }

  void _studentListItem(StudentListItem event, Emitter<MoreState> emit) {
    emit(state.copyWith(studentItem: event.studentItem));
  }

  void _subscribeListItem(SubscribeListItem event, Emitter<MoreState> emit) {
    emit(state.copyWith(subPackageItem: event.subscribeItem));
  }

  void _pinEvent(PinEvent event, Emitter<MoreState> emit) {
    emit(state.copyWith(pin: event.pin));
  }
}
