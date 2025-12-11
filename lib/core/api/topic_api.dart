import 'package:flutter_ta_plus/core/models/entities.dart';

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
