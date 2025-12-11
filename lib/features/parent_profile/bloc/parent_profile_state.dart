part of 'parent_profile_bloc.dart';

class ParentProfileState extends Equatable {
  final String? name;
  final String? email;
  final UserItem? userItem;
  final String? avatarUrl;
  final List<AvatarItem>? avatarItem;
  final String? oldPassword;
  final String? newPassword;
  final String? newRePassword;

  const ParentProfileState({
    this.name,
    this.email,
    this.userItem,
    this.avatarItem,
    this.avatarUrl,
    this.oldPassword,
    this.newPassword,
    this.newRePassword,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        userItem,
        avatarUrl,
        avatarItem,
        oldPassword,
        newPassword,
        newRePassword,
      ];

  ParentProfileState copyWith({
    String? name,
    String? email,
    UserItem? userItem,
    String? avatarUrl,
    List<AvatarItem>? avatarItem,
    String? oldPassword,
    String? newPassword,
    String? newRePassword,
  }) {
    return ParentProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      userItem: userItem ?? this.userItem,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarItem: avatarItem ?? this.avatarItem,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      newRePassword: newRePassword ?? this.newRePassword,
    );
  }
}

class InitialUserItemState extends ParentProfileState {
  const InitialUserItemState({
    required super.userItem,
  });
}

class AvatarUrlState extends ParentProfileState {
  const AvatarUrlState({
    required super.avatarUrl,
    required super.userItem,
  });
}
