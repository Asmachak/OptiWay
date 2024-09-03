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
        AutoRoute(page: OrganiserLoginRoute.page),
        AutoRoute(page: OrganiserSignupRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: HomeRoute.page, maintainState: true),
          AutoRoute(page: ParkingsRoute.page, maintainState: true),
          AutoRoute(page: EventRoute.page, maintainState: true),
          AutoRoute(page: ReservationListRoute.page, maintainState: true),
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
        AutoRoute(page: OrganiserVerifyOtpRoute.page),
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
        AutoRoute(page: GetDirectionRoute.page),
        AutoRoute(page: TimerRoute.page),
        AutoRoute(page: PaiementMethodeRoute.page),
        AutoRoute(page: BillingHistoricRoute.page),
        AutoRoute(page: MovieDetailRoute.page),
        AutoRoute(page: MovieDetailCinemaRoute.page),
        AutoRoute(page: VehiculeListReservationEventRoute.page),
        AutoRoute(page: NotificationRoute.page),
        AutoRoute(page: MainOrganiserRoute.page, children: [
          AutoRoute(page: OrganiserHomeRoute.page, maintainState: true),
          AutoRoute(page: OrganiserStatistqueRoute.page, maintainState: true),
          AutoRoute(page: OrganiserEventRoute.page, maintainState: true),
          AutoRoute(page: OrganiserReservationRoute.page, maintainState: true),
          AutoRoute(
            page: OrganiserAccountRoute.page,
            maintainState: true,
          ),
        ]),
        AutoRoute(page: AddEventRoute.page),
      ];
}
