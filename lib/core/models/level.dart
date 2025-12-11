class LevelRequestEntity {
  int? id;

  LevelRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class LevelListResponseEntity {
  int? code;
  String? msg;
  List<LevelItem>? data;

  LevelListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory LevelListResponseEntity.fromJson(Map<String, dynamic> json) =>
      LevelListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<LevelItem>.from(
                json["data"].map((x) => LevelItem.fromJson(x))),
      );
}

//api post response msg
class LevelDetailResponseEntity {
  int? code;
  String? msg;
  LevelItem? data;

  LevelDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory LevelDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      LevelDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: LevelItem.fromJson(json["data"]),
      );
}

// login result
class LevelItem {
  int? id;
  int? topic_id;
  int? level_number;
  double? star;

  LevelItem({
    this.id,
    this.topic_id,
    this.level_number,
    this.star,
  });

  factory LevelItem.fromJson(Map<String, dynamic> json) => LevelItem(
        id: json["id"],
        topic_id: json["topic_id"],
        level_number: json["level_number"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic_id": topic_id,
        "level_number": level_number,
        "star": star,
      };
}
