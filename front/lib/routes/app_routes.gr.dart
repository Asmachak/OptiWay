// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i59;

import 'package:auto_route/auto_route.dart' as _i53;
import 'package:flutter/material.dart' as _i54;
import 'package:front/features/admin/presentation/pages/admin_account_screen.dart'
    as _i3;
import 'package:front/features/admin/presentation/pages/admin_home_screen.dart'
    as _i4;
import 'package:front/features/admin/presentation/pages/admin_stats_screen.dart'
    as _i8;
import 'package:front/features/admin/presentation/pages/admin_tables_screen.dart'
    as _i9;
import 'package:front/features/admin/presentation/pages/login_admin.dart'
    as _i5;
import 'package:front/features/admin/presentation/pages/main_admin_screen.dart'
    as _i6;
import 'package:front/features/admin/presentation/pages/sign_up_admin.dart'
    as _i7;
import 'package:front/features/admin/presentation/pages/verify_otp_admin.dart'
    as _i10;
import 'package:front/features/event/data/models/movie/movie_model.dart'
    as _i57;
import 'package:front/features/event/presentation/pages/add_event_organiser.dart'
    as _i1;
import 'package:front/features/event/presentation/pages/add_parking_event.dart'
    as _i49;
import 'package:front/features/event/presentation/pages/movie_details.dart'
    as _i19;
import 'package:front/features/event/presentation/pages/movie_details_cinema.dart'
    as _i18;
import 'package:front/features/event/presentation/pages/related_events_screen.dart'
    as _i32;
import 'package:front/features/notification/presentation/pages/notification_screen.dart'
    as _i20;
import 'package:front/features/organiser/presentation/pages/login_organiser.dart'
    as _i24;
import 'package:front/features/organiser/presentation/pages/main_organiser_screen.dart'
    as _i16;
import 'package:front/features/organiser/presentation/pages/oragniser_home_screen.dart'
    as _i23;
import 'package:front/features/organiser/presentation/pages/organiser_account_screen.dart'
    as _i21;
import 'package:front/features/organiser/presentation/pages/organiser_events_screen.dart'
    as _i22;
import 'package:front/features/organiser/presentation/pages/organiser_reservations_screen.dart'
    as _i25;
import 'package:front/features/organiser/presentation/pages/organiser_statistiques_screen.dart'
    as _i27;
import 'package:front/features/organiser/presentation/pages/sign_up_organiser.dart'
    as _i26;
import 'package:front/features/organiser/presentation/pages/verify_otp_organiser.dart'
    as _i28;
import 'package:front/features/paiement/presentation/pages/billing_historic_screen.dart'
    as _i12;
import 'package:front/features/parking/data/models/parking_model.dart' as _i58;
import 'package:front/features/parking/presentation/pages/parking_details_screen.dart'
    as _i30;
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart'
    as _i56;
import 'package:front/features/reservation/presentation/pages/get_direction_screen.dart'
    as _i14;
import 'package:front/features/reservation/presentation/pages/reservation_list_screen.dart'
    as _i33;
import 'package:front/features/reservation/presentation/pages/reservation_screen.dart'
    as _i34;
import 'package:front/features/reservation/presentation/pages/ticket_screen.dart'
    as _i39;
import 'package:front/features/reservation/presentation/pages/timer_screen.dart'
    as _i40;
import 'package:front/features/user/presentation/pages/account_screen.dart'
    as _i48;
import 'package:front/features/user/presentation/pages/billing_details_screen.dart'
    as _i11;
import 'package:front/features/user/presentation/pages/events_screen.dart'
    as _i50;
import 'package:front/features/user/presentation/pages/forget_password_mail_screen.dart'
    as _i13;
import 'package:front/features/user/presentation/pages/home_screen.dart'
    as _i51;
import 'package:front/features/user/presentation/pages/login_screen.dart'
    as _i15;
import 'package:front/features/user/presentation/pages/main_screen.dart'
    as _i17;
import 'package:front/features/user/presentation/pages/otp_password.dart'
    as _i31;
import 'package:front/features/user/presentation/pages/otp_verify.dart' as _i46;
import 'package:front/features/user/presentation/pages/parkings_screen.dart'
    as _i52;
import 'package:front/features/user/presentation/pages/payement_methodes.dart'
    as _i29;
import 'package:front/features/user/presentation/pages/reset_password_screen.dart'
    as _i35;
import 'package:front/features/user/presentation/pages/settings_screen.dart'
    as _i36;
import 'package:front/features/user/presentation/pages/signup.dart' as _i37;
import 'package:front/features/user/presentation/pages/splash_screen.dart'
    as _i38;
import 'package:front/features/user/presentation/pages/update_profile_screen.dart'
    as _i41;
import 'package:front/features/user/presentation/pages/user_management_screen.dart'
    as _i42;
import 'package:front/features/user/presentation/pages/welcome_screen.dart'
    as _i47;
import 'package:front/features/vehicule/data/models/vehicule_model.dart'
    as _i55;
import 'package:front/features/vehicule/presentation/pages/add_vehicule_screen.dart'
    as _i2;
import 'package:front/features/vehicule/presentation/pages/vehicle_list_event.dart'
    as _i43;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_reservation.dart'
    as _i44;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_screen.dart'
    as _i45;

abstract class $AppRouter extends _i53.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i53.PageFactory> pagesMap = {
    AddEventRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddEventScreen(),
      );
    },
    AddVehiculeRoute.name: (routeData) {
      final args = routeData.argsAs<AddVehiculeRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddVehiculeScreen(
          key: args.key,
          vehicles: args.vehicles,
        ),
      );
    },
    AdminAccountRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminAccountScreen(),
      );
    },
    AdminHomeRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AdminHomeScreen(),
      );
    },
    AdminLoginRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AdminLoginScreen(),
      );
    },
    AdminMainRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.AdminMainScreen(),
      );
    },
    AdminSignupRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.AdminSignupScreen(),
      );
    },
    AdminStatRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.AdminStatScreen(),
      );
    },
    AdminTableRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.AdminTableScreen(),
      );
    },
    AdminVerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<AdminVerifyOtpRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.AdminVerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    BillingDetailsRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.BillingDetailsScreen(),
      );
    },
    BillingHistoricRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.BillingHistoricScreen(),
      );
    },
    ForgetPasswordMailRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ForgetPasswordMailScreen(),
      );
    },
    GetDirectionRoute.name: (routeData) {
      final args = routeData.argsAs<GetDirectionRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.GetDirectionScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.LoginScreen(),
      );
    },
    MainOrganiserRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MainOrganiserScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.MainScreen(),
      );
    },
    MovieDetailCinemaRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailCinemaRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.MovieDetailCinemaScreen(
          key: args.key,
          cinema: args.cinema,
          movie: args.movie,
        ),
      );
    },
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.MovieDetailScreen(
          key: args.key,
          movie: args.movie,
        ),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.NotificationPage(),
      );
    },
    OrganiserAccountRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.OrganiserAccountScreen(),
      );
    },
    OrganiserEventRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.OrganiserEventScreen(),
      );
    },
    OrganiserHomeRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.OrganiserHomeScreen(),
      );
    },
    OrganiserLoginRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.OrganiserLoginScreen(),
      );
    },
    OrganiserReservationRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.OrganiserReservationScreen(),
      );
    },
    OrganiserSignupRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.OrganiserSignupScreen(),
      );
    },
    OrganiserStatistqueRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.OrganiserStatistqueScreen(),
      );
    },
    OrganiserVerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<OrganiserVerifyOtpRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.OrganiserVerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    PaiementMethodeRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.PaiementMethodeScreen(),
      );
    },
    ParkingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ParkingDetailsRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.ParkingDetailsScreen(
          key: args.key,
          parking: args.parking,
        ),
      );
    },
    PasswordOtpRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordOtpRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.PasswordOtpScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    RelatedEventRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.RelatedEventScreen(),
      );
    },
    ReservationListRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.ReservationListScreen(),
      );
    },
    ReservationRoute.name: (routeData) {
      final args = routeData.argsAs<ReservationRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i34.ReservationScreen(
          key: args.key,
          idparking: args.idparking,
          parking: args.parking,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.ResetPasswordScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    SettingRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.SettingScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.SplashScreen(),
      );
    },
    TicketRoute.name: (routeData) {
      final args = routeData.argsAs<TicketRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i39.TicketScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i40.TimerScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i41.UpdateProfileScreen(),
      );
    },
    UserManagementRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i42.UserManagementScreen(),
      );
    },
    VehiculeListReservationEventRoute.name: (routeData) {
      final args = routeData.argsAs<VehiculeListReservationEventRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i43.VehiculeListReservationEventScreen(
          key: args.key,
          finalPrice: args.finalPrice,
        ),
      );
    },
    VehiculeListReservationRoute.name: (routeData) {
      final args = routeData.argsAs<VehiculeListReservationRouteArgs>(
          orElse: () => const VehiculeListReservationRouteArgs());
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i44.VehiculeListReservationScreen(key: args.key),
      );
    },
    VehiculeListRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i45.VehiculeListScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i46.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i47.WelcomeScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i48.accountScreen(),
      );
    },
    AddParkingEventRoute.name: (routeData) {
      final args = routeData.argsAs<AddParkingEventRouteArgs>();
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i49.addParkingEventScreen(
          key: args.key,
          eventData: args.eventData,
          image: args.image,
        ),
      );
    },
    EventRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i50.eventScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i51.homeScreen(),
      );
    },
    ParkingsRoute.name: (routeData) {
      return _i53.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i52.parkingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i53.PageRouteInfo<void> {
  const AddEventRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AddEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddVehiculeScreen]
class AddVehiculeRoute extends _i53.PageRouteInfo<AddVehiculeRouteArgs> {
  AddVehiculeRoute({
    _i54.Key? key,
    required List<_i55.VehiculeModel> vehicles,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          AddVehiculeRoute.name,
          args: AddVehiculeRouteArgs(
            key: key,
            vehicles: vehicles,
          ),
          initialChildren: children,
        );

  static const String name = 'AddVehiculeRoute';

  static const _i53.PageInfo<AddVehiculeRouteArgs> page =
      _i53.PageInfo<AddVehiculeRouteArgs>(name);
}

class AddVehiculeRouteArgs {
  const AddVehiculeRouteArgs({
    this.key,
    required this.vehicles,
  });

  final _i54.Key? key;

  final List<_i55.VehiculeModel> vehicles;

  @override
  String toString() {
    return 'AddVehiculeRouteArgs{key: $key, vehicles: $vehicles}';
  }
}

/// generated route for
/// [_i3.AdminAccountScreen]
class AdminAccountRoute extends _i53.PageRouteInfo<void> {
  const AdminAccountRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminAccountRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AdminHomeScreen]
class AdminHomeRoute extends _i53.PageRouteInfo<void> {
  const AdminHomeRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomeRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AdminLoginScreen]
class AdminLoginRoute extends _i53.PageRouteInfo<void> {
  const AdminLoginRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminLoginRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i6.AdminMainScreen]
class AdminMainRoute extends _i53.PageRouteInfo<void> {
  const AdminMainRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminMainRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i7.AdminSignupScreen]
class AdminSignupRoute extends _i53.PageRouteInfo<void> {
  const AdminSignupRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminSignupRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i8.AdminStatScreen]
class AdminStatRoute extends _i53.PageRouteInfo<void> {
  const AdminStatRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminStatRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminStatRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i9.AdminTableScreen]
class AdminTableRoute extends _i53.PageRouteInfo<void> {
  const AdminTableRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AdminTableRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminTableRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i10.AdminVerifyOtpScreen]
class AdminVerifyOtpRoute extends _i53.PageRouteInfo<AdminVerifyOtpRouteArgs> {
  AdminVerifyOtpRoute({
    _i54.Key? key,
    required String email,
    required dynamic json,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          AdminVerifyOtpRoute.name,
          args: AdminVerifyOtpRouteArgs(
            key: key,
            email: email,
            json: json,
          ),
          initialChildren: children,
        );

  static const String name = 'AdminVerifyOtpRoute';

  static const _i53.PageInfo<AdminVerifyOtpRouteArgs> page =
      _i53.PageInfo<AdminVerifyOtpRouteArgs>(name);
}

class AdminVerifyOtpRouteArgs {
  const AdminVerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i54.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'AdminVerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i11.BillingDetailsScreen]
class BillingDetailsRoute extends _i53.PageRouteInfo<void> {
  const BillingDetailsRoute({List<_i53.PageRouteInfo>? children})
      : super(
          BillingDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingDetailsRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i12.BillingHistoricScreen]
class BillingHistoricRoute extends _i53.PageRouteInfo<void> {
  const BillingHistoricRoute({List<_i53.PageRouteInfo>? children})
      : super(
          BillingHistoricRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingHistoricRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ForgetPasswordMailScreen]
class ForgetPasswordMailRoute extends _i53.PageRouteInfo<void> {
  const ForgetPasswordMailRoute({List<_i53.PageRouteInfo>? children})
      : super(
          ForgetPasswordMailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordMailRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i14.GetDirectionScreen]
class GetDirectionRoute extends _i53.PageRouteInfo<GetDirectionRouteArgs> {
  GetDirectionRoute({
    _i54.Key? key,
    required _i56.ReservationModel reservation,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          GetDirectionRoute.name,
          args: GetDirectionRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'GetDirectionRoute';

  static const _i53.PageInfo<GetDirectionRouteArgs> page =
      _i53.PageInfo<GetDirectionRouteArgs>(name);
}

class GetDirectionRouteArgs {
  const GetDirectionRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i54.Key? key;

  final _i56.ReservationModel reservation;

  @override
  String toString() {
    return 'GetDirectionRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i53.PageRouteInfo<void> {
  const LoginRoute({List<_i53.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MainOrganiserScreen]
class MainOrganiserRoute extends _i53.PageRouteInfo<void> {
  const MainOrganiserRoute({List<_i53.PageRouteInfo>? children})
      : super(
          MainOrganiserRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainOrganiserRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MainScreen]
class MainRoute extends _i53.PageRouteInfo<void> {
  const MainRoute({List<_i53.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i18.MovieDetailCinemaScreen]
class MovieDetailCinemaRoute
    extends _i53.PageRouteInfo<MovieDetailCinemaRouteArgs> {
  MovieDetailCinemaRoute({
    _i54.Key? key,
    required String cinema,
    required _i57.MovieModel movie,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          MovieDetailCinemaRoute.name,
          args: MovieDetailCinemaRouteArgs(
            key: key,
            cinema: cinema,
            movie: movie,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailCinemaRoute';

  static const _i53.PageInfo<MovieDetailCinemaRouteArgs> page =
      _i53.PageInfo<MovieDetailCinemaRouteArgs>(name);
}

class MovieDetailCinemaRouteArgs {
  const MovieDetailCinemaRouteArgs({
    this.key,
    required this.cinema,
    required this.movie,
  });

  final _i54.Key? key;

  final String cinema;

  final _i57.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailCinemaRouteArgs{key: $key, cinema: $cinema, movie: $movie}';
  }
}

/// generated route for
/// [_i19.MovieDetailScreen]
class MovieDetailRoute extends _i53.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i54.Key? key,
    required _i57.MovieModel movie,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(
            key: key,
            movie: movie,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static const _i53.PageInfo<MovieDetailRouteArgs> page =
      _i53.PageInfo<MovieDetailRouteArgs>(name);
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movie,
  });

  final _i54.Key? key;

  final _i57.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movie: $movie}';
  }
}

/// generated route for
/// [_i20.NotificationPage]
class NotificationRoute extends _i53.PageRouteInfo<void> {
  const NotificationRoute({List<_i53.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i21.OrganiserAccountScreen]
class OrganiserAccountRoute extends _i53.PageRouteInfo<void> {
  const OrganiserAccountRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserAccountRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i22.OrganiserEventScreen]
class OrganiserEventRoute extends _i53.PageRouteInfo<void> {
  const OrganiserEventRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserEventRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i23.OrganiserHomeScreen]
class OrganiserHomeRoute extends _i53.PageRouteInfo<void> {
  const OrganiserHomeRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserHomeRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i24.OrganiserLoginScreen]
class OrganiserLoginRoute extends _i53.PageRouteInfo<void> {
  const OrganiserLoginRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserLoginRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i25.OrganiserReservationScreen]
class OrganiserReservationRoute extends _i53.PageRouteInfo<void> {
  const OrganiserReservationRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserReservationRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserReservationRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i26.OrganiserSignupScreen]
class OrganiserSignupRoute extends _i53.PageRouteInfo<void> {
  const OrganiserSignupRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserSignupRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i27.OrganiserStatistqueScreen]
class OrganiserStatistqueRoute extends _i53.PageRouteInfo<void> {
  const OrganiserStatistqueRoute({List<_i53.PageRouteInfo>? children})
      : super(
          OrganiserStatistqueRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserStatistqueRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i28.OrganiserVerifyOtpScreen]
class OrganiserVerifyOtpRoute
    extends _i53.PageRouteInfo<OrganiserVerifyOtpRouteArgs> {
  OrganiserVerifyOtpRoute({
    _i54.Key? key,
    required String email,
    required dynamic json,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          OrganiserVerifyOtpRoute.name,
          args: OrganiserVerifyOtpRouteArgs(
            key: key,
            email: email,
            json: json,
          ),
          initialChildren: children,
        );

  static const String name = 'OrganiserVerifyOtpRoute';

  static const _i53.PageInfo<OrganiserVerifyOtpRouteArgs> page =
      _i53.PageInfo<OrganiserVerifyOtpRouteArgs>(name);
}

class OrganiserVerifyOtpRouteArgs {
  const OrganiserVerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i54.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'OrganiserVerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i29.PaiementMethodeScreen]
class PaiementMethodeRoute extends _i53.PageRouteInfo<void> {
  const PaiementMethodeRoute({List<_i53.PageRouteInfo>? children})
      : super(
          PaiementMethodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaiementMethodeRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i30.ParkingDetailsScreen]
class ParkingDetailsRoute extends _i53.PageRouteInfo<ParkingDetailsRouteArgs> {
  ParkingDetailsRoute({
    _i54.Key? key,
    required _i58.ParkingModel parking,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          ParkingDetailsRoute.name,
          args: ParkingDetailsRouteArgs(
            key: key,
            parking: parking,
          ),
          initialChildren: children,
        );

  static const String name = 'ParkingDetailsRoute';

  static const _i53.PageInfo<ParkingDetailsRouteArgs> page =
      _i53.PageInfo<ParkingDetailsRouteArgs>(name);
}

class ParkingDetailsRouteArgs {
  const ParkingDetailsRouteArgs({
    this.key,
    required this.parking,
  });

  final _i54.Key? key;

  final _i58.ParkingModel parking;

  @override
  String toString() {
    return 'ParkingDetailsRouteArgs{key: $key, parking: $parking}';
  }
}

/// generated route for
/// [_i31.PasswordOtpScreen]
class PasswordOtpRoute extends _i53.PageRouteInfo<PasswordOtpRouteArgs> {
  PasswordOtpRoute({
    _i54.Key? key,
    required String email,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          PasswordOtpRoute.name,
          args: PasswordOtpRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordOtpRoute';

  static const _i53.PageInfo<PasswordOtpRouteArgs> page =
      _i53.PageInfo<PasswordOtpRouteArgs>(name);
}

class PasswordOtpRouteArgs {
  const PasswordOtpRouteArgs({
    this.key,
    required this.email,
  });

  final _i54.Key? key;

  final String email;

  @override
  String toString() {
    return 'PasswordOtpRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i32.RelatedEventScreen]
class RelatedEventRoute extends _i53.PageRouteInfo<void> {
  const RelatedEventRoute({List<_i53.PageRouteInfo>? children})
      : super(
          RelatedEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelatedEventRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i33.ReservationListScreen]
class ReservationListRoute extends _i53.PageRouteInfo<void> {
  const ReservationListRoute({List<_i53.PageRouteInfo>? children})
      : super(
          ReservationListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReservationListRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i34.ReservationScreen]
class ReservationRoute extends _i53.PageRouteInfo<ReservationRouteArgs> {
  ReservationRoute({
    _i54.Key? key,
    required String idparking,
    required _i58.ParkingModel parking,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          ReservationRoute.name,
          args: ReservationRouteArgs(
            key: key,
            idparking: idparking,
            parking: parking,
          ),
          initialChildren: children,
        );

  static const String name = 'ReservationRoute';

  static const _i53.PageInfo<ReservationRouteArgs> page =
      _i53.PageInfo<ReservationRouteArgs>(name);
}

class ReservationRouteArgs {
  const ReservationRouteArgs({
    this.key,
    required this.idparking,
    required this.parking,
  });

  final _i54.Key? key;

  final String idparking;

  final _i58.ParkingModel parking;

  @override
  String toString() {
    return 'ReservationRouteArgs{key: $key, idparking: $idparking, parking: $parking}';
  }
}

/// generated route for
/// [_i35.ResetPasswordScreen]
class ResetPasswordRoute extends _i53.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i54.Key? key,
    required String email,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i53.PageInfo<ResetPasswordRouteArgs> page =
      _i53.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i54.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i36.SettingScreen]
class SettingRoute extends _i53.PageRouteInfo<void> {
  const SettingRoute({List<_i53.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i37.SignupScreen]
class SignupRoute extends _i53.PageRouteInfo<void> {
  const SignupRoute({List<_i53.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i38.SplashScreen]
class SplashRoute extends _i53.PageRouteInfo<void> {
  const SplashRoute({List<_i53.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i39.TicketScreen]
class TicketRoute extends _i53.PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    _i54.Key? key,
    required _i56.ReservationModel reservation,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static const _i53.PageInfo<TicketRouteArgs> page =
      _i53.PageInfo<TicketRouteArgs>(name);
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i54.Key? key;

  final _i56.ReservationModel reservation;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i40.TimerScreen]
class TimerRoute extends _i53.PageRouteInfo<TimerRouteArgs> {
  TimerRoute({
    _i54.Key? key,
    required _i56.ReservationModel reservation,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          TimerRoute.name,
          args: TimerRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TimerRoute';

  static const _i53.PageInfo<TimerRouteArgs> page =
      _i53.PageInfo<TimerRouteArgs>(name);
}

class TimerRouteArgs {
  const TimerRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i54.Key? key;

  final _i56.ReservationModel reservation;

  @override
  String toString() {
    return 'TimerRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i41.UpdateProfileScreen]
class UpdateProfileRoute extends _i53.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i53.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i42.UserManagementScreen]
class UserManagementRoute extends _i53.PageRouteInfo<void> {
  const UserManagementRoute({List<_i53.PageRouteInfo>? children})
      : super(
          UserManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i43.VehiculeListReservationEventScreen]
class VehiculeListReservationEventRoute
    extends _i53.PageRouteInfo<VehiculeListReservationEventRouteArgs> {
  VehiculeListReservationEventRoute({
    _i54.Key? key,
    required double finalPrice,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          VehiculeListReservationEventRoute.name,
          args: VehiculeListReservationEventRouteArgs(
            key: key,
            finalPrice: finalPrice,
          ),
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationEventRoute';

  static const _i53.PageInfo<VehiculeListReservationEventRouteArgs> page =
      _i53.PageInfo<VehiculeListReservationEventRouteArgs>(name);
}

class VehiculeListReservationEventRouteArgs {
  const VehiculeListReservationEventRouteArgs({
    this.key,
    required this.finalPrice,
  });

  final _i54.Key? key;

  final double finalPrice;

  @override
  String toString() {
    return 'VehiculeListReservationEventRouteArgs{key: $key, finalPrice: $finalPrice}';
  }
}

/// generated route for
/// [_i44.VehiculeListReservationScreen]
class VehiculeListReservationRoute
    extends _i53.PageRouteInfo<VehiculeListReservationRouteArgs> {
  VehiculeListReservationRoute({
    _i54.Key? key,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          VehiculeListReservationRoute.name,
          args: VehiculeListReservationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationRoute';

  static const _i53.PageInfo<VehiculeListReservationRouteArgs> page =
      _i53.PageInfo<VehiculeListReservationRouteArgs>(name);
}

class VehiculeListReservationRouteArgs {
  const VehiculeListReservationRouteArgs({this.key});

  final _i54.Key? key;

  @override
  String toString() {
    return 'VehiculeListReservationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i45.VehiculeListScreen]
class VehiculeListRoute extends _i53.PageRouteInfo<void> {
  const VehiculeListRoute({List<_i53.PageRouteInfo>? children})
      : super(
          VehiculeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehiculeListRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i46.VerifyOtpScreen]
class VerifyOtpRoute extends _i53.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i54.Key? key,
    required String email,
    required dynamic json,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          VerifyOtpRoute.name,
          args: VerifyOtpRouteArgs(
            key: key,
            email: email,
            json: json,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyOtpRoute';

  static const _i53.PageInfo<VerifyOtpRouteArgs> page =
      _i53.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i54.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i47.WelcomeScreen]
class WelcomeRoute extends _i53.PageRouteInfo<void> {
  const WelcomeRoute({List<_i53.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i48.accountScreen]
class AccountRoute extends _i53.PageRouteInfo<void> {
  const AccountRoute({List<_i53.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i49.addParkingEventScreen]
class AddParkingEventRoute
    extends _i53.PageRouteInfo<AddParkingEventRouteArgs> {
  AddParkingEventRoute({
    _i54.Key? key,
    required Map<String, dynamic> eventData,
    required _i59.File image,
    List<_i53.PageRouteInfo>? children,
  }) : super(
          AddParkingEventRoute.name,
          args: AddParkingEventRouteArgs(
            key: key,
            eventData: eventData,
            image: image,
          ),
          initialChildren: children,
        );

  static const String name = 'AddParkingEventRoute';

  static const _i53.PageInfo<AddParkingEventRouteArgs> page =
      _i53.PageInfo<AddParkingEventRouteArgs>(name);
}

class AddParkingEventRouteArgs {
  const AddParkingEventRouteArgs({
    this.key,
    required this.eventData,
    required this.image,
  });

  final _i54.Key? key;

  final Map<String, dynamic> eventData;

  final _i59.File image;

  @override
  String toString() {
    return 'AddParkingEventRouteArgs{key: $key, eventData: $eventData, image: $image}';
  }
}

/// generated route for
/// [_i50.eventScreen]
class EventRoute extends _i53.PageRouteInfo<void> {
  const EventRoute({List<_i53.PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i51.homeScreen]
class HomeRoute extends _i53.PageRouteInfo<void> {
  const HomeRoute({List<_i53.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}

/// generated route for
/// [_i52.parkingsScreen]
class ParkingsRoute extends _i53.PageRouteInfo<void> {
  const ParkingsRoute({List<_i53.PageRouteInfo>? children})
      : super(
          ParkingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParkingsRoute';

  static const _i53.PageInfo<void> page = _i53.PageInfo<void>(name);
}
