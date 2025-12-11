part of 'date_time_bloc.dart';

abstract class DateTimeState extends Equatable {
  final DateTimeFormat dateTimeFormat;
  const DateTimeState(this.dateTimeFormat);

  @override
  List<Object> get props => [dateTimeFormat];
}

class DateTimeInitial extends DateTimeState {
  const DateTimeInitial(super.dateTimeFormat);
}

class DateTimeSet extends DateTimeState {
  const DateTimeSet(super.dateTimeFormat);
}
