import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/services/api.service.dart';
import 'package:social_spot/services/dio.service.dart';

part 'home.repository.g.dart';

class HomeRepository {
  final ApiClient client;

  HomeRepository({required this.client});

  Future<bool> login() async {
    try {
      await client.login(
        "woelab",
        useragent,
        "http://10.0.0.10:8002/index.php?zone=woelab",
        "https://youtu.be/v9lTPsecFZY?t=25",
        "Login",
        "checked",
      );
      return true;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 302) return true;
      }
      return false;
    }
  }
}

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  var client = ref.watch(dioProvider);
  return HomeRepository(client: client);
}
