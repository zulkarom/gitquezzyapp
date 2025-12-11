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

  AppParentState copyWith({String? password, String? rePassword}) {
    return AppParentState(
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword);
  }

  @override
  List<Object?> get props => [password, rePassword];
}

class AppParentInitial extends AppParentState {}
