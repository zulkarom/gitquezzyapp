import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';

part 'parent_profile_event.dart';
part 'parent_profile_state.dart';

class ParentProfileBloc extends Bloc<ParentProfileEvent, ParentProfileState> {
  ParentProfileBloc() : super(const ParentProfileState()) {
    // on<ParentProfileEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<NameEvent>(_nameEvent);
    on<EmailEvent>(_emailEvent);
    on<AvatarListEvent>(_avatarListItem);
    on<AvatarUrlEvent>(_avatarUrlEvent);
    on<OldPasswordEvent>(_oldPasswordEvent);
    on<NewPasswordEvent>(_newPasswordEvent);
    on<ReNewPasswordEvent>(_reNewPasswordEvent);
    on<TriggerInitialUserItemEvent>(_triggerInitialUserItemEvent);
  }

  void _nameEvent(NameEvent event, Emitter<ParentProfileState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _emailEvent(EmailEvent event, Emitter<ParentProfileState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _avatarListItem(
      AvatarListEvent event, Emitter<ParentProfileState> emit) {
    emit(state.copyWith(avatarItem: event.avatarItem));
  }

  void _avatarUrlEvent(AvatarUrlEvent event, Emitter<ParentProfileState> emit) {
    return emit(AvatarUrlState(
      avatarUrl: event.avatarUrl,
      userItem: state.userItem,
    ));
  }

  //Reset Password
  void _oldPasswordEvent(
      OldPasswordEvent event, Emitter<ParentProfileState> emit) {
    // print("${event.password}");
    emit(state.copyWith(oldPassword: event.oldPassword));
  }

  void _newPasswordEvent(
      NewPasswordEvent event, Emitter<ParentProfileState> emit) {
    // print("${event.password}");
    emit(state.copyWith(newPassword: event.newPassword));
  }

  void _reNewPasswordEvent(
      ReNewPasswordEvent event, Emitter<ParentProfileState> emit) {
    // print("${event.password}");
    emit(state.copyWith(newRePassword: event.reNewPassword));
  }

  void _triggerInitialUserItemEvent(
      TriggerInitialUserItemEvent event, Emitter<ParentProfileState> emit) {
    emit(InitialUserItemState(
      userItem: event.userItem,
    ));
  }
}
