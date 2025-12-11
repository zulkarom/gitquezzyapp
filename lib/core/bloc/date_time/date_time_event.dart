part of 'date_time_bloc.dart';

abstract class DateTimeEvent extends Equatable {
  const DateTimeEvent();

  @override
  List<Object> get props => [];
}

class SetDateTime extends DateTimeEvent {
  final DateTimeFormat format;
  const SetDateTime(this.format);
}
