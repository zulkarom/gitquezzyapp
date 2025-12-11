part of 'student_bloc.dart';

class StudentState extends Equatable {
  final List<StudentItem> studentItem;
  final List<AvatarItem> avatarItem;
  final String name;
  final String password;
  final String pin;
  final String newPin;
  final int editIndex;
  final String mainPassword;
  final String avatarUrl;

  const StudentState({
    this.studentItem = const <StudentItem>[],
    this.avatarItem = const <AvatarItem>[],
    this.name = "",
    this.password = "",
    this.pin = "",
    this.newPin = "",
    this.editIndex = 0,
    this.mainPassword = "",
    this.avatarUrl = "",
  });

  @override
  List<Object?> get props => [
        studentItem,
        name,
        password,
        pin,
        newPin,
        editIndex,
        avatarItem,
        avatarUrl
      ];

  StudentState copyWith(
      {List<StudentItem>? studentItem,
      List<AvatarItem>? avatarItem,
      String? name,
      String? password,
      String? pin,
      String? newPin,
      int? editIndex,
      String? mainPassword,
      String? avatarUrl}) {
    return StudentState(
      studentItem: studentItem ?? this.studentItem,
      avatarItem: avatarItem ?? this.avatarItem,
      name: name ?? this.name,
      password: password ?? this.password,
      pin: pin ?? this.pin,
      newPin: newPin ?? this.newPin,
      editIndex: editIndex ?? this.editIndex,
      mainPassword: mainPassword ?? this.mainPassword,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class StudentAdded extends StudentState {
  final StudentItem student;

  const StudentAdded({
    required this.student,
  });

  @override
  List<Object?> get props => super.props..addAll([student]);
}

class StudentAddFailed extends StudentState {
  final Failure failure;
  const StudentAddFailed({
    required this.failure,
  });
}
