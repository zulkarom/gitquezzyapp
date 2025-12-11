class SubscribeRequestEntity {
  int? student_id;
  int? is_payment;
  int? package_id;

  SubscribeRequestEntity({
    this.student_id,
    this.is_payment,
    this.package_id,
  });

  Map<String, dynamic> toJson() => {
        "student_id": student_id,
        "is_payment": is_payment,
        "package_id": package_id,
      };
}

class SubscribeListResponseEntity {
  int? code;
  String? msg;
  List<SubscribeItem>? data;

  SubscribeListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory SubscribeListResponseEntity.fromJson(Map<String, dynamic> json) {
    var data = json["data"];
    List<SubscribeItem> subscribeItems = [];

    if (data is List) {
      subscribeItems =
          List<SubscribeItem>.from(data.map((x) => SubscribeItem.fromJson(x)));
    } else if (data is Map<String, dynamic>) {
      subscribeItems.add(SubscribeItem.fromJson(data));
    }

    return SubscribeListResponseEntity(
      code: json["code"],
      msg: json["msg"],
      data: subscribeItems,
    );
  }
}

//api post response msg
class SubscribeDetailResponseEntity {
  int? code;
  String? msg;
  SubscribeItem? data;

  SubscribeDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory SubscribeDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      SubscribeDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: SubscribeItem.fromJson(json["data"]),
      );
}

// subscribe result
class SubscribeItem {
  int? code;
  int? id;
  int? student_id;
  int? package_id;
  int? is_payment;
  String? name;
  String? description;
  int? type_id;
  double? price;
  String? imageUrl;
  int? totalSubject;
  double? star;
  double? progress;
  int? totalAllTopic;
  double? totalScore;

  SubscribeItem({
    this.id,
    this.student_id,
    this.package_id,
    this.is_payment,
    this.name,
    this.description,
    this.type_id,
    this.price,
    this.imageUrl,
    this.totalSubject,
    this.star,
    this.progress,
    this.totalAllTopic,
    this.totalScore,
  });

  factory SubscribeItem.fromJson(Map<String, dynamic> json) => SubscribeItem(
        id: int.parse(json["id"]),
        student_id: json["student_id"],
        package_id: int.parse(json["package_id"]),
        is_payment: int.parse(json["is_payment"]),
        name: json["name"],
        description: json["description"],
        type_id: json["type_id"],
        price: double.parse(json["price"]),
        imageUrl: json["imageUrl"],
        progress: double.parse(json["package_score"]),
        totalSubject: json["totalSubject"],
        totalAllTopic: json["totalAllTopic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": student_id,
        "package_id": package_id,
        "is_payment": is_payment,
        "name": name,
        "description": description,
        "type_id": type_id,
        "price": price,
        "imageUrl": imageUrl
      };
}
