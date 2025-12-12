import 'package:quezzy_app/core/models/entities.dart';

import '../models/question.dart';
import '../utils/http_util.dart';

class QuestionAPI {
  static Future<QuestionListResponseEntity> questionList(
      QuestionRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/questionList', queryParameters: params?.toJson());
    // print('question response');
    // print(response);
    return QuestionListResponseEntity.fromJson(response);
  }
}
