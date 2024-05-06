import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';

final authLocalDataSourceProvider = Provider((ref) {
  final authLocalDataSource = AuthLocalDataSource();
  // final vehiculeLocalDataSource = VehiculeLocalDataSource();

  //  vehiculeLocalDataSource.initialize();
  authLocalDataSource.initialize(); // Call initialize on provider creation
  return authLocalDataSource;
});

final userLoginCheckProvider = FutureProvider((ref) async {
  final localUserData = ref.watch(authLocalDataSourceProvider);
  return await localUserData.isLoggedIn();
});
