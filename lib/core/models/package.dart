class PackageRequestEntity {
  int? id;

  PackageRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class PackageListResponseEntity {
  int? code;
  String? msg;
  List<PackageItem>? data;

  PackageListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory PackageListResponseEntity.fromJson(Map<String, dynamic> json) =>
      PackageListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<PackageItem>.from(
                json["data"].map((x) => PackageItem.fromJson(x))),
      );
}

//api post response msg
class PackageDetailResponseEntity {
  int? code;
  String? msg;
  PackageItem? data;

  PackageDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory PackageDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      PackageDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: PackageItem.fromJson(json["data"]),
      );
}

// package result
class PackageItem {
  String? name;
  String? description;
  int? type_id;
  double? price;
  int? id;
  String? imageUrl;

  PackageItem({
    this.name,
    this.description,
    this.type_id,
    this.price,
    this.id,
    this.imageUrl,
  });

  factory PackageItem.fromJson(Map<String, dynamic> json) => PackageItem(
        name: json["name"],
        description: json["description"],
        type_id: json["type_id"],
        price: double.parse(json["price"]),
        id: json["id"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "type_id": type_id,
        "price": price,
        "id": id,
        "imageUrl": imageUrl,
      };
}
