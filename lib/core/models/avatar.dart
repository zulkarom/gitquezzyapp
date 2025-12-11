class AvatarRequestEntity {
  int? id;

  AvatarRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class AvatarListResponseEntity {
  int? code;
  String? msg;
  List<AvatarItem>? data;

  AvatarListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory AvatarListResponseEntity.fromJson(Map<String, dynamic> json) =>
      AvatarListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<AvatarItem>.from(
                json["data"].map((x) => AvatarItem.fromJson(x))),
      );
}

//api post response msg
class AvatarDetailResponseEntity {
  int? code;
  String? msg;
  AvatarItem? data;

  AvatarDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory AvatarDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      AvatarDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: AvatarItem.fromJson(json["data"]),
      );
}

// login result
class AvatarItem {
  int? id;
  String? url;

  AvatarItem({
    this.id,
    this.url,
  });

  factory AvatarItem.fromJson(Map<String, dynamic> json) => AvatarItem(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
