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
          AutoRoute(
            page: AccountRoute.page,
            maintainState: true,
          ),
        ]),
        AutoRoute(page: SettingRoute.page),
        AutoRoute(page: BillingDetailsRoute.page),
        AutoRoute(page: UserManagementRoute.page),
        AutoRoute(page: UpdateProfileRoute.page),
        AutoRoute(page: VerifyOtpRoute.page),
        AutoRoute(page: PasswordOtpRoute.page),
        AutoRoute(page: ForgetPasswordMailRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: ParkingDetailsRoute.page),
        AutoRoute(page: ReservationRoute.page),
        AutoRoute(page: RelatedEventRoute.page),
        AutoRoute(page: VehiculeListRoute.page),
        AutoRoute(page: AddVehiculeRoute.page),
        AutoRoute(page: ReservationListRoute.page),
        AutoRoute(page: VehiculeListReservationRoute.page),
        AutoRoute(page: TicketRoute.page),
      ];
}
