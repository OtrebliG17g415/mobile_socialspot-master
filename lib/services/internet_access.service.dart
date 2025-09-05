import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternetAccessService {
  final Dio _dio;
  static const String baseUrl = 'http://localhost:4000/api/access';

  InternetAccessService()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ));

  Future<Map<String, dynamic>> startAccess({int? adId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await _dio.post(
      '/start',
      data: {'adId': adId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> renewAccess({int? adId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await _dio.post(
      '/renew',
      data: {'adId': adId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await _dio.get(
      '/status',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }
}
