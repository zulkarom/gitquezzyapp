class StudentRequestEntity {
  int? id;

  StudentRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class StudentListResponseEntity {
  int? code;
  String? msg;
  List<StudentItem>? data;

  StudentListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory StudentListResponseEntity.fromJson(Map<String, dynamic> json) =>
      StudentListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<StudentItem>.from(
                json["data"].map((x) => StudentItem.fromJson(x))),
      );
}

//api post response msg
class StudentDetailResponseEntity {
  int? code;
  String? msg;
  StudentItem? data;

  StudentDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory StudentDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      StudentDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: StudentItem.fromJson(json["data"]),
      );
}

// student item
class StudentItem {
  String? userToken;
  String? name;
  String? schoolName;
  String? password;
  String? avatar;
  int? id;
  String? mainPassword;
  String? token;
  int? online;
  int? status;

  StudentItem({
    this.userToken,
    this.name,
    this.schoolName,
    this.password,
    this.avatar,
    this.id,
    this.mainPassword,
    this.token,
    this.online,
    this.status,
  });

  factory StudentItem.fromJson(Map<String, dynamic> json) => StudentItem(
        userToken: json["user_token"],
        name: json["name"],
        schoolName: json["school_name"],
        password: json["password"],
        avatar: json["avatar"],
        id: json["id"],
        mainPassword: json["mainPassword"],
        token: json["token"],
        online: json["online"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_token": userToken,
        "name": name,
        "school_name": schoolName,
        "password": password,
        "avatar": avatar,
        "id": id,
        "mainPassword": mainPassword,
        "token": token,
        "online": online,
        "status": status,
      };
}
