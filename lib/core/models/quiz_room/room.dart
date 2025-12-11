import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities.dart';

class Room {
  int? packageId;
  int? subjectId;
  int? status; // 10 : waiting, 20 : in progress, 30 : finished
  Timestamp? time;
  String? student_token;
  SubjectItem? subjectItem;
  TopicItem? topicItem;
  LevelItem? levelItem;
  String? roomDocId;

  Room({
    this.packageId,
    this.subjectId,
    this.status,
    this.time,
    this.student_token,
    this.subjectItem,
    this.topicItem,
    this.levelItem,
    this.roomDocId,
  });

  Map<String, dynamic> toMap() {
    return {
      'packageId': packageId,
      'subjectId': subjectId,
      'status': status,
      'time': time,
      'student_token': student_token,
      'subjectItem': subjectItem?.toJson(),
      'topicItem': topicItem?.toJson(),
      'levelItem': levelItem?.toJson(),
      'roomDocId': roomDocId,
    };
  }

  factory Room.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final subjectItemData = data?['subjectItem'];
    final topicItemData = data?['topicItem'];
    final levelItemData = data?['levelItem'];
    return Room(
      packageId: data?['package_id'],
      subjectId: data?['subject_id'],
      status: data?['status'],
      time: data?['time'],
      student_token: data?['student_token'],
      subjectItem: subjectItemData != null
          ? SubjectItem.fromJson(subjectItemData) // Convert map to SubjectItem
          : null,
      topicItem: topicItemData != null
          ? TopicItem.fromJson(topicItemData) // Convert map to TopicItem
          : null,
      levelItem: levelItemData != null
          ? LevelItem.fromJson(levelItemData) // Convert map to LevelItem
          : null,
      roomDocId: data?['room_doc_id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (packageId != null) "package_id": packageId,
      if (subjectId != null) "subject_id": subjectId,
      if (status != null) "status": status,
      if (time != null) "time": time,
      if (student_token != null) "student_token": student_token,
      if (subjectItem != null) "subjectItem": subjectItem!.toJson(),
      if (topicItem != null) "topicItem": topicItem!.toJson(),
      if (levelItem != null) "levelItem": levelItem!.toJson(),
      if (roomDocId != null) "room_doc_id": roomDocId,
    };
  }
}
