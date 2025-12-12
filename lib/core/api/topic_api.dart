import 'package:quezzy_app/core/models/entities.dart';

import '../models/topic.dart';
import '../utils/http_util.dart';

class TopicAPI {
  static Future<TopicListResponseEntity> topicList(
      TopicRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/getTopicList', queryParameters: params?.toJson());
    // print(response);
    return TopicListResponseEntity.fromJson(response);
  }
}
