import 'package:equatable/equatable.dart';

// State
class DataState extends Equatable {
  final int? studentId;

  const DataState({this.studentId});

  @override
  List<Object?> get props => [studentId];

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
    };
  }

  factory DataState.fromMap(Map<String, dynamic> map) {
    return DataState(
      studentId: map['studentId'],
    );
  }
}
