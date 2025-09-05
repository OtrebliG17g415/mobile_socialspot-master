// import 'package:dio/dio.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:social_spot/services/api.service.dart';

// part 'dio.service.g.dart';

// @riverpod
// ApiClient dio(DioRef ref) => ApiClient(
//       Dio(
//         BaseOptions(
//           headers: {"app-slspot-key": "appkey-should-be-generated"},
//         ),
//       ),
//     );
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_spot/services/api.service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'dio.service.g.dart';

@riverpod
ApiClient dio(DioRef ref) {
  final dio = Dio();

  // ✅ Configuration pour Web et Mobile
  if (kIsWeb) {
    // Configuration spécifique Web
    dio.options.baseUrl = 'http://localhost:4000';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  } else {
    // Configuration pour mobile (peut utiliser ngrok)
    dio.options.baseUrl = 'https://raptor-more-eft.ngrok-free.app';
  }

  // Intercepteur pour debugging
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => print('[DIO] $obj'), // ✅ Logs dans la console
    ),
  );

  return ApiClient(dio);
}
