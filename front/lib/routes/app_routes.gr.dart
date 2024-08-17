// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i34;
import 'package:flutter/material.dart' as _i35;
import 'package:front/features/event/data/models/movie/movie_model.dart'
    as _i38;
import 'package:front/features/event/presentation/pages/movie_details.dart'
    as _i9;
import 'package:front/features/event/presentation/pages/movie_details_cinema.dart'
    as _i8;
import 'package:front/features/event/presentation/pages/related_events_screen.dart'
    as _i14;
import 'package:front/features/notification/presentation/pages/notification_screen.dart'
    as _i10;
import 'package:front/features/paiement/presentation/pages/billing_historic_screen.dart'
    as _i3;
import 'package:front/features/parking/data/models/parking_model.dart' as _i39;
import 'package:front/features/parking/presentation/pages/parking_details_screen.dart'
    as _i12;
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart'
    as _i37;
import 'package:front/features/reservation/presentation/pages/get_direction_screen.dart'
    as _i5;
import 'package:front/features/reservation/presentation/pages/reservation_list_screen.dart'
    as _i15;
import 'package:front/features/reservation/presentation/pages/reservation_screen.dart'
    as _i16;
import 'package:front/features/reservation/presentation/pages/ticket_screen.dart'
    as _i21;
import 'package:front/features/reservation/presentation/pages/timer_screen.dart'
    as _i22;
import 'package:front/features/user/presentation/pages/account_screen.dart'
    as _i30;
import 'package:front/features/user/presentation/pages/billing_details_screen.dart'
    as _i2;
import 'package:front/features/user/presentation/pages/events_screen.dart'
    as _i31;
import 'package:front/features/user/presentation/pages/forget_password_mail_screen.dart'
    as _i4;
import 'package:front/features/user/presentation/pages/home_screen.dart'
    as _i32;
import 'package:front/features/user/presentation/pages/login_screen.dart'
    as _i6;
import 'package:front/features/user/presentation/pages/main_screen.dart' as _i7;
import 'package:front/features/user/presentation/pages/otp_password.dart'
    as _i13;
import 'package:front/features/user/presentation/pages/otp_verify.dart' as _i28;
import 'package:front/features/user/presentation/pages/parkings_screen.dart'
    as _i33;
import 'package:front/features/user/presentation/pages/payement_methodes.dart'
    as _i11;
import 'package:front/features/user/presentation/pages/reset_password_screen.dart'
    as _i17;
import 'package:front/features/user/presentation/pages/settings_screen.dart'
    as _i18;
import 'package:front/features/user/presentation/pages/signup.dart' as _i19;
import 'package:front/features/user/presentation/pages/splash_screen.dart'
    as _i20;
import 'package:front/features/user/presentation/pages/update_profile_screen.dart'
    as _i23;
import 'package:front/features/user/presentation/pages/user_management_screen.dart'
    as _i24;
import 'package:front/features/user/presentation/pages/welcome_screen.dart'
    as _i29;
import 'package:front/features/vehicule/data/models/vehicule_model.dart'
    as _i36;
import 'package:front/features/vehicule/presentation/pages/add_vehicule_screen.dart'
    as _i1;
import 'package:front/features/vehicule/presentation/pages/vehicle_list_event.dart'
    as _i25;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_reservation.dart'
    as _i26;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_screen.dart'
    as _i27;

abstract class $AppRouter extends _i34.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i34.PageFactory> pagesMap = {
    AddVehiculeRoute.name: (routeData) {
      final args = routeData.argsAs<AddVehiculeRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddVehiculeScreen(
          key: args.key,
          vehicles: args.vehicles,
        ),
      );
    },
    BillingDetailsRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BillingDetailsScreen(),
      );
    },
    BillingHistoricRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BillingHistoricScreen(),
      );
    },
    ForgetPasswordMailRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ForgetPasswordMailScreen(),
      );
    },
    GetDirectionRoute.name: (routeData) {
      final args = routeData.argsAs<GetDirectionRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.GetDirectionScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MainScreen(),
      );
    },
    MovieDetailCinemaRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailCinemaRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.MovieDetailCinemaScreen(
          key: args.key,
          cinema: args.cinema,
          movie: args.movie,
        ),
      );
    },
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.MovieDetailScreen(
          key: args.key,
          movie: args.movie,
        ),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.NotificationPage(),
      );
    },
    PaiementMethodeRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PaiementMethodeScreen(),
      );
    },
    ParkingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ParkingDetailsRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ParkingDetailsScreen(
          key: args.key,
          parking: args.parking,
        ),
      );
    },
    PasswordOtpRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordOtpRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.PasswordOtpScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    RelatedEventRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RelatedEventScreen(),
      );
    },
    ReservationListRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.ReservationListScreen(),
      );
    },
    ReservationRoute.name: (routeData) {
      final args = routeData.argsAs<ReservationRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.ReservationScreen(
          key: args.key,
          idparking: args.idparking,
          parking: args.parking,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.ResetPasswordScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    SettingRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.SettingScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.SplashScreen(),
      );
    },
    TicketRoute.name: (routeData) {
      final args = routeData.argsAs<TicketRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.TicketScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.TimerScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.UpdateProfileScreen(),
      );
    },
    UserManagementRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.UserManagementScreen(),
      );
    },
    VehiculeListReservationEventRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.VehiculeListReservationEventScreen(),
      );
    },
    VehiculeListReservationRoute.name: (routeData) {
      final args = routeData.argsAs<VehiculeListReservationRouteArgs>(
          orElse: () => const VehiculeListReservationRouteArgs());
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.VehiculeListReservationScreen(key: args.key),
      );
    },
    VehiculeListRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.VehiculeListScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.WelcomeScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.accountScreen(),
      );
    },
    EventRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.eventScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.homeScreen(),
      );
    },
    ParkingsRoute.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.parkingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddVehiculeScreen]
class AddVehiculeRoute extends _i34.PageRouteInfo<AddVehiculeRouteArgs> {
  AddVehiculeRoute({
    _i35.Key? key,
    required List<_i36.VehiculeModel> vehicles,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          AddVehiculeRoute.name,
          args: AddVehiculeRouteArgs(
            key: key,
            vehicles: vehicles,
          ),
          initialChildren: children,
        );

  static const String name = 'AddVehiculeRoute';

  static const _i34.PageInfo<AddVehiculeRouteArgs> page =
      _i34.PageInfo<AddVehiculeRouteArgs>(name);
}

class AddVehiculeRouteArgs {
  const AddVehiculeRouteArgs({
    this.key,
    required this.vehicles,
  });

  final _i35.Key? key;

  final List<_i36.VehiculeModel> vehicles;

  @override
  String toString() {
    return 'AddVehiculeRouteArgs{key: $key, vehicles: $vehicles}';
  }
}

/// generated route for
/// [_i2.BillingDetailsScreen]
class BillingDetailsRoute extends _i34.PageRouteInfo<void> {
  const BillingDetailsRoute({List<_i34.PageRouteInfo>? children})
      : super(
          BillingDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingDetailsRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BillingHistoricScreen]
class BillingHistoricRoute extends _i34.PageRouteInfo<void> {
  const BillingHistoricRoute({List<_i34.PageRouteInfo>? children})
      : super(
          BillingHistoricRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingHistoricRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ForgetPasswordMailScreen]
class ForgetPasswordMailRoute extends _i34.PageRouteInfo<void> {
  const ForgetPasswordMailRoute({List<_i34.PageRouteInfo>? children})
      : super(
          ForgetPasswordMailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordMailRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i5.GetDirectionScreen]
class GetDirectionRoute extends _i34.PageRouteInfo<GetDirectionRouteArgs> {
  GetDirectionRoute({
    _i35.Key? key,
    required _i37.ReservationModel reservation,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          GetDirectionRoute.name,
          args: GetDirectionRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'GetDirectionRoute';

  static const _i34.PageInfo<GetDirectionRouteArgs> page =
      _i34.PageInfo<GetDirectionRouteArgs>(name);
}

class GetDirectionRouteArgs {
  const GetDirectionRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i35.Key? key;

  final _i37.ReservationModel reservation;

  @override
  String toString() {
    return 'GetDirectionRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i34.PageRouteInfo<void> {
  const LoginRoute({List<_i34.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MainScreen]
class MainRoute extends _i34.PageRouteInfo<void> {
  const MainRoute({List<_i34.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MovieDetailCinemaScreen]
class MovieDetailCinemaRoute
    extends _i34.PageRouteInfo<MovieDetailCinemaRouteArgs> {
  MovieDetailCinemaRoute({
    _i35.Key? key,
    required String cinema,
    required _i38.MovieModel movie,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<MovieDetailCinemaRouteArgs> page =
      _i34.PageInfo<MovieDetailCinemaRouteArgs>(name);
}

class MovieDetailCinemaRouteArgs {
  const MovieDetailCinemaRouteArgs({
    this.key,
    required this.cinema,
    required this.movie,
  });

  final _i35.Key? key;

  final String cinema;

  final _i38.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailCinemaRouteArgs{key: $key, cinema: $cinema, movie: $movie}';
  }
}

/// generated route for
/// [_i9.MovieDetailScreen]
class MovieDetailRoute extends _i34.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i35.Key? key,
    required _i38.MovieModel movie,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(
            key: key,
            movie: movie,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static const _i34.PageInfo<MovieDetailRouteArgs> page =
      _i34.PageInfo<MovieDetailRouteArgs>(name);
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movie,
  });

  final _i35.Key? key;

  final _i38.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movie: $movie}';
  }
}

/// generated route for
/// [_i10.NotificationPage]
class NotificationRoute extends _i34.PageRouteInfo<void> {
  const NotificationRoute({List<_i34.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PaiementMethodeScreen]
class PaiementMethodeRoute extends _i34.PageRouteInfo<void> {
  const PaiementMethodeRoute({List<_i34.PageRouteInfo>? children})
      : super(
          PaiementMethodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaiementMethodeRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ParkingDetailsScreen]
class ParkingDetailsRoute extends _i34.PageRouteInfo<ParkingDetailsRouteArgs> {
  ParkingDetailsRoute({
    _i35.Key? key,
    required _i39.ParkingModel parking,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          ParkingDetailsRoute.name,
          args: ParkingDetailsRouteArgs(
            key: key,
            parking: parking,
          ),
          initialChildren: children,
        );

  static const String name = 'ParkingDetailsRoute';

  static const _i34.PageInfo<ParkingDetailsRouteArgs> page =
      _i34.PageInfo<ParkingDetailsRouteArgs>(name);
}

class ParkingDetailsRouteArgs {
  const ParkingDetailsRouteArgs({
    this.key,
    required this.parking,
  });

  final _i35.Key? key;

  final _i39.ParkingModel parking;

  @override
  String toString() {
    return 'ParkingDetailsRouteArgs{key: $key, parking: $parking}';
  }
}

/// generated route for
/// [_i13.PasswordOtpScreen]
class PasswordOtpRoute extends _i34.PageRouteInfo<PasswordOtpRouteArgs> {
  PasswordOtpRoute({
    _i35.Key? key,
    required String email,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          PasswordOtpRoute.name,
          args: PasswordOtpRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordOtpRoute';

  static const _i34.PageInfo<PasswordOtpRouteArgs> page =
      _i34.PageInfo<PasswordOtpRouteArgs>(name);
}

class PasswordOtpRouteArgs {
  const PasswordOtpRouteArgs({
    this.key,
    required this.email,
  });

  final _i35.Key? key;

  final String email;

  @override
  String toString() {
    return 'PasswordOtpRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i14.RelatedEventScreen]
class RelatedEventRoute extends _i34.PageRouteInfo<void> {
  const RelatedEventRoute({List<_i34.PageRouteInfo>? children})
      : super(
          RelatedEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelatedEventRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i15.ReservationListScreen]
class ReservationListRoute extends _i34.PageRouteInfo<void> {
  const ReservationListRoute({List<_i34.PageRouteInfo>? children})
      : super(
          ReservationListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReservationListRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i16.ReservationScreen]
class ReservationRoute extends _i34.PageRouteInfo<ReservationRouteArgs> {
  ReservationRoute({
    _i35.Key? key,
    required String idparking,
    required _i39.ParkingModel parking,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<ReservationRouteArgs> page =
      _i34.PageInfo<ReservationRouteArgs>(name);
}

class ReservationRouteArgs {
  const ReservationRouteArgs({
    this.key,
    required this.idparking,
    required this.parking,
  });

  final _i35.Key? key;

  final String idparking;

  final _i39.ParkingModel parking;

  @override
  String toString() {
    return 'ReservationRouteArgs{key: $key, idparking: $idparking, parking: $parking}';
  }
}

/// generated route for
/// [_i17.ResetPasswordScreen]
class ResetPasswordRoute extends _i34.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i35.Key? key,
    required String email,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i34.PageInfo<ResetPasswordRouteArgs> page =
      _i34.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i35.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i18.SettingScreen]
class SettingRoute extends _i34.PageRouteInfo<void> {
  const SettingRoute({List<_i34.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i19.SignupScreen]
class SignupRoute extends _i34.PageRouteInfo<void> {
  const SignupRoute({List<_i34.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i20.SplashScreen]
class SplashRoute extends _i34.PageRouteInfo<void> {
  const SplashRoute({List<_i34.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i21.TicketScreen]
class TicketRoute extends _i34.PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    _i35.Key? key,
    required _i37.ReservationModel reservation,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static const _i34.PageInfo<TicketRouteArgs> page =
      _i34.PageInfo<TicketRouteArgs>(name);
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i35.Key? key;

  final _i37.ReservationModel reservation;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i22.TimerScreen]
class TimerRoute extends _i34.PageRouteInfo<TimerRouteArgs> {
  TimerRoute({
    _i35.Key? key,
    required _i37.ReservationModel reservation,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          TimerRoute.name,
          args: TimerRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TimerRoute';

  static const _i34.PageInfo<TimerRouteArgs> page =
      _i34.PageInfo<TimerRouteArgs>(name);
}

class TimerRouteArgs {
  const TimerRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i35.Key? key;

  final _i37.ReservationModel reservation;

  @override
  String toString() {
    return 'TimerRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i23.UpdateProfileScreen]
class UpdateProfileRoute extends _i34.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i34.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i24.UserManagementScreen]
class UserManagementRoute extends _i34.PageRouteInfo<void> {
  const UserManagementRoute({List<_i34.PageRouteInfo>? children})
      : super(
          UserManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i25.VehiculeListReservationEventScreen]
class VehiculeListReservationEventRoute extends _i34.PageRouteInfo<void> {
  const VehiculeListReservationEventRoute({List<_i34.PageRouteInfo>? children})
      : super(
          VehiculeListReservationEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationEventRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i26.VehiculeListReservationScreen]
class VehiculeListReservationRoute
    extends _i34.PageRouteInfo<VehiculeListReservationRouteArgs> {
  VehiculeListReservationRoute({
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          VehiculeListReservationRoute.name,
          args: VehiculeListReservationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationRoute';

  static const _i34.PageInfo<VehiculeListReservationRouteArgs> page =
      _i34.PageInfo<VehiculeListReservationRouteArgs>(name);
}

class VehiculeListReservationRouteArgs {
  const VehiculeListReservationRouteArgs({this.key});

  final _i35.Key? key;

  @override
  String toString() {
    return 'VehiculeListReservationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i27.VehiculeListScreen]
class VehiculeListRoute extends _i34.PageRouteInfo<void> {
  const VehiculeListRoute({List<_i34.PageRouteInfo>? children})
      : super(
          VehiculeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehiculeListRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i28.VerifyOtpScreen]
class VerifyOtpRoute extends _i34.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i35.Key? key,
    required String email,
    required dynamic json,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<VerifyOtpRouteArgs> page =
      _i34.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i35.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i29.WelcomeScreen]
class WelcomeRoute extends _i34.PageRouteInfo<void> {
  const WelcomeRoute({List<_i34.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i30.accountScreen]
class AccountRoute extends _i34.PageRouteInfo<void> {
  const AccountRoute({List<_i34.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i31.eventScreen]
class EventRoute extends _i34.PageRouteInfo<void> {
  const EventRoute({List<_i34.PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i32.homeScreen]
class HomeRoute extends _i34.PageRouteInfo<void> {
  const HomeRoute({List<_i34.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i33.parkingsScreen]
class ParkingsRoute extends _i34.PageRouteInfo<void> {
  const ParkingsRoute({List<_i34.PageRouteInfo>? children})
      : super(
          ParkingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParkingsRoute';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}
