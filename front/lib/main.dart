import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/observers.dart';
import 'package:front/features/admin/data/data_sources/admin_local_data_src.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appStorageDir = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  await Hive.initFlutter(appStorageDir!.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(OrganiserModelAdapter());
  Hive.registerAdapter(VehiculeModelAdapter());
  Hive.registerAdapter(AdminModelAdapter());

  await Hive.openBox('currentUser');
  await Hive.openBox('currentOrganiser');
  await Hive.openBox('currentAdmin');

  final getIt = GetIt.instance;
  getIt.registerSingleton<AuthLocalDataSource>(
      AuthLocalDataSource()..initialize());
  getIt.registerSingleton<OrganiserLocalDataSource>(
      OrganiserLocalDataSource()..initialize());
  getIt.registerSingleton<VehiculeLocalDataSource>(
      VehiculeLocalDataSource()..initialize());
  getIt.registerSingleton<AdminLocalDataSource>(
      AdminLocalDataSource()..initialize());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("5d68e5d3-7e31-4a0d-934a-2c9af0f3ce3b");
  OneSignal.Notifications.requestPermission(true);

  runApp(
    ProviderScope(
      observers: [Observers()],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: AutoRouterDelegate(
        appRouter,
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
      theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.white)),
    );
  }
}
