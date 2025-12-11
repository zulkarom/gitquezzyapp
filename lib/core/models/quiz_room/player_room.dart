import 'package:cloud_firestore/cloud_firestore.dart';

//Firestore
class PlayerRoom {
  String? studentToken;
  String? roomDocId;
  Timestamp? createdTime;

  PlayerRoom({this.studentToken, this.roomDocId, createdTime});

  factory PlayerRoom.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PlayerRoom(
      studentToken: data?['student_token'],
      roomDocId: data?['room_doc_id'],
      createdTime: data?['created_time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (studentToken != null) "student_token": studentToken,
      if (roomDocId != null) "room_doc_id": roomDocId,
      if (createdTime != null) "created_time": createdTime,
    };
  }
}
//Firestore

//MySql
class PlayerRoomRequestEntity {
  String? id;

  PlayerRoomRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class PlayerRoomListResponseEntity {
  int? code;
  String? msg;
  List<PlayerRoomItem>? data;

  PlayerRoomListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory PlayerRoomListResponseEntity.fromJson(Map<String, dynamic> json) =>
      PlayerRoomListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<PlayerRoomItem>.from(
                json["data"].map((x) => PlayerRoomItem.fromJson(x))),
      );
}

class PlayerRoomDetailResponseEntity {
  int? code;
  String? msg;
  PlayerRoomItem? data;

  PlayerRoomDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory PlayerRoomDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      PlayerRoomDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: PlayerRoomItem.fromJson(json["data"]),
      );
}

class PlayerRoomItem {
  int? id;
  String? studentToken;
  String? roomDocId;

  PlayerRoomItem({
    this.id,
    this.studentToken,
    this.roomDocId,
  });

  factory PlayerRoomItem.fromJson(Map<String, dynamic> json) => PlayerRoomItem(
        id: json["id"],
        studentToken: json["student_token"],
        roomDocId: json["room_doc_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_token": studentToken,
        "room_doc_id": roomDocId,
      };
}

//MySql
