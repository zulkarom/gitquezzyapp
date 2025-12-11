import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../error/failures/failure.dart';

class MessagingService {
  static MessagingService _service = MessagingService._internal();

  String? deviceToken;
  String? voipToken;

  factory MessagingService() {
    return _service;
  }

  MessagingService._internal();

  MessagingService.init(MessagingService service) {
    _service = service;
  }

  Future<Either<Failure, void>?> initService() async {
    return null;
  }

  void destroyTokenStream() {}

  void destroyForegroundHandlerStream() {}

  void messagingForegroundHandler(void Function(dynamic) callback) {}

  void addEventListener(
      MapEntry<MessagingListener, void Function(dynamic)> callback) {}

  Future<Either<Failure, void>?> getCurrentDeviceToken() async {
    return null;
  }

  // Future<Either<Failure, Response>?> updateDeviceToken(User currentUser) async {
  //   return null;
  // }
}

enum MessagingListener {
  foregroundInit,
  notificationCount,
}
