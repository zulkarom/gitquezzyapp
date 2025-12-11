class TopicRequestEntity {
  int? student_id;
  int? subject_id;

  TopicRequestEntity({
    this.student_id,
    this.subject_id,
  });

  Map<String, dynamic> toJson() => {
        "student_id": student_id,
        "subject_id": subject_id,
      };
}

class TopicListResponseEntity {
  int? code;
  String? msg;
  List<TopicItem>? data;

  TopicListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory TopicListResponseEntity.fromJson(Map<String, dynamic> json) =>
      TopicListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<TopicItem>.from(
                json["data"].map((x) => TopicItem.fromJson(x))),
      );
}

//api post response msg
class TopicDetailResponseEntity {
  int? code;
  String? msg;
  TopicItem? data;

  TopicDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory TopicDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      TopicDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: TopicItem.fromJson(json["data"]),
      );
}

// login result
class TopicItem {
  int? subjectId;
  String? name_bm;
  String? name_eng;
  String? description_bm;
  String? description_eng;
  int? id;
  double? star;
  int? totalLevel;
  double? progress;

  TopicItem({
    this.subjectId,
    this.name_bm,
    this.name_eng,
    this.description_bm,
    this.description_eng,
    this.id,
    this.star,
    this.totalLevel,
    this.progress,
  });

  factory TopicItem.fromJson(Map<String, dynamic> json) => TopicItem(
        subjectId: json["subject_id"],
        name_bm: json["name_bm"],
        name_eng: json["name_eng"],
        description_bm: json["description_bm"],
        description_eng: json["description_eng"],
        id: json["id"],
        star: json["star"],
        totalLevel: json["totalLevel"],
        progress: (json["average_score_per_level"] is int)
            ? (json["average_score_per_level"] as int)
                .toDouble() // Convert int to double
            : json["average_score_per_level"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "name_bm": name_bm,
        "name_eng": name_eng,
        "description_bm": description_bm,
        "description_eng": description_eng,
        "id": id,
        "star": star,
        "totalLevel": totalLevel,
      };
}
