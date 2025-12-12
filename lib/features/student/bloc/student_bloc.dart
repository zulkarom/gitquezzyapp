import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/failures/failure.dart';
import '../../../core/models/avatar.dart';
import '../../../core/models/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  // final AuthRepository? authRepository;
  StudentBloc() : super(const StudentState()) {
    // final StudentController asynCreateStudent = StudentController(context: context)
    on<StudentListItem>(_studentListItem);
    on<AvatarListItem>(_avatarListItem);
    on<AvatarEvent>(_avatarEvent);
    on<NameEvent>(_nameEvent);
    on<PasswordEvent>(_passwordEvent);
    on<PinEvent>(_pinEvent);
    on<NewPinEvent>(_newPinEvent);
    on<EditIconEvent>(_editIconEvent);
    on<MainPasswordConfirmEvent>(_mainPasswordEvent);
    // on<AddStudent>((event, emit) async {
    //   if (event.name.trim().isEmpty) {
    //     return emit(
    //       StudentAddFailed(
    //         failure: Failure('Name must not be empty'),
    //       ),
    //     );
    //   } else if (event.password != event.confirmPassword) {
    //     return emit(
    //       StudentAddFailed(
    //         failure: Failure('Password did not match'),
    //       ),
    //     );
    //   } else {
    //     try {
    //       final createStudent = await authRepository?.asyncPostStudentData(
    //           event.name, event.password);
    //       print('createStudent');
    //       print(createStudent);
    //       if (createStudent == true) {
    //         print('berjaya masuk');
    //       }
    //     } catch (e) {
    //       return emit(StudentAddFailed(
    //         failure: Failure('Not success'),
    //       ));
    //     }
    //   }
    // });
  }

  void _studentListItem(StudentListItem event, Emitter<StudentState> emit) {
    emit(state.copyWith(studentItem: event.studentItem));
  }

  void _avatarListItem(AvatarListItem event, Emitter<StudentState> emit) {
    emit(state.copyWith(avatarItem: event.avatarItem));
  }

  void _nameEvent(NameEvent event, Emitter<StudentState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _avatarEvent(AvatarEvent event, Emitter<StudentState> emit) {
    emit(state.copyWith(avatarUrl: event.avatarUrl));
  }

  void _passwordEvent(PasswordEvent event, Emitter<StudentState> emit) {
    print("my pin is ${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void _mainPasswordEvent(
      MainPasswordConfirmEvent event, Emitter<StudentState> emit) {
    // print("my password is ${event.password}");
    emit(state.copyWith(mainPassword: event.mainPassword));
  }

  void _pinEvent(PinEvent event, Emitter<StudentState> emit) {
    emit(state.copyWith(pin: event.pin));
  }

  void _newPinEvent(NewPinEvent event, Emitter<StudentState> emit) {
    emit(state.copyWith(newPin: event.newPin));
  }

  void _editIconEvent(EditIconEvent event, Emitter<StudentState> emit) {
    emit(state.copyWith(editIndex: event.editIndex));
  }
}
