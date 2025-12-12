import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRequestEntity {
  int? type;
  String? name;
  String? description;
  String? email;
  String? phone;
  String? avatar;
  String? open_id;
  int? online;
  String? password;

  LoginRequestEntity({
    this.type,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.avatar,
    this.open_id,
    this.online,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "description": description,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "open_id": open_id,
        "online": online,
        "password": password,
      };
}

//api post response msg
class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserItem? data;

  UserLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"];
    UserItem? userItem;

    if (rawData is List && rawData.isNotEmpty) {
      final first = rawData.first;
      if (first is Map<String, dynamic>) {
        userItem = UserItem.fromJson(first);
      }
    } else if (rawData is Map<String, dynamic>) {
      userItem = UserItem.fromJson(rawData);
    }

    return UserLoginResponseEntity(
      code: json["code"],
      msg: json["msg"],
      data: userItem,
    );
  }
}

// login result
class UserItem {
  String? access_token;
  String? token;
  String? name;
  String? email;
  String? description;
  String? avatar;
  int? online;
  String? type;
  String? password;
  String? newPassword;

  UserItem({
    this.access_token,
    this.token,
    this.name,
    this.email,
    this.description,
    this.avatar,
    this.online,
    this.type,
    this.password,
    this.newPassword,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
        access_token: json["access_token"],
        token: json["token"],
        name: json["name"],
        email: json["email"],
        description: json["description"],
        avatar: json["avatar"],
        online: json["online"],
        type: json["type"],
        password: json["password"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": access_token,
        "token": token,
        "name": name,
        "email": email,
        "description": description,
        "avatar": avatar,
        "online": online,
        "type": type,
        "password": password,
        "newPassword": newPassword,
      };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      token: data?['token'],
      name: data?['name'],
      avatar: data?['avatar'],
      description: data?['description'],
      online: data?['online'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}

class UserRequestEntity {
  String? token;

  UserRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
