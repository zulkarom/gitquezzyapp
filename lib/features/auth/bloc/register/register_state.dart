part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String rePassword;

  //optional named parameter
  const RegisterState(
      {this.name = "",
      this.email = "",
      this.password = "",
      this.rePassword = ""});

  RegisterState copyWith(
      {String? name, String? email, String? password, String? rePassword}) {
    return RegisterState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword);
  }

  @override
  List<Object?> get props => [name, email, password, rePassword];
}
