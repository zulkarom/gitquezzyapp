import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final String id;
  final String studentId;
  final String questionId;
  final String itemId;
  final int isAnswer;

  const Answer({
    required this.id,
    required this.studentId,
    required this.questionId,
    required this.itemId,
    required this.isAnswer,
  });

  Answer copyWith({
    String? id,
    String? studentId,
    String? questionId,
    String? itemId,
    int? isAnswer,
  }) {
    return Answer(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      questionId: questionId ?? this.questionId,
      itemId: itemId ?? this.itemId,
      isAnswer: isAnswer ?? this.isAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'questionId': questionId,
      'itemId': itemId,
      'isAnswer': isAnswer
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] ?? '',
      studentId: map['studentId'] ?? '',
      questionId: map['questionId'] ?? '',
      itemId: map['itemId'] ?? '',
      isAnswer: map['isAnswer'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        studentId,
        questionId,
        itemId,
        isAnswer,
      ];
}
