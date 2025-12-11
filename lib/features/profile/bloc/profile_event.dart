part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class StudentProfileEvent extends ProfileEvent {
  final StudentItem studentItem;
  const StudentProfileEvent(this.studentItem);
}

class AvatarListEvent extends ProfileEvent {
  const AvatarListEvent(this.avatarItem);
  final List<AvatarItem> avatarItem;
}

class AvatarUrlEvent extends ProfileEvent {
  final String avatarUrl;
  const AvatarUrlEvent(this.avatarUrl);
}

class NameEvent extends ProfileEvent {
  final String name;
  const NameEvent(this.name);
}

class EditIconEvent extends ProfileEvent {
  final int editIndex;
  const EditIconEvent(this.editIndex) : super();
}

class SchoolEvent extends ProfileEvent {
  final String schoolName;
  const SchoolEvent(this.schoolName);
}

class PinEvent extends ProfileEvent {
  final String pin;
  const PinEvent(this.pin);
}

class NewPinEvent extends ProfileEvent {
  final String newPin;
  const NewPinEvent(this.newPin);
}

class TriggerInitialStudentItemEvent extends ProfileEvent {
  const TriggerInitialStudentItemEvent(this.studentItem);
  final StudentItem studentItem;

  @override
  List<Object> get props => [studentItem];
}
