part of 'parent_profile_bloc.dart';

class ParentProfileEvent extends Equatable {
  const ParentProfileEvent();

  @override
  List<Object> get props => [];
}

class NameEvent extends ParentProfileEvent {
  final String name;
  const NameEvent(this.name);
}

class EmailEvent extends ParentProfileEvent {
  final String email;
  const EmailEvent(this.email);
}

class AvatarListEvent extends ParentProfileEvent {
  const AvatarListEvent(this.avatarItem);
  final List<AvatarItem> avatarItem;
}

class AvatarUrlEvent extends ParentProfileEvent {
  final String avatarUrl;
  const AvatarUrlEvent(this.avatarUrl);
}

class OldPasswordEvent extends ParentProfileEvent {
  final String oldPassword;
  const OldPasswordEvent(this.oldPassword);
}

class NewPasswordEvent extends ParentProfileEvent {
  final String newPassword;
  const NewPasswordEvent(this.newPassword);
}

class ReNewPasswordEvent extends ParentProfileEvent {
  final String reNewPassword;
  const ReNewPasswordEvent(this.reNewPassword);
}

class TriggerInitialUserItemEvent extends ParentProfileEvent {
  const TriggerInitialUserItemEvent(this.userItem);
  final UserItem userItem;

  @override
  List<Object> get props => [userItem];
}
