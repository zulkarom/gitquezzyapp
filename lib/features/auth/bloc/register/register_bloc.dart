import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<NameEvent>(_nameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
  }

  void _nameEvent(NameEvent event, Emitter<RegisterState> emit) {
    // print("${event.email}");
    emit(state.copyWith(name: event.name));
  }

  void _emailEvent(EmailEvent event, Emitter<RegisterState> emit) {
    // print("${event.email}");
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterState> emit) {
    // print("${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(RePasswordEvent event, Emitter<RegisterState> emit) {
    // print("${event.rePassword}");
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
