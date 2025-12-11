import 'package:flutter_ta_plus/core/models/entities.dart';
import '../utils/http_util.dart';

class QuizRoomAPI {
  static Future<StudentListResponseEntity> qzrSearchFriend(
      {SearchRequestEntity? params}) async {
    var response = await HttpUtil()
        .post('api/qzrSearchFriend', queryParameters: params?.toJson());
    // print(response.toString());
    return StudentListResponseEntity.fromJson(response);
  }

  static saveInvitation({PlayerRoomItem? params}) async {
    var response = await HttpUtil()
        .post('api/saveInvitation', queryParameters: params?.toJson());
    return PlayerRoomDetailResponseEntity.fromJson(response);
  }

  static removeInvitation({PlayerRoomItem? params}) async {
    var response = await HttpUtil()
        .post('api/removeInvitation', queryParameters: params?.toJson());
    return BaseResponseEntity.fromJson(response);
  }

  static Future<PlayerRoomListResponseEntity> listRoomId(
      PlayerRoomRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/listRoomId', queryParameters: params?.toJson());
    print("response");
    return PlayerRoomListResponseEntity.fromJson(response);
  }
}
