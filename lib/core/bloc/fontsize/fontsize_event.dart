part of 'fontsize_bloc.dart';

abstract class FontsizeEvent extends Equatable {
  const FontsizeEvent();

  @override
  List<Object> get props => [];
}

class SetFontSize extends FontsizeEvent {
  final Size fontsize;

  const SetFontSize(this.fontsize);
}

class SetStudentId extends FontsizeEvent {
  final int studentId;

  const SetStudentId(this.studentId);
}
