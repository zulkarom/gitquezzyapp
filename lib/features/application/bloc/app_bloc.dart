import 'package:bloc/bloc.dart';
import 'package:quezzy_app/global.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(AppState(
          index: 0,
          packageName: Global.storageService.getPackageName(),
        )) {
    on<TriggerAppEvent>((event, emit) {
      emit(AppState(index: event.index, packageName: state.packageName));
    });
    on<PackageChanged>((event, emit) {
      emit(AppState(index: state.index, packageName: event.packageName));
    });
  }
}
