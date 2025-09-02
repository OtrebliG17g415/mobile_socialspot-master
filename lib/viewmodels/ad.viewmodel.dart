import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_spot/models/ad.model.dart';
import 'package:social_spot/repositories/ad.repository.dart';

part 'ad.viewmodel.g.dart';

@riverpod
Future<Ad?> getAd(GetAdRef ref) async {
  return await ref.watch(adRepositoryProvider).getRandomAd();
}
