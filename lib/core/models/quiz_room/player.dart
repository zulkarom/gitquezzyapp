import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String? docId;
  final String? studentToken;
  final String? name;
  final String? avatar;
  final Timestamp? entryTime;
  final int?
      status; //10 : waiting, 20 : accept, 30 : in progress, 40: completed
  final int? isAdmin; // 0 : not admin, 1 : admin
  final int?
      totalQuestion; // to count the total question that have been answer by player.
  final double? totalMark;

  Player({
    this.docId,
    this.studentToken,
    this.name,
    this.avatar,
    this.entryTime,
    this.status,
    this.isAdmin,
    this.totalQuestion,
    this.totalMark,
  });

  Player copyWith({
    String? docId,
    String? studentToken,
    String? name,
    String? avatar,
    Timestamp? entryTime,
    int? status,
    int? isAdmin,
    int? totalQuestion,
    double? totalMark,
  }) {
    return Player(
      docId: docId ?? this.docId,
      studentToken: studentToken ?? this.studentToken,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      entryTime: entryTime ?? this.entryTime,
      status: status ?? this.status,
      isAdmin: isAdmin ?? this.isAdmin,
      totalQuestion: totalQuestion ?? this.totalQuestion,
      totalMark: totalMark ?? this.totalMark,
    );
  }

  factory Player.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Player(
      docId: data?['doc_id'],
      studentToken: data?['student_token'],
      name: data?['name'],
      avatar: data?['avatar'],
      entryTime: data?['entry_time'],
      status: data?['status'],
      isAdmin: data?['is_admin'],
      totalQuestion: data?['total_question'],
      totalMark: data?['total_mark'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (docId != null) "doc_id": docId,
      if (studentToken != null) "student_token": studentToken,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (entryTime != null) "entry_time": entryTime,
      if (status != null) "status": status,
      if (isAdmin != null) "is_admin": isAdmin,
      if (totalQuestion != null) "total_question": totalQuestion,
      if (totalMark != null) "total_mark": totalMark,
    };
  }
}
