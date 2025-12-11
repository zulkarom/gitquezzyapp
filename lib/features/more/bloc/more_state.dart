part of 'more_bloc.dart';

class MoreState extends Equatable {
  final List<StudentItem> studentItem;
  final List<SubscribeItem> subPackageItem;
  final String pin;

  const MoreState({
    this.studentItem = const <StudentItem>[],
    this.subPackageItem = const <SubscribeItem>[],
    this.pin = '',
  });

  @override
  List<Object> get props => [
        studentItem,
        subPackageItem,
        pin,
      ];

  MoreState copyWith({
    List<StudentItem>? studentItem,
    List<SubscribeItem>? subPackageItem,
    String? pin,
  }) {
    return MoreState(
      studentItem: studentItem ?? this.studentItem,
      subPackageItem: subPackageItem ?? this.subPackageItem,
      pin: pin ?? this.pin,
    );
  }
}

class MoreInitial extends MoreState {}
