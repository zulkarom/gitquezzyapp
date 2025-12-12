import 'package:quezzy_app/core/models/entities.dart';
import '../utils/http_util.dart';

class FriendAPI {
  // static Future<StudentListResponseEntity> searchfriendList(
  //     StudentRequestEntity? params) async {
  //   var response = await HttpUtil()
  //       .post('api/searchFriendList', queryParameters: params?.toJson());
  //   // print(response);
  //   return StudentListResponseEntity.fromJson(response);
  // }

  static Future<StudentListResponseEntity> searchfriend(
      {SearchRequestEntity? params}) async {
    var response = await HttpUtil()
        .post('api/searchFriend', queryParameters: params?.toJson());
    // print(response.toString());
    return StudentListResponseEntity.fromJson(response);
  }

  static Future<FriendListResponseEntity> requestedfriendList(
      FriendRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/requestedFriendList', queryParameters: params?.toJson());
    // print("response");
    // print(response);
    return FriendListResponseEntity.fromJson(response);
  }

  static friendRequest({FriendItem? params}) async {
    var response = await HttpUtil()
        .post('api/friendRequest', queryParameters: params?.toJson());
    // print(response);
    return FriendDetailResponseEntity.fromJson(response);
  }

  static actionFriendRequest({FriendItem? params}) async {
    var response = await HttpUtil()
        .post('api/actionFriendRequest', queryParameters: params?.toJson());
    // print(response);
    return FriendDetailResponseEntity.fromJson(response);
  }
}
