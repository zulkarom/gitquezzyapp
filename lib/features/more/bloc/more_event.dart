part of 'more_bloc.dart';

class MoreEvent extends Equatable {
  const MoreEvent();

  @override
  List<Object> get props => [];
}

class StudentListItem extends MoreEvent {
  const StudentListItem(this.studentItem);
  final List<StudentItem> studentItem;
}

class SubscribeListItem extends MoreEvent {
  const SubscribeListItem(this.subscribeItem);
  final List<SubscribeItem> subscribeItem;
}

class PinEvent extends MoreEvent {
  final String pin;
  const PinEvent(this.pin);
}
