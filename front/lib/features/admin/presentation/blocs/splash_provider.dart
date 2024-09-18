import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/data/data_sources/admin_local_data_src.dart';

final authAdminLocalDataSourceProvider = Provider((ref) {
  final authLocalDataSource = AdminLocalDataSource();
  authLocalDataSource.initialize(); // Call initialize on provider creation
  return authLocalDataSource;
});

final adminLoginCheckProvider = FutureProvider((ref) async {
  final localUserData = ref.watch(authAdminLocalDataSourceProvider);
  return await localUserData.isLoggedIn();
});

