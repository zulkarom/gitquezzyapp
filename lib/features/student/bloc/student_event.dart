part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class StudentListItem extends StudentEvent {
  const StudentListItem(this.studentItem);
  final List<StudentItem> studentItem;
}

class AvatarListItem extends StudentEvent {
  const AvatarListItem(this.avatarItem);
  final List<AvatarItem> avatarItem;
}

class AvatarEvent extends StudentEvent {
  final String avatarUrl;
  const AvatarEvent(this.avatarUrl);
}

class NameEvent extends StudentEvent {
  final String name;
  const NameEvent(this.name);
}

class EditIconEvent extends StudentEvent {
  final int editIndex;
  const EditIconEvent(this.editIndex) : super();
}

class PasswordEvent extends StudentEvent {
  final String password;
  const PasswordEvent(this.password);
}

class PinEvent extends StudentEvent {
  final String pin;
  const PinEvent(this.pin);
}

class NewPinEvent extends StudentEvent {
  final String newPin;
  const NewPinEvent(this.newPin);
}

class MainPasswordConfirmEvent extends StudentEvent {
  final String mainPassword;
  const MainPasswordConfirmEvent(this.mainPassword);
}

class AddStudent extends StudentEvent {
  final String name;
  final String password;

  const AddStudent({
    required this.name,
    required this.password,
  });
}

class EditStudent extends StudentEvent {
  final String name;
  final String password;

  const EditStudent({
    required this.name,
    required this.password,
  });
}
