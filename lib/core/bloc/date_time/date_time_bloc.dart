import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../services/intl/intl_service.dart';

part 'date_time_event.dart';
part 'date_time_state.dart';

class DateTimeBloc extends HydratedBloc<DateTimeEvent, DateTimeState> {
  DateTimeBloc() : super(const DateTimeInitial(DateTimeFormat.twelveHourLongDate)) {
    IntlService().setFormat(state.dateTimeFormat);
    on<SetDateTime>((event, emit) {
      IntlService().setFormat(event.format);
      emit(DateTimeSet(event.format));
    });
  }

  @override
  DateTimeState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return DateTimeSet(DateTimeFormat.values[json['index'] as int]);
    }
    return const DateTimeSet(DateTimeFormat.twelveHourLongDate);
  }

  @override
  Map<String, dynamic>? toJson(DateTimeState state) {
    try {
      return {
        'index': state.dateTimeFormat.index,
      };
    } catch (e) {
      return {};
    }
  }
}
