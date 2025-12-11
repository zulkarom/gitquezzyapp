import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures/failure.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<InitScreen>((event, emit) async {
      emit(const SplashLoading());
      // init messaging service
      // final result = await MessagingService().initService();

      // result!.fold(
      //   (l) => emit(SplashInitFailed(l)),
      //   (r) => emit(SplashInitSucceed()),
      // );

      emit(SplashInitSucceed());
    });
  }
}
