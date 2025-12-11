import 'package:flutter_ta_plus/core/models/entities.dart';

import '../utils/http_util.dart';

class StudentAPI {
  static Future<StudentListResponseEntity> studentList(
      {UserRequestEntity? userRequestEntity}) async {
    var response = await HttpUtil()
        .post('api/studentList', queryParameters: userRequestEntity?.toJson());
    print(response);
    return StudentListResponseEntity.fromJson(response);
  }

  static Future<AvatarListResponseEntity> avatarList() async {
    print('testing avatar url');
    var response = await HttpUtil().post('api/avatarList');
    //print(response);
    return AvatarListResponseEntity.fromJson(response);
  }

  static studentCreate({StudentItem? params}) async {
    var response = await HttpUtil()
        .post('api/createStudent', queryParameters: params?.toJson());
    return StudentDetailResponseEntity.fromJson(response);
  }

  static studentUpdate({StudentItem? params}) async {
    var response = await HttpUtil()
        .post('api/updateStudent', queryParameters: params?.toJson());
    return StudentDetailResponseEntity.fromJson(response);
  }

  static studentPin({StudentItem? params}) async {
    var response = await HttpUtil()
        .post('api/studentPin', queryParameters: params?.toJson());
    return BaseResponseEntity.fromJson(response);
  }

  static resetPin({StudentItem? params}) async {
    var response = await HttpUtil()
        .post('api/resetPin', queryParameters: params?.toJson());

    return BaseResponseEntity.fromJson(response);
  }
}
