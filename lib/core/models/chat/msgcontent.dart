import 'package:cloud_firestore/cloud_firestore.dart';

class Msgcontent {
  final String? docId;
  final String? token;
  final String? content;
  final String? type;
  final Timestamp? addtime;

  Msgcontent({
    this.docId,
    this.token,
    this.content,
    this.type,
    this.addtime,
  });

  factory Msgcontent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Msgcontent(
      docId: data?['doc_id'],
      token: data?['token'],
      content: data?['content'],
      type: data?['type'],
      addtime: data?['addtime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (docId != null) "doc_id": docId,
      if (token != null) "token": token,
      if (content != null) "content": content,
      if (type != null) "type": type,
      if (addtime != null) "addtime": addtime,
    };
  }
}
