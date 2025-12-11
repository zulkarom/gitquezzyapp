class SubjectRequestEntity {
  int? student_id;
  int? package_id;

  SubjectRequestEntity({
    this.student_id,
    this.package_id,
  });

  Map<String, dynamic> toJson() => {
        "student_id": student_id,
        "package_id": package_id,
      };
}

class SubjectListResponseEntity {
  int? code;
  String? msg;
  List<SubjectItem>? data;

  SubjectListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory SubjectListResponseEntity.fromJson(Map<String, dynamic> json) =>
      SubjectListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<SubjectItem>.from(
                json["data"].map((x) => SubjectItem.fromJson(x))),
      );
}

//api post response msg
class SubjectDetailResponseEntity {
  int? code;
  String? msg;
  SubjectItem? data;

  SubjectDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory SubjectDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      SubjectDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: SubjectItem.fromJson(json["data"]),
      );
}

// login result
class SubjectItem {
  String? name_bm;
  String? name_eng;
  int? id;
  int? totalTopic;
  double? star;
  double? progress;

  SubjectItem({
    this.name_bm,
    this.name_eng,
    this.id,
    this.totalTopic,
    this.star,
    this.progress,
  });

  factory SubjectItem.fromJson(Map<String, dynamic> json) => SubjectItem(
        id: json["id"],
        name_bm: json["name_bm"],
        name_eng: json["name_eng"],
        totalTopic: json["total_topic"],
        star: json["star"],
        progress: (json["progress_by_subject"] is int)
            ? (json["progress_by_subject"] as int)
                .toDouble() // Convert int to double
            : json["progress_by_subject"]?.toDouble(),
      ); // Keep it as double if it's already double

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_bm": name_bm,
        "name_eng": name_eng,
        "total_topic": totalTopic,
        "star": star,
      };
}
