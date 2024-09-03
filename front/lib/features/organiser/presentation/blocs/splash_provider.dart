import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';

final authOrganiserLocalDataSourceProvider = Provider((ref) {
  final authLocalDataSource = OrganiserLocalDataSource();
  authLocalDataSource.initialize(); // Call initialize on provider creation
  return authLocalDataSource;
});

final organiserLoginCheckProvider = FutureProvider((ref) async {
  final localUserData = ref.watch(authOrganiserLocalDataSourceProvider);
  return await localUserData.isLoggedIn();
});
