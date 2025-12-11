import 'package:cloud_firestore/cloud_firestore.dart';

class Answercontent {
  final String? docId;
  final int? questionId;
  final int? itemId;
  final int? isAnswer;

  Answercontent({
    this.docId,
    this.questionId,
    this.itemId,
    this.isAnswer,
  });

  factory Answercontent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Answercontent(
      docId: data?['doc_id'],
      questionId: data?['question_id'],
      itemId: data?['item_id'],
      isAnswer: data?['is_answer'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (docId != null) "doc_id": docId,
      if (questionId != null) "question_id": questionId,
      if (itemId != null) "item_id": itemId,
      if (isAnswer != null) "is_answer": isAnswer,
    };
  }
}
