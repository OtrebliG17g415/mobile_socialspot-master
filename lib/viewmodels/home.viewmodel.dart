import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_spot/repositories/home.repository.dart';

part 'home.viewmodel.g.dart';

@riverpod
Future<bool> login(LoginRef ref) async {
  return await ref.watch(homeRepositoryProvider).login();
}
