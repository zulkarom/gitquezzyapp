import 'package:equatable/equatable.dart';

class PlayerAnswer extends Equatable {
  final int questionId;
  final int itemId;
  final int isAnswer;

  const PlayerAnswer({
    required this.questionId,
    required this.itemId,
    required this.isAnswer,
  });

  PlayerAnswer copyWith({
    int? questionId,
    int? itemId,
    int? isAnswer,
  }) {
    return PlayerAnswer(
      questionId: questionId ?? this.questionId,
      itemId: itemId ?? this.itemId,
      isAnswer: isAnswer ?? this.isAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question_id': questionId,
      'item_id': itemId,
      'is_answer': isAnswer
    };
  }

  factory PlayerAnswer.fromMap(Map<String, dynamic> map) {
    return PlayerAnswer(
      isAnswer: map['is_answer'] ?? '',
      itemId: map['item_id'] ?? '',
      questionId: map['question_id'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        questionId,
        itemId,
        isAnswer,
      ];
}
