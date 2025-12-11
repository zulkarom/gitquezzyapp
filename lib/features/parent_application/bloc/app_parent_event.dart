part of 'app_parent_bloc.dart';

class AppParentEvent extends Equatable {
  const AppParentEvent();

  @override
  List<Object?> get props => [];
}

class TriggerAppEvent extends AppParentEvent {
  final int index;
  const TriggerAppEvent(this.index) : super();
}

class PasswordEvent extends AppParentEvent {
  final String password;
  const PasswordEvent(this.password);
}

class RePasswordEvent extends AppParentEvent {
  final String rePassword;
  const RePasswordEvent(this.rePassword);
}
