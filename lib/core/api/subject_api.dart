import 'package:quezzy_app/core/models/entities.dart';

import '../models/subject.dart';
import '../utils/http_util.dart';

class SubjectAPI {
  // static Future<SubjectListResponseEntity> subjectList(
  //     SubjectRequestEntity? params) async {
  //   var response = await HttpUtil()
  //       .post('api/subjectList', queryParameters: params?.toJson());
  //   // print(response);
  //   return SubjectListResponseEntity.fromJson(response);
  // }

  static Future<SubjectListResponseEntity> subjectList(
      SubjectRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/getSubjectList', queryParameters: params?.toJson());
    // print(response);
    return SubjectListResponseEntity.fromJson(response);
  }
}
