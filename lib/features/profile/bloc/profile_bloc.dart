import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<AvatarListEvent>(_avatarListItem);
    on<AvatarUrlEvent>(_avatarUrlEvent);
    on<NameEvent>(_nameEvent);
    on<SchoolEvent>(_schoolEvent);
    on<PinEvent>(_pinEvent);
    on<NewPinEvent>(_newPinEvent);
    on<EditIconEvent>(_editIconEvent);
    on<TriggerInitialStudentItemEvent>(_triggerInitialStudentItemEvent);
  }

  void _avatarListItem(AvatarListEvent event, Emitter<ProfileState> emit) {
    // print("event.avatarItem.length");
    // print(event.avatarItem.length);
    emit(state.copyWith(avatarItem: event.avatarItem));
  }

  void _avatarUrlEvent(AvatarUrlEvent event, Emitter<ProfileState> emit) {
    return emit(AvatarUrlState(
      avatarUrl: event.avatarUrl,
      studentItem: state.studentItem,
    ));
  }

  void _nameEvent(NameEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _schoolEvent(SchoolEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(schoolName: event.schoolName));
  }

  void _pinEvent(PinEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(pin: event.pin));
  }

  void _newPinEvent(NewPinEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(newPin: event.newPin));
  }

  void _editIconEvent(EditIconEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(editIndex: event.editIndex));
  }

  void _triggerInitialStudentItemEvent(
      TriggerInitialStudentItemEvent event, Emitter<ProfileState> emit) {
    emit(InitialStudentItemState(
      avatarUrl: state.avatarUrl,
      studentItem: event.studentItem,
    ));
  }
}
