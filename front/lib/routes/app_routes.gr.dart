// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i51;

import 'package:auto_route/auto_route.dart' as _i45;
import 'package:flutter/material.dart' as _i46;
import 'package:front/features/event/data/models/movie/movie_model.dart'
    as _i49;
import 'package:front/features/event/presentation/pages/add_event_organiser.dart'
    as _i1;
import 'package:front/features/event/presentation/pages/add_parking_event.dart'
    as _i41;
import 'package:front/features/event/presentation/pages/movie_details.dart'
    as _i11;
import 'package:front/features/event/presentation/pages/movie_details_cinema.dart'
    as _i10;
import 'package:front/features/event/presentation/pages/related_events_screen.dart'
    as _i24;
import 'package:front/features/notification/presentation/pages/notification_screen.dart'
    as _i12;
import 'package:front/features/organiser/presentation/pages/login_organiser.dart'
    as _i16;
import 'package:front/features/organiser/presentation/pages/main_organiser_screen.dart'
    as _i8;
import 'package:front/features/organiser/presentation/pages/oragniser_home_screen.dart'
    as _i15;
import 'package:front/features/organiser/presentation/pages/organiser_account_screen.dart'
    as _i13;
import 'package:front/features/organiser/presentation/pages/organiser_events_screen.dart'
    as _i14;
import 'package:front/features/organiser/presentation/pages/organiser_reservations_screen.dart'
    as _i17;
import 'package:front/features/organiser/presentation/pages/organiser_statistiques_screen.dart'
    as _i19;
import 'package:front/features/organiser/presentation/pages/sign_up_organiser.dart'
    as _i18;
import 'package:front/features/organiser/presentation/pages/verify_otp_organiser.dart'
    as _i20;
import 'package:front/features/paiement/presentation/pages/billing_historic_screen.dart'
    as _i4;
import 'package:front/features/parking/data/models/parking_model.dart' as _i50;
import 'package:front/features/parking/presentation/pages/parking_details_screen.dart'
    as _i22;
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart'
    as _i48;
import 'package:front/features/reservation/presentation/pages/get_direction_screen.dart'
    as _i6;
import 'package:front/features/reservation/presentation/pages/reservation_list_screen.dart'
    as _i25;
import 'package:front/features/reservation/presentation/pages/reservation_screen.dart'
    as _i26;
import 'package:front/features/reservation/presentation/pages/ticket_screen.dart'
    as _i31;
import 'package:front/features/reservation/presentation/pages/timer_screen.dart'
    as _i32;
import 'package:front/features/user/presentation/pages/account_screen.dart'
    as _i40;
import 'package:front/features/user/presentation/pages/billing_details_screen.dart'
    as _i3;
import 'package:front/features/user/presentation/pages/events_screen.dart'
    as _i42;
import 'package:front/features/user/presentation/pages/forget_password_mail_screen.dart'
    as _i5;
import 'package:front/features/user/presentation/pages/home_screen.dart'
    as _i43;
import 'package:front/features/user/presentation/pages/login_screen.dart'
    as _i7;
import 'package:front/features/user/presentation/pages/main_screen.dart' as _i9;
import 'package:front/features/user/presentation/pages/otp_password.dart'
    as _i23;
import 'package:front/features/user/presentation/pages/otp_verify.dart' as _i38;
import 'package:front/features/user/presentation/pages/parkings_screen.dart'
    as _i44;
import 'package:front/features/user/presentation/pages/payement_methodes.dart'
    as _i21;
import 'package:front/features/user/presentation/pages/reset_password_screen.dart'
    as _i27;
import 'package:front/features/user/presentation/pages/settings_screen.dart'
    as _i28;
import 'package:front/features/user/presentation/pages/signup.dart' as _i29;
import 'package:front/features/user/presentation/pages/splash_screen.dart'
    as _i30;
import 'package:front/features/user/presentation/pages/update_profile_screen.dart'
    as _i33;
import 'package:front/features/user/presentation/pages/user_management_screen.dart'
    as _i34;
import 'package:front/features/user/presentation/pages/welcome_screen.dart'
    as _i39;
import 'package:front/features/vehicule/data/models/vehicule_model.dart'
    as _i47;
import 'package:front/features/vehicule/presentation/pages/add_vehicule_screen.dart'
    as _i2;
import 'package:front/features/vehicule/presentation/pages/vehicle_list_event.dart'
    as _i35;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_reservation.dart'
    as _i36;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_screen.dart'
    as _i37;

abstract class $AppRouter extends _i45.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i45.PageFactory> pagesMap = {
    AddEventRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddEventScreen(),
      );
    },
    AddVehiculeRoute.name: (routeData) {
      final args = routeData.argsAs<AddVehiculeRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddVehiculeScreen(
          key: args.key,
          vehicles: args.vehicles,
        ),
      );
    },
    BillingDetailsRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BillingDetailsScreen(),
      );
    },
    BillingHistoricRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BillingHistoricScreen(),
      );
    },
    ForgetPasswordMailRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ForgetPasswordMailScreen(),
      );
    },
    GetDirectionRoute.name: (routeData) {
      final args = routeData.argsAs<GetDirectionRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.GetDirectionScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginScreen(),
      );
    },
    MainOrganiserRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MainOrganiserScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MainScreen(),
      );
    },
    MovieDetailCinemaRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailCinemaRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.MovieDetailCinemaScreen(
          key: args.key,
          cinema: args.cinema,
          movie: args.movie,
        ),
      );
    },
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.MovieDetailScreen(
          key: args.key,
          movie: args.movie,
        ),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.NotificationPage(),
      );
    },
    OrganiserAccountRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.OrganiserAccountScreen(),
      );
    },
    OrganiserEventRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.OrganiserEventScreen(),
      );
    },
    OrganiserHomeRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.OrganiserHomeScreen(),
      );
    },
    OrganiserLoginRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.OrganiserLoginScreen(),
      );
    },
    OrganiserReservationRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.OrganiserReservationScreen(),
      );
    },
    OrganiserSignupRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.OrganiserSignupScreen(),
      );
    },
    OrganiserStatistqueRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.OrganiserStatistqueScreen(),
      );
    },
    OrganiserVerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<OrganiserVerifyOtpRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.OrganiserVerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    PaiementMethodeRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.PaiementMethodeScreen(),
      );
    },
    ParkingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ParkingDetailsRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.ParkingDetailsScreen(
          key: args.key,
          parking: args.parking,
        ),
      );
    },
    PasswordOtpRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordOtpRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.PasswordOtpScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    RelatedEventRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.RelatedEventScreen(),
      );
    },
    ReservationListRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.ReservationListScreen(),
      );
    },
    ReservationRoute.name: (routeData) {
      final args = routeData.argsAs<ReservationRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.ReservationScreen(
          key: args.key,
          idparking: args.idparking,
          parking: args.parking,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.ResetPasswordScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    SettingRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.SettingScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.SplashScreen(),
      );
    },
    TicketRoute.name: (routeData) {
      final args = routeData.argsAs<TicketRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.TicketScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.TimerScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.UpdateProfileScreen(),
      );
    },
    UserManagementRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.UserManagementScreen(),
      );
    },
    VehiculeListReservationEventRoute.name: (routeData) {
      final args = routeData.argsAs<VehiculeListReservationEventRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.VehiculeListReservationEventScreen(
          key: args.key,
          finalPrice: args.finalPrice,
        ),
      );
    },
    VehiculeListReservationRoute.name: (routeData) {
      final args = routeData.argsAs<VehiculeListReservationRouteArgs>(
          orElse: () => const VehiculeListReservationRouteArgs());
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i36.VehiculeListReservationScreen(key: args.key),
      );
    },
    VehiculeListRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.VehiculeListScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i38.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.WelcomeScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.accountScreen(),
      );
    },
    AddParkingEventRoute.name: (routeData) {
      final args = routeData.argsAs<AddParkingEventRouteArgs>();
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i41.addParkingEventScreen(
          key: args.key,
          eventData: args.eventData,
          image: args.image,
        ),
      );
    },
    EventRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i42.eventScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i43.homeScreen(),
      );
    },
    ParkingsRoute.name: (routeData) {
      return _i45.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i44.parkingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i45.PageRouteInfo<void> {
  const AddEventRoute({List<_i45.PageRouteInfo>? children})
      : super(
          AddEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddVehiculeScreen]
class AddVehiculeRoute extends _i45.PageRouteInfo<AddVehiculeRouteArgs> {
  AddVehiculeRoute({
    _i46.Key? key,
    required List<_i47.VehiculeModel> vehicles,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          AddVehiculeRoute.name,
          args: AddVehiculeRouteArgs(
            key: key,
            vehicles: vehicles,
          ),
          initialChildren: children,
        );

  static const String name = 'AddVehiculeRoute';

  static const _i45.PageInfo<AddVehiculeRouteArgs> page =
      _i45.PageInfo<AddVehiculeRouteArgs>(name);
}

class AddVehiculeRouteArgs {
  const AddVehiculeRouteArgs({
    this.key,
    required this.vehicles,
  });

  final _i46.Key? key;

  final List<_i47.VehiculeModel> vehicles;

  @override
  String toString() {
    return 'AddVehiculeRouteArgs{key: $key, vehicles: $vehicles}';
  }
}

/// generated route for
/// [_i3.BillingDetailsScreen]
class BillingDetailsRoute extends _i45.PageRouteInfo<void> {
  const BillingDetailsRoute({List<_i45.PageRouteInfo>? children})
      : super(
          BillingDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingDetailsRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BillingHistoricScreen]
class BillingHistoricRoute extends _i45.PageRouteInfo<void> {
  const BillingHistoricRoute({List<_i45.PageRouteInfo>? children})
      : super(
          BillingHistoricRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingHistoricRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ForgetPasswordMailScreen]
class ForgetPasswordMailRoute extends _i45.PageRouteInfo<void> {
  const ForgetPasswordMailRoute({List<_i45.PageRouteInfo>? children})
      : super(
          ForgetPasswordMailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordMailRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i6.GetDirectionScreen]
class GetDirectionRoute extends _i45.PageRouteInfo<GetDirectionRouteArgs> {
  GetDirectionRoute({
    _i46.Key? key,
    required _i48.ReservationModel reservation,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          GetDirectionRoute.name,
          args: GetDirectionRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'GetDirectionRoute';

  static const _i45.PageInfo<GetDirectionRouteArgs> page =
      _i45.PageInfo<GetDirectionRouteArgs>(name);
}

class GetDirectionRouteArgs {
  const GetDirectionRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i46.Key? key;

  final _i48.ReservationModel reservation;

  @override
  String toString() {
    return 'GetDirectionRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i45.PageRouteInfo<void> {
  const LoginRoute({List<_i45.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MainOrganiserScreen]
class MainOrganiserRoute extends _i45.PageRouteInfo<void> {
  const MainOrganiserRoute({List<_i45.PageRouteInfo>? children})
      : super(
          MainOrganiserRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainOrganiserRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MainScreen]
class MainRoute extends _i45.PageRouteInfo<void> {
  const MainRoute({List<_i45.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MovieDetailCinemaScreen]
class MovieDetailCinemaRoute
    extends _i45.PageRouteInfo<MovieDetailCinemaRouteArgs> {
  MovieDetailCinemaRoute({
    _i46.Key? key,
    required String cinema,
    required _i49.MovieModel movie,
    List<_i45.PageRouteInfo>? children,
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

  static const _i45.PageInfo<MovieDetailCinemaRouteArgs> page =
      _i45.PageInfo<MovieDetailCinemaRouteArgs>(name);
}

class MovieDetailCinemaRouteArgs {
  const MovieDetailCinemaRouteArgs({
    this.key,
    required this.cinema,
    required this.movie,
  });

  final _i46.Key? key;

  final String cinema;

  final _i49.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailCinemaRouteArgs{key: $key, cinema: $cinema, movie: $movie}';
  }
}

/// generated route for
/// [_i11.MovieDetailScreen]
class MovieDetailRoute extends _i45.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i46.Key? key,
    required _i49.MovieModel movie,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(
            key: key,
            movie: movie,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static const _i45.PageInfo<MovieDetailRouteArgs> page =
      _i45.PageInfo<MovieDetailRouteArgs>(name);
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movie,
  });

  final _i46.Key? key;

  final _i49.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movie: $movie}';
  }
}

/// generated route for
/// [_i12.NotificationPage]
class NotificationRoute extends _i45.PageRouteInfo<void> {
  const NotificationRoute({List<_i45.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i13.OrganiserAccountScreen]
class OrganiserAccountRoute extends _i45.PageRouteInfo<void> {
  const OrganiserAccountRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserAccountRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i14.OrganiserEventScreen]
class OrganiserEventRoute extends _i45.PageRouteInfo<void> {
  const OrganiserEventRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserEventRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i15.OrganiserHomeScreen]
class OrganiserHomeRoute extends _i45.PageRouteInfo<void> {
  const OrganiserHomeRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserHomeRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OrganiserLoginScreen]
class OrganiserLoginRoute extends _i45.PageRouteInfo<void> {
  const OrganiserLoginRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserLoginRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i17.OrganiserReservationScreen]
class OrganiserReservationRoute extends _i45.PageRouteInfo<void> {
  const OrganiserReservationRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserReservationRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserReservationRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i18.OrganiserSignupScreen]
class OrganiserSignupRoute extends _i45.PageRouteInfo<void> {
  const OrganiserSignupRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserSignupRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i19.OrganiserStatistqueScreen]
class OrganiserStatistqueRoute extends _i45.PageRouteInfo<void> {
  const OrganiserStatistqueRoute({List<_i45.PageRouteInfo>? children})
      : super(
          OrganiserStatistqueRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganiserStatistqueRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i20.OrganiserVerifyOtpScreen]
class OrganiserVerifyOtpRoute
    extends _i45.PageRouteInfo<OrganiserVerifyOtpRouteArgs> {
  OrganiserVerifyOtpRoute({
    _i46.Key? key,
    required String email,
    required dynamic json,
    List<_i45.PageRouteInfo>? children,
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

  static const _i45.PageInfo<OrganiserVerifyOtpRouteArgs> page =
      _i45.PageInfo<OrganiserVerifyOtpRouteArgs>(name);
}

class OrganiserVerifyOtpRouteArgs {
  const OrganiserVerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i46.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'OrganiserVerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i21.PaiementMethodeScreen]
class PaiementMethodeRoute extends _i45.PageRouteInfo<void> {
  const PaiementMethodeRoute({List<_i45.PageRouteInfo>? children})
      : super(
          PaiementMethodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaiementMethodeRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i22.ParkingDetailsScreen]
class ParkingDetailsRoute extends _i45.PageRouteInfo<ParkingDetailsRouteArgs> {
  ParkingDetailsRoute({
    _i46.Key? key,
    required _i50.ParkingModel parking,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          ParkingDetailsRoute.name,
          args: ParkingDetailsRouteArgs(
            key: key,
            parking: parking,
          ),
          initialChildren: children,
        );

  static const String name = 'ParkingDetailsRoute';

  static const _i45.PageInfo<ParkingDetailsRouteArgs> page =
      _i45.PageInfo<ParkingDetailsRouteArgs>(name);
}

class ParkingDetailsRouteArgs {
  const ParkingDetailsRouteArgs({
    this.key,
    required this.parking,
  });

  final _i46.Key? key;

  final _i50.ParkingModel parking;

  @override
  String toString() {
    return 'ParkingDetailsRouteArgs{key: $key, parking: $parking}';
  }
}

/// generated route for
/// [_i23.PasswordOtpScreen]
class PasswordOtpRoute extends _i45.PageRouteInfo<PasswordOtpRouteArgs> {
  PasswordOtpRoute({
    _i46.Key? key,
    required String email,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          PasswordOtpRoute.name,
          args: PasswordOtpRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordOtpRoute';

  static const _i45.PageInfo<PasswordOtpRouteArgs> page =
      _i45.PageInfo<PasswordOtpRouteArgs>(name);
}

class PasswordOtpRouteArgs {
  const PasswordOtpRouteArgs({
    this.key,
    required this.email,
  });

  final _i46.Key? key;

  final String email;

  @override
  String toString() {
    return 'PasswordOtpRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i24.RelatedEventScreen]
class RelatedEventRoute extends _i45.PageRouteInfo<void> {
  const RelatedEventRoute({List<_i45.PageRouteInfo>? children})
      : super(
          RelatedEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelatedEventRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i25.ReservationListScreen]
class ReservationListRoute extends _i45.PageRouteInfo<void> {
  const ReservationListRoute({List<_i45.PageRouteInfo>? children})
      : super(
          ReservationListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReservationListRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i26.ReservationScreen]
class ReservationRoute extends _i45.PageRouteInfo<ReservationRouteArgs> {
  ReservationRoute({
    _i46.Key? key,
    required String idparking,
    required _i50.ParkingModel parking,
    List<_i45.PageRouteInfo>? children,
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

  static const _i45.PageInfo<ReservationRouteArgs> page =
      _i45.PageInfo<ReservationRouteArgs>(name);
}

class ReservationRouteArgs {
  const ReservationRouteArgs({
    this.key,
    required this.idparking,
    required this.parking,
  });

  final _i46.Key? key;

  final String idparking;

  final _i50.ParkingModel parking;

  @override
  String toString() {
    return 'ReservationRouteArgs{key: $key, idparking: $idparking, parking: $parking}';
  }
}

/// generated route for
/// [_i27.ResetPasswordScreen]
class ResetPasswordRoute extends _i45.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i46.Key? key,
    required String email,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i45.PageInfo<ResetPasswordRouteArgs> page =
      _i45.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i46.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i28.SettingScreen]
class SettingRoute extends _i45.PageRouteInfo<void> {
  const SettingRoute({List<_i45.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i29.SignupScreen]
class SignupRoute extends _i45.PageRouteInfo<void> {
  const SignupRoute({List<_i45.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i30.SplashScreen]
class SplashRoute extends _i45.PageRouteInfo<void> {
  const SplashRoute({List<_i45.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i31.TicketScreen]
class TicketRoute extends _i45.PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    _i46.Key? key,
    required _i48.ReservationModel reservation,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static const _i45.PageInfo<TicketRouteArgs> page =
      _i45.PageInfo<TicketRouteArgs>(name);
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i46.Key? key;

  final _i48.ReservationModel reservation;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i32.TimerScreen]
class TimerRoute extends _i45.PageRouteInfo<TimerRouteArgs> {
  TimerRoute({
    _i46.Key? key,
    required _i48.ReservationModel reservation,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          TimerRoute.name,
          args: TimerRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TimerRoute';

  static const _i45.PageInfo<TimerRouteArgs> page =
      _i45.PageInfo<TimerRouteArgs>(name);
}

class TimerRouteArgs {
  const TimerRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i46.Key? key;

  final _i48.ReservationModel reservation;

  @override
  String toString() {
    return 'TimerRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i33.UpdateProfileScreen]
class UpdateProfileRoute extends _i45.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i45.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i34.UserManagementScreen]
class UserManagementRoute extends _i45.PageRouteInfo<void> {
  const UserManagementRoute({List<_i45.PageRouteInfo>? children})
      : super(
          UserManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i35.VehiculeListReservationEventScreen]
class VehiculeListReservationEventRoute
    extends _i45.PageRouteInfo<VehiculeListReservationEventRouteArgs> {
  VehiculeListReservationEventRoute({
    _i46.Key? key,
    required double finalPrice,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          VehiculeListReservationEventRoute.name,
          args: VehiculeListReservationEventRouteArgs(
            key: key,
            finalPrice: finalPrice,
          ),
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationEventRoute';

  static const _i45.PageInfo<VehiculeListReservationEventRouteArgs> page =
      _i45.PageInfo<VehiculeListReservationEventRouteArgs>(name);
}

class VehiculeListReservationEventRouteArgs {
  const VehiculeListReservationEventRouteArgs({
    this.key,
    required this.finalPrice,
  });

  final _i46.Key? key;

  final double finalPrice;

  @override
  String toString() {
    return 'VehiculeListReservationEventRouteArgs{key: $key, finalPrice: $finalPrice}';
  }
}

/// generated route for
/// [_i36.VehiculeListReservationScreen]
class VehiculeListReservationRoute
    extends _i45.PageRouteInfo<VehiculeListReservationRouteArgs> {
  VehiculeListReservationRoute({
    _i46.Key? key,
    List<_i45.PageRouteInfo>? children,
  }) : super(
          VehiculeListReservationRoute.name,
          args: VehiculeListReservationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationRoute';

  static const _i45.PageInfo<VehiculeListReservationRouteArgs> page =
      _i45.PageInfo<VehiculeListReservationRouteArgs>(name);
}

class VehiculeListReservationRouteArgs {
  const VehiculeListReservationRouteArgs({this.key});

  final _i46.Key? key;

  @override
  String toString() {
    return 'VehiculeListReservationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i37.VehiculeListScreen]
class VehiculeListRoute extends _i45.PageRouteInfo<void> {
  const VehiculeListRoute({List<_i45.PageRouteInfo>? children})
      : super(
          VehiculeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehiculeListRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i38.VerifyOtpScreen]
class VerifyOtpRoute extends _i45.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i46.Key? key,
    required String email,
    required dynamic json,
    List<_i45.PageRouteInfo>? children,
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

  static const _i45.PageInfo<VerifyOtpRouteArgs> page =
      _i45.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i46.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i39.WelcomeScreen]
class WelcomeRoute extends _i45.PageRouteInfo<void> {
  const WelcomeRoute({List<_i45.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i40.accountScreen]
class AccountRoute extends _i45.PageRouteInfo<void> {
  const AccountRoute({List<_i45.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i41.addParkingEventScreen]
class AddParkingEventRoute
    extends _i45.PageRouteInfo<AddParkingEventRouteArgs> {
  AddParkingEventRoute({
    _i46.Key? key,
    required Map<String, dynamic> eventData,
    required _i51.File image,
    List<_i45.PageRouteInfo>? children,
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

  static const _i45.PageInfo<AddParkingEventRouteArgs> page =
      _i45.PageInfo<AddParkingEventRouteArgs>(name);
}

class AddParkingEventRouteArgs {
  const AddParkingEventRouteArgs({
    this.key,
    required this.eventData,
    required this.image,
  });

  final _i46.Key? key;

  final Map<String, dynamic> eventData;

  final _i51.File image;

  @override
  String toString() {
    return 'AddParkingEventRouteArgs{key: $key, eventData: $eventData, image: $image}';
  }
}

/// generated route for
/// [_i42.eventScreen]
class EventRoute extends _i45.PageRouteInfo<void> {
  const EventRoute({List<_i45.PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i43.homeScreen]
class HomeRoute extends _i45.PageRouteInfo<void> {
  const HomeRoute({List<_i45.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}

/// generated route for
/// [_i44.parkingsScreen]
class ParkingsRoute extends _i45.PageRouteInfo<void> {
  const ParkingsRoute({List<_i45.PageRouteInfo>? children})
      : super(
          ParkingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParkingsRoute';

  static const _i45.PageInfo<void> page = _i45.PageInfo<void>(name);
}
