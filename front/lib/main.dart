import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/observers.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_it/get_it.dart';

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();
  final appStorageDir = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  await Hive.initFlutter(appStorageDir!.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(VehiculeModelAdapter());

  await Hive.openBox('currentUser');

  final getIt = GetIt.instance;
  getIt.registerSingleton<AuthLocalDataSource>(
      AuthLocalDataSource()..initialize());
  getIt.registerSingleton<VehiculeLocalDataSource>(
      VehiculeLocalDataSource()..initialize());

  runApp(
    ProviderScope(
      observers: [Observers()],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final AppRouter appRouter = AppRouter(); // Create the AppRouter instance

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if the user is logged in

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: AutoRouterDelegate(
        appRouter, // Your generated router instance
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
