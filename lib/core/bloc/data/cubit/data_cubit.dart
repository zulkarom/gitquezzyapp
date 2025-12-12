import 'package:quezzy_app/core/bloc/data/cubit/data_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class DataCubit extends HydratedCubit<DataState> {
  DataCubit() : super(const DataState());

  void setStudentId(int studentId) {
    emit(DataState(studentId: studentId));
  }

  @override
  DataState fromJson(Map<String, dynamic> json) {
    return DataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(DataState state) {
    return state.toMap();
  }
}
