import 'package:quezzy_app/core/models/entities.dart';
import '../utils/http_util.dart';

class LevelAPI {
  static Future<LevelListResponseEntity> levelList(
      LevelRequestEntity? params) async {
    // print("params!.id");
    // print(params!.id);

    var response = await HttpUtil()
        .post('api/levelList', queryParameters: params?.toJson());
    // print(response);
    return LevelListResponseEntity.fromJson(response);
  }

  static Future<LevelResultListResponseEntity> getLevelResult(
      LevelResultRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/getLevelResult', queryParameters: params?.toJson());
    // print("response level result");
    // print(response);
    return LevelResultListResponseEntity.fromJson(response);
  }

  static addResultLevel({LevelResultItem? params}) async {
    var response = await HttpUtil()
        .post('api/addLevelResult', queryParameters: params?.toJson());

    return BaseResponseEntity.fromJson(response);
  }
}
