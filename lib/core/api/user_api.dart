import '../models/entities.dart';
import '../utils/http_util.dart';

class UserAPI {
  static login({LoginRequestEntity? params}) async {
    //print("responsee....");
    //response = response.data after the post method returns
    var response =
        await HttpUtil().post('api/login', queryParameters: params?.toJson());

    //print(response);

    return UserLoginResponseEntity.fromJson(response);
  }

  static checkPassword({UserItem? params}) async {
    var response = await HttpUtil()
        .post('api/checkPassword', queryParameters: params?.toJson());

    return BaseResponseEntity.fromJson(response);
  }

  static updatePassword({UserItem? params}) async {
    var response = await HttpUtil()
        .post('api/updatePassword', queryParameters: params?.toJson());
    return BaseResponseEntity.fromJson(response);
  }
}
