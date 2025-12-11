part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String name;
  final String schoolName;
  final String pin;
  final String newPin;
  final int editIndex;
  final String mainPassword;
  final String avatarUrl;
  final List<AvatarItem> avatarItem;
  final StudentItem? studentItem;

  const ProfileState({
    this.name = "",
    this.schoolName = "",
    this.pin = "",
    this.newPin = "",
    this.editIndex = 0,
    this.mainPassword = "",
    this.avatarUrl = "",
    this.avatarItem = const <AvatarItem>[],
    this.studentItem,
  });

  @override
  List<Object?> get props => [
        name,
        schoolName,
        pin,
        newPin,
        editIndex,
        avatarUrl,
        avatarItem,
        studentItem
      ];

  ProfileState copyWith({
    String? name,
    String? schoolName,
    String? pin,
    String? newPin,
    int? editIndex,
    String? mainPassword,
    String? avatarUrl,
    List<AvatarItem>? avatarItem,
    StudentItem? studentItem,
  }) {
    return ProfileState(
      name: name ?? this.name,
      schoolName: schoolName ?? this.schoolName,
      pin: pin ?? this.pin,
      newPin: newPin ?? this.newPin,
      editIndex: editIndex ?? this.editIndex,
      mainPassword: mainPassword ?? this.mainPassword,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarItem: avatarItem ?? this.avatarItem,
      studentItem: studentItem ?? this.studentItem,
    );
  }
}

class AvatarUrlState extends ProfileState {
  const AvatarUrlState({
    required super.avatarUrl,
    required super.studentItem,
  });
}

class InitialStudentItemState extends ProfileState {
  const InitialStudentItemState({
    required super.avatarUrl,
    required super.studentItem,
  });
}
