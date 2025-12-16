import 'package:dio/dio.dart';

class RemoteException implements Exception {
  DioException dioError;

  RemoteException({required this.dioError});
}
