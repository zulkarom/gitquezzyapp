part of 'app_parent_bloc.dart';

class AppParentState extends Equatable {
  final int index;
  final String password;
  final String rePassword;
  const AppParentState({
    this.index = 0,
    this.password = "",
    this.rePassword = "",
  });

  AppParentState copyWith({int? index, String? password, String? rePassword}) {
    return AppParentState(
        index: index ?? this.index,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword);
  }

  @override
  List<Object?> get props => [index, password, rePassword];
}

class AppParentInitial extends AppParentState {}
