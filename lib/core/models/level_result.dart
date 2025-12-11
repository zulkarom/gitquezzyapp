class LevelResultRequestEntity {
  int? studentId;
  int? topicId;

  LevelResultRequestEntity({
    this.studentId,
    this.topicId,
  });

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "topic_id": topicId,
      };
}

class LevelResultListResponseEntity {
  int? code;
  String? msg;
  List<LevelResultItem>? data;

  LevelResultListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory LevelResultListResponseEntity.fromJson(Map<String, dynamic> json) =>
      LevelResultListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<LevelResultItem>.from(
                json["data"].map((x) => LevelResultItem.fromJson(x))),
      );
}

//api post response msg
class LevelResultDetailResponseEntity {
  int? code;
  String? msg;
  LevelResultItem? data;

  LevelResultDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory LevelResultDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      LevelResultDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: LevelResultItem.fromJson(json["data"]),
      );
}

class LevelResultItem {
  int? id;
  int? studentId;
  int? levelId;
  int? isDone;
  int? totalMark;

  LevelResultItem({
    this.id,
    this.studentId,
    this.levelId,
    this.isDone,
    this.totalMark,
  });

  factory LevelResultItem.fromJson(Map<String, dynamic> json) =>
      LevelResultItem(
        id: json["id"],
        studentId: json["student_id"],
        levelId: json["level_id"],
        isDone: json["is_done"],
        totalMark: json["total_mark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "level_id": levelId,
        "is_done": isDone,
        "total_mark": totalMark,
      };
}
