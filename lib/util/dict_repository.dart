import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictPod = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.0.17:3000/api',
    /*
    receiveTimeout: Duration(seconds: 20), // 20 seconds
    connectTimeout: Duration(seconds: 20),
    sendTimeout: Duration(seconds: 20),
     */
  ));

  return dio;
});

