import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_spot/models/ad.model.dart';
import 'package:social_spot/services/api.service.dart';
import 'package:social_spot/services/dio.service.dart';

part 'ad.repository.g.dart';

class AdRepository {
  final ApiClient client;

  AdRepository({required this.client});

  Future<Ad?> getRandomAd() async {
    try {
      return await client.getRandomAd();
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 302) return null;
      }
      return null;
    }
  }
}

@riverpod
AdRepository adRepository(AdRepositoryRef ref) {
  return AdRepository(client: ref.watch(dioProvider));
}
