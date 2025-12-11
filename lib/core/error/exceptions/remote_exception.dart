import 'package:dio/dio.dart';

class RemoteException implements Exception {
  DioError dioError;

  RemoteException({required this.dioError});
}
