// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/material.dart' as _i34;
import 'package:front/features/event/data/models/movie/movie_model.dart'
    as _i37;
import 'package:front/features/event/presentation/pages/movie_details.dart'
    as _i8;
import 'package:front/features/event/presentation/pages/movie_details_cinema.dart'
    as _i7;
import 'package:front/features/event/presentation/pages/related_events_screen.dart'
    as _i12;
import 'package:front/features/paiement/presentation/pages/billing_historic_screen.dart'
    as _i3;
import 'package:front/features/parking/presentation/pages/parking_details_screen.dart'
    as _i10;
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart'
    as _i36;
import 'package:front/features/reservation/presentation/pages/get_direction_screen.dart'
    as _i5;
import 'package:front/features/reservation/presentation/pages/reservation_list_screen.dart'
    as _i13;
import 'package:front/features/reservation/presentation/pages/reservation_screen.dart'
    as _i14;
import 'package:front/features/reservation/presentation/pages/ticket_screen.dart'
    as _i19;
import 'package:front/features/reservation/presentation/pages/timer_screen.dart'
    as _i20;
import 'package:front/features/user/presentation/pages/account_screen.dart'
    as _i28;
import 'package:front/features/user/presentation/pages/billing_details_screen.dart'
    as _i2;
import 'package:front/features/user/presentation/pages/events_screen.dart'
    as _i29;
import 'package:front/features/user/presentation/pages/forget_password_mail_screen.dart'
    as _i4;
import 'package:front/features/user/presentation/pages/home_screen.dart'
    as _i30;
import 'package:front/features/user/presentation/pages/login_screen.dart'
    as _i6;
import 'package:front/features/user/presentation/pages/main_screen.dart'
    as _i31;
import 'package:front/features/user/presentation/pages/otp_password.dart'
    as _i11;
import 'package:front/features/user/presentation/pages/otp_verify.dart' as _i26;
import 'package:front/features/user/presentation/pages/parkings_screen.dart'
    as _i32;
import 'package:front/features/user/presentation/pages/payement_methodes.dart'
    as _i9;
import 'package:front/features/user/presentation/pages/reset_password_screen.dart'
    as _i15;
import 'package:front/features/user/presentation/pages/settings_screen.dart'
    as _i16;
import 'package:front/features/user/presentation/pages/signup.dart' as _i17;
import 'package:front/features/user/presentation/pages/splash_screen.dart'
    as _i18;
import 'package:front/features/user/presentation/pages/update_profile_screen.dart'
    as _i21;
import 'package:front/features/user/presentation/pages/user_management_screen.dart'
    as _i22;
import 'package:front/features/user/presentation/pages/welcome_screen.dart'
    as _i27;
import 'package:front/features/vehicule/data/models/vehicule_model.dart'
    as _i35;
import 'package:front/features/vehicule/presentation/pages/add_vehicule_screen.dart'
    as _i1;
import 'package:front/features/vehicule/presentation/pages/vehicle_list_event.dart'
    as _i23;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_reservation.dart'
    as _i24;
import 'package:front/features/vehicule/presentation/pages/vehicule_list_screen.dart'
    as _i25;

abstract class $AppRouter extends _i33.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    AddVehiculeRoute.name: (routeData) {
      final args = routeData.argsAs<AddVehiculeRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddVehiculeScreen(
          key: args.key,
          vehicles: args.vehicles,
        ),
      );
    },
    BillingDetailsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BillingDetailsScreen(),
      );
    },
    BillingHistoricRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BillingHistoricScreen(),
      );
    },
    ForgetPasswordMailRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ForgetPasswordMailScreen(),
      );
    },
    GetDirectionRoute.name: (routeData) {
      final args = routeData.argsAs<GetDirectionRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.GetDirectionScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginScreen(),
      );
    },
    MovieDetailCinemaRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailCinemaRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.MovieDetailCinemaScreen(
          key: args.key,
          cinema: args.cinema,
          movie: args.movie,
        ),
      );
    },
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.MovieDetailScreen(
          key: args.key,
          movie: args.movie,
        ),
      );
    },
    PaiementMethodeRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaiementMethodeScreen(),
      );
    },
    ParkingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ParkingDetailsRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ParkingDetailsScreen(
          key: args.key,
          id: args.id,
          parkingName: args.parkingName,
          capacity: args.capacity,
          description: args.description,
          location: args.location,
          phoneContact: args.phoneContact,
          mailContact: args.mailContact,
          adress: args.adress,
        ),
      );
    },
    PasswordOtpRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordOtpRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.PasswordOtpScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    RelatedEventRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.RelatedEventScreen(),
      );
    },
    ReservationListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ReservationListScreen(),
      );
    },
    ReservationRoute.name: (routeData) {
      final args = routeData.argsAs<ReservationRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.ReservationScreen(
          key: args.key,
          idparking: args.idparking,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.ResetPasswordScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    SettingRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.SettingScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.SplashScreen(),
      );
    },
    TicketRoute.name: (routeData) {
      final args = routeData.argsAs<TicketRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.TicketScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.TimerScreen(
          key: args.key,
          reservation: args.reservation,
        ),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.UpdateProfileScreen(),
      );
    },
    UserManagementRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.UserManagementScreen(),
      );
    },
    VehiculeListReservationEventRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.VehiculeListReservationEventScreen(),
      );
    },
    VehiculeListReservationRoute.name: (routeData) {
      final args = routeData.argsAs<VehiculeListReservationRouteArgs>(
          orElse: () => const VehiculeListReservationRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.VehiculeListReservationScreen(key: args.key),
      );
    },
    VehiculeListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.VehiculeListScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.WelcomeScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.accountScreen(),
      );
    },
    EventRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.eventScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.homeScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.mainScreen(),
      );
    },
    ParkingsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.parkingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddVehiculeScreen]
class AddVehiculeRoute extends _i33.PageRouteInfo<AddVehiculeRouteArgs> {
  AddVehiculeRoute({
    _i34.Key? key,
    required List<_i35.VehiculeModel> vehicles,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddVehiculeRoute.name,
          args: AddVehiculeRouteArgs(
            key: key,
            vehicles: vehicles,
          ),
          initialChildren: children,
        );

  static const String name = 'AddVehiculeRoute';

  static const _i33.PageInfo<AddVehiculeRouteArgs> page =
      _i33.PageInfo<AddVehiculeRouteArgs>(name);
}

class AddVehiculeRouteArgs {
  const AddVehiculeRouteArgs({
    this.key,
    required this.vehicles,
  });

  final _i34.Key? key;

  final List<_i35.VehiculeModel> vehicles;

  @override
  String toString() {
    return 'AddVehiculeRouteArgs{key: $key, vehicles: $vehicles}';
  }
}

/// generated route for
/// [_i2.BillingDetailsScreen]
class BillingDetailsRoute extends _i33.PageRouteInfo<void> {
  const BillingDetailsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          BillingDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingDetailsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BillingHistoricScreen]
class BillingHistoricRoute extends _i33.PageRouteInfo<void> {
  const BillingHistoricRoute({List<_i33.PageRouteInfo>? children})
      : super(
          BillingHistoricRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingHistoricRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ForgetPasswordMailScreen]
class ForgetPasswordMailRoute extends _i33.PageRouteInfo<void> {
  const ForgetPasswordMailRoute({List<_i33.PageRouteInfo>? children})
      : super(
          ForgetPasswordMailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordMailRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i5.GetDirectionScreen]
class GetDirectionRoute extends _i33.PageRouteInfo<GetDirectionRouteArgs> {
  GetDirectionRoute({
    _i34.Key? key,
    required _i36.ReservationModel reservation,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          GetDirectionRoute.name,
          args: GetDirectionRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'GetDirectionRoute';

  static const _i33.PageInfo<GetDirectionRouteArgs> page =
      _i33.PageInfo<GetDirectionRouteArgs>(name);
}

class GetDirectionRouteArgs {
  const GetDirectionRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i34.Key? key;

  final _i36.ReservationModel reservation;

  @override
  String toString() {
    return 'GetDirectionRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i33.PageRouteInfo<void> {
  const LoginRoute({List<_i33.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MovieDetailCinemaScreen]
class MovieDetailCinemaRoute
    extends _i33.PageRouteInfo<MovieDetailCinemaRouteArgs> {
  MovieDetailCinemaRoute({
    _i34.Key? key,
    required String cinema,
    required _i37.MovieModel movie,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<MovieDetailCinemaRouteArgs> page =
      _i33.PageInfo<MovieDetailCinemaRouteArgs>(name);
}

class MovieDetailCinemaRouteArgs {
  const MovieDetailCinemaRouteArgs({
    this.key,
    required this.cinema,
    required this.movie,
  });

  final _i34.Key? key;

  final String cinema;

  final _i37.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailCinemaRouteArgs{key: $key, cinema: $cinema, movie: $movie}';
  }
}

/// generated route for
/// [_i8.MovieDetailScreen]
class MovieDetailRoute extends _i33.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i34.Key? key,
    required _i37.MovieModel movie,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(
            key: key,
            movie: movie,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static const _i33.PageInfo<MovieDetailRouteArgs> page =
      _i33.PageInfo<MovieDetailRouteArgs>(name);
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movie,
  });

  final _i34.Key? key;

  final _i37.MovieModel movie;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movie: $movie}';
  }
}

/// generated route for
/// [_i9.PaiementMethodeScreen]
class PaiementMethodeRoute extends _i33.PageRouteInfo<void> {
  const PaiementMethodeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          PaiementMethodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaiementMethodeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ParkingDetailsScreen]
class ParkingDetailsRoute extends _i33.PageRouteInfo<ParkingDetailsRouteArgs> {
  ParkingDetailsRoute({
    _i34.Key? key,
    required String id,
    required String parkingName,
    required String capacity,
    required String description,
    required String location,
    required String phoneContact,
    required String mailContact,
    required String adress,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          ParkingDetailsRoute.name,
          args: ParkingDetailsRouteArgs(
            key: key,
            id: id,
            parkingName: parkingName,
            capacity: capacity,
            description: description,
            location: location,
            phoneContact: phoneContact,
            mailContact: mailContact,
            adress: adress,
          ),
          initialChildren: children,
        );

  static const String name = 'ParkingDetailsRoute';

  static const _i33.PageInfo<ParkingDetailsRouteArgs> page =
      _i33.PageInfo<ParkingDetailsRouteArgs>(name);
}

class ParkingDetailsRouteArgs {
  const ParkingDetailsRouteArgs({
    this.key,
    required this.id,
    required this.parkingName,
    required this.capacity,
    required this.description,
    required this.location,
    required this.phoneContact,
    required this.mailContact,
    required this.adress,
  });

  final _i34.Key? key;

  final String id;

  final String parkingName;

  final String capacity;

  final String description;

  final String location;

  final String phoneContact;

  final String mailContact;

  final String adress;

  @override
  String toString() {
    return 'ParkingDetailsRouteArgs{key: $key, id: $id, parkingName: $parkingName, capacity: $capacity, description: $description, location: $location, phoneContact: $phoneContact, mailContact: $mailContact, adress: $adress}';
  }
}

/// generated route for
/// [_i11.PasswordOtpScreen]
class PasswordOtpRoute extends _i33.PageRouteInfo<PasswordOtpRouteArgs> {
  PasswordOtpRoute({
    _i34.Key? key,
    required String email,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          PasswordOtpRoute.name,
          args: PasswordOtpRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordOtpRoute';

  static const _i33.PageInfo<PasswordOtpRouteArgs> page =
      _i33.PageInfo<PasswordOtpRouteArgs>(name);
}

class PasswordOtpRouteArgs {
  const PasswordOtpRouteArgs({
    this.key,
    required this.email,
  });

  final _i34.Key? key;

  final String email;

  @override
  String toString() {
    return 'PasswordOtpRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i12.RelatedEventScreen]
class RelatedEventRoute extends _i33.PageRouteInfo<void> {
  const RelatedEventRoute({List<_i33.PageRouteInfo>? children})
      : super(
          RelatedEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelatedEventRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ReservationListScreen]
class ReservationListRoute extends _i33.PageRouteInfo<void> {
  const ReservationListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          ReservationListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReservationListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i14.ReservationScreen]
class ReservationRoute extends _i33.PageRouteInfo<ReservationRouteArgs> {
  ReservationRoute({
    _i34.Key? key,
    required String idparking,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          ReservationRoute.name,
          args: ReservationRouteArgs(
            key: key,
            idparking: idparking,
          ),
          initialChildren: children,
        );

  static const String name = 'ReservationRoute';

  static const _i33.PageInfo<ReservationRouteArgs> page =
      _i33.PageInfo<ReservationRouteArgs>(name);
}

class ReservationRouteArgs {
  const ReservationRouteArgs({
    this.key,
    required this.idparking,
  });

  final _i34.Key? key;

  final String idparking;

  @override
  String toString() {
    return 'ReservationRouteArgs{key: $key, idparking: $idparking}';
  }
}

/// generated route for
/// [_i15.ResetPasswordScreen]
class ResetPasswordRoute extends _i33.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i34.Key? key,
    required String email,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i33.PageInfo<ResetPasswordRouteArgs> page =
      _i33.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i34.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i16.SettingScreen]
class SettingRoute extends _i33.PageRouteInfo<void> {
  const SettingRoute({List<_i33.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SignupScreen]
class SignupRoute extends _i33.PageRouteInfo<void> {
  const SignupRoute({List<_i33.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i18.SplashScreen]
class SplashRoute extends _i33.PageRouteInfo<void> {
  const SplashRoute({List<_i33.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i19.TicketScreen]
class TicketRoute extends _i33.PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    _i34.Key? key,
    required _i36.ReservationModel reservation,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static const _i33.PageInfo<TicketRouteArgs> page =
      _i33.PageInfo<TicketRouteArgs>(name);
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i34.Key? key;

  final _i36.ReservationModel reservation;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i20.TimerScreen]
class TimerRoute extends _i33.PageRouteInfo<TimerRouteArgs> {
  TimerRoute({
    _i34.Key? key,
    required _i36.ReservationModel reservation,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          TimerRoute.name,
          args: TimerRouteArgs(
            key: key,
            reservation: reservation,
          ),
          initialChildren: children,
        );

  static const String name = 'TimerRoute';

  static const _i33.PageInfo<TimerRouteArgs> page =
      _i33.PageInfo<TimerRouteArgs>(name);
}

class TimerRouteArgs {
  const TimerRouteArgs({
    this.key,
    required this.reservation,
  });

  final _i34.Key? key;

  final _i36.ReservationModel reservation;

  @override
  String toString() {
    return 'TimerRouteArgs{key: $key, reservation: $reservation}';
  }
}

/// generated route for
/// [_i21.UpdateProfileScreen]
class UpdateProfileRoute extends _i33.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i33.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i22.UserManagementScreen]
class UserManagementRoute extends _i33.PageRouteInfo<void> {
  const UserManagementRoute({List<_i33.PageRouteInfo>? children})
      : super(
          UserManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i23.VehiculeListReservationEventScreen]
class VehiculeListReservationEventRoute extends _i33.PageRouteInfo<void> {
  const VehiculeListReservationEventRoute({List<_i33.PageRouteInfo>? children})
      : super(
          VehiculeListReservationEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationEventRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i24.VehiculeListReservationScreen]
class VehiculeListReservationRoute
    extends _i33.PageRouteInfo<VehiculeListReservationRouteArgs> {
  VehiculeListReservationRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          VehiculeListReservationRoute.name,
          args: VehiculeListReservationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'VehiculeListReservationRoute';

  static const _i33.PageInfo<VehiculeListReservationRouteArgs> page =
      _i33.PageInfo<VehiculeListReservationRouteArgs>(name);
}

class VehiculeListReservationRouteArgs {
  const VehiculeListReservationRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'VehiculeListReservationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i25.VehiculeListScreen]
class VehiculeListRoute extends _i33.PageRouteInfo<void> {
  const VehiculeListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          VehiculeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehiculeListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i26.VerifyOtpScreen]
class VerifyOtpRoute extends _i33.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i34.Key? key,
    required String email,
    required dynamic json,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<VerifyOtpRouteArgs> page =
      _i33.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i34.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i27.WelcomeScreen]
class WelcomeRoute extends _i33.PageRouteInfo<void> {
  const WelcomeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i28.accountScreen]
class AccountRoute extends _i33.PageRouteInfo<void> {
  const AccountRoute({List<_i33.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i29.eventScreen]
class EventRoute extends _i33.PageRouteInfo<void> {
  const EventRoute({List<_i33.PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i30.homeScreen]
class HomeRoute extends _i33.PageRouteInfo<void> {
  const HomeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i31.mainScreen]
class MainRoute extends _i33.PageRouteInfo<void> {
  const MainRoute({List<_i33.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i32.parkingsScreen]
class ParkingsRoute extends _i33.PageRouteInfo<void> {
  const ParkingsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          ParkingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParkingsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}
