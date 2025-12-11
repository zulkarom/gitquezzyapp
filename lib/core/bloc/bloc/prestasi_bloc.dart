import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'prestasi_event.dart';
part 'prestasi_state.dart';

class PrestasiBloc extends Bloc<PrestasiEvent, PrestasiState> {
  PrestasiBloc() : super(PrestasiInitial()) {
    on<PrestasiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
