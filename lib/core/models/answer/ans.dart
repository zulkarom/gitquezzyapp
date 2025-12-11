import 'package:cloud_firestore/cloud_firestore.dart';

class Ans {
  String? studentToken;
  String? name;
  String? avatar;
  int? packageId;
  int? subjectId;
  int? topicId;
  int? levelId;
  double? starScore;
  double? totalScore;

  Ans({
    this.studentToken,
    this.name,
    this.avatar,
    this.packageId,
    this.subjectId,
    this.topicId,
    this.levelId,
    this.starScore,
    this.totalScore,
  });

  factory Ans.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Ans(
      studentToken: data?['student_token'],
      name: data?['name'],
      avatar: data?['avatar'],
      packageId: data?['package_id'],
      subjectId: data?['subject_id'],
      topicId: data?['topic_id'],
      levelId: data?['level_id'],
      starScore: data?['star_score'],
      totalScore: data?['total_score'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (studentToken != null) "student_token": studentToken,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (packageId != null) "package_id": packageId,
      if (subjectId != null) "subject_id": subjectId,
      if (topicId != null) "topic_id": topicId,
      if (levelId != null) "level_id": levelId,
      if (starScore != null) "star_score": starScore,
      if (totalScore != null) "total_score": totalScore,
    };
  }

  factory Ans.fromMap(Map<String, dynamic> data) {
    return Ans(
      studentToken: data['student_token'] ?? '',
      name: data['name'] ?? '',
      avatar: data['avatar'] ?? '',
      packageId: data['package_id'] ?? 0,
      subjectId: data['subject_id'] ?? 0,
      topicId: data['topic_id'] ?? 0,
      levelId: data['level_id'] ?? 0,
      starScore: data['star_score'] ?? 0,
      totalScore: data['total_score'] ?? 0,
    );
  }
}
