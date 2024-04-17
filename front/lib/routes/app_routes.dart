import 'package:auto_route/auto_route.dart';

import 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: HomeRoute.page, maintainState: true),
          AutoRoute(page: ParkingsRoute.page, maintainState: true),
          AutoRoute(page: EventRoute.page, maintainState: true),
          AutoRoute(page: AccountRoute.page, maintainState: true),
        ]),
        //AutoRoute(page: EmailOTPscreen.page),
        AutoRoute(page: VerifyOtpRoute.page),
        AutoRoute(page: UpdateProfileRoute.page),
      ];
}
