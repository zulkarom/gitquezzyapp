part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class NameEvent extends RegisterEvent {
  final String name;
  const NameEvent(this.name);
}

class EmailEvent extends RegisterEvent {
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends RegisterEvent {
  final String password;
  const PasswordEvent(this.password);
}

class RePasswordEvent extends RegisterEvent {
  final String rePassword;
  const RePasswordEvent(this.rePassword);
}
