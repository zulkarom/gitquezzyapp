import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:flutter_ta_plus/core/models/subscribe.dart';

import '../utils/http_util.dart';

class PackageAPI {
  static Future<PackageListResponseEntity> packageList() async {
    var response = await HttpUtil().post('api/packageList');

    return PackageListResponseEntity.fromJson(response);
  }

  static Future<SubscribeListResponseEntity> subscribeList(
      SubscribeRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/getSubscribeList', queryParameters: params?.toJson());
    // print(response);
    return SubscribeListResponseEntity.fromJson(response);
  }

  static Future<SubscribeListResponseEntity> subscribeOne(
      SubscribeRequestEntity? params) async {
    var response = await HttpUtil()
        .post('api/getSubscribeOne', queryParameters: params?.toJson());
    //print(response);
    return SubscribeListResponseEntity.fromJson(response);
  }

  // static Future<SubscribeListResponseEntity> subscribeList(
  //     SubscribeRequestEntity? params) async {
  //   var response = await HttpUtil()
  //       .post('api/subscribeList', queryParameters: params?.toJson());
  //   // print(response);
  //   return SubscribeListResponseEntity.fromJson(response);
  // }

  // static Future<SubscribeListResponseEntity> subscribeOne(
  //     SubscribeRequestEntity? params) async {
  //   var response = await HttpUtil()
  //       .post('api/subscribeOne', queryParameters: params?.toJson());
  //   //print(response);
  //   return SubscribeListResponseEntity.fromJson(response);
  // }

  static addPackage({SubscribeItem? params}) async {
    var response = await HttpUtil()
        .post('api/addPackage', queryParameters: params?.toJson());

    return BaseResponseEntity.fromJson(response);
  }
}
