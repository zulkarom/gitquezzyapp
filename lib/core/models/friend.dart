class FriendRequestEntity {
  String? token;

  FriendRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

class ActionFriendRequestEntity {
  int? id;
  int? status;

  ActionFriendRequestEntity({
    this.id,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

class SearchRequestEntity {
  String? search;
  String? token;

  SearchRequestEntity({
    this.search,
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "search": search,
        "token": token,
      };
}

class FriendListResponseEntity {
  int? code;
  String? msg;
  List<FriendItem>? data;

  FriendListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory FriendListResponseEntity.fromJson(Map<String, dynamic> json) =>
      FriendListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<FriendItem>.from(
                json["data"].map((x) => FriendItem.fromJson(x))),
      );
}

//api post response msg
class FriendDetailResponseEntity {
  int? code;
  String? msg;
  FriendItem? data;

  FriendDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory FriendDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      FriendDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: FriendItem.fromJson(json["data"]),
      );
}

class FriendItem {
  int? id;
  String? name;
  String? schoolName;
  String? avatar;
  String? studentToken;
  String? friendToken;
  int? status;
  int? online;

  FriendItem({
    this.id,
    this.name,
    this.schoolName,
    this.avatar,
    this.studentToken,
    this.friendToken,
    this.status,
    this.online,
  });

  factory FriendItem.fromJson(Map<String, dynamic> json) => FriendItem(
        id: json["id"],
        name: json["name"],
        schoolName: json["school_name"],
        avatar: json["avatar"],
        studentToken: json["student_token"],
        friendToken: json["friend_token"],
        status: json["status"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "school_name": schoolName,
        "avatar": avatar,
        "student_token": studentToken,
        "friend_token": friendToken,
        "status": status,
        "online": online,
      };
}
