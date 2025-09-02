import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_spot/services/api.service.dart';

part 'dio.service.g.dart';

@riverpod
ApiClient dio(DioRef ref) => ApiClient(
      Dio(
        BaseOptions(
          headers: {"app-slspot-key": "appkey-should-be-generated"},
        ),
      ),
    );
