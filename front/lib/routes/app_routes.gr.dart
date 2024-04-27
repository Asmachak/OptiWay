// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:front/features/parking/presentation/pages/parking_details_screen.dart'
    as _i4;
import 'package:front/features/user/presentation/pages/account_screen.dart'
    as _i14;
import 'package:front/features/user/presentation/pages/billing_details_screen.dart'
    as _i1;
import 'package:front/features/user/presentation/pages/events_screen.dart'
    as _i15;
import 'package:front/features/user/presentation/pages/forget_password_mail_screen.dart'
    as _i2;
import 'package:front/features/user/presentation/pages/home_screen.dart'
    as _i16;
import 'package:front/features/user/presentation/pages/login_screen.dart'
    as _i3;
import 'package:front/features/user/presentation/pages/main_screen.dart'
    as _i17;
import 'package:front/features/user/presentation/pages/otp_password.dart'
    as _i5;
import 'package:front/features/user/presentation/pages/otp_verify.dart' as _i12;
import 'package:front/features/user/presentation/pages/parkings_screen.dart'
    as _i18;
import 'package:front/features/user/presentation/pages/reset_password_screen.dart'
    as _i6;
import 'package:front/features/user/presentation/pages/settings_screen.dart'
    as _i7;
import 'package:front/features/user/presentation/pages/signup.dart' as _i8;
import 'package:front/features/user/presentation/pages/splash_screen.dart'
    as _i9;
import 'package:front/features/user/presentation/pages/update_profile_screen.dart'
    as _i10;
import 'package:front/features/user/presentation/pages/user_management_screen.dart'
    as _i11;
import 'package:front/features/user/presentation/pages/welcome_screen.dart'
    as _i13;

abstract class $AppRouter extends _i19.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    BillingDetailsRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BillingDetailsScreen(),
      );
    },
    ForgetPasswordMailRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ForgetPasswordMailScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    ParkingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ParkingDetailsRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ParkingDetailsScreen(
          key: args.key,
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
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PasswordOtpScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ResetPasswordScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    SettingRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SettingScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SplashScreen(),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UpdateProfileScreen(),
      );
    },
    UserManagementRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.UserManagementScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.WelcomeScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.accountScreen(),
      );
    },
    EventRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.eventScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.homeScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.mainScreen(),
      );
    },
    ParkingsRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.parkingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BillingDetailsScreen]
class BillingDetailsRoute extends _i19.PageRouteInfo<void> {
  const BillingDetailsRoute({List<_i19.PageRouteInfo>? children})
      : super(
          BillingDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingDetailsRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ForgetPasswordMailScreen]
class ForgetPasswordMailRoute extends _i19.PageRouteInfo<void> {
  const ForgetPasswordMailRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ForgetPasswordMailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordMailRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i19.PageRouteInfo<void> {
  const LoginRoute({List<_i19.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ParkingDetailsScreen]
class ParkingDetailsRoute extends _i19.PageRouteInfo<ParkingDetailsRouteArgs> {
  ParkingDetailsRoute({
    _i20.Key? key,
    required String parkingName,
    required String capacity,
    required String description,
    required String location,
    required String phoneContact,
    required String mailContact,
    required String adress,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ParkingDetailsRoute.name,
          args: ParkingDetailsRouteArgs(
            key: key,
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

  static const _i19.PageInfo<ParkingDetailsRouteArgs> page =
      _i19.PageInfo<ParkingDetailsRouteArgs>(name);
}

class ParkingDetailsRouteArgs {
  const ParkingDetailsRouteArgs({
    this.key,
    required this.parkingName,
    required this.capacity,
    required this.description,
    required this.location,
    required this.phoneContact,
    required this.mailContact,
    required this.adress,
  });

  final _i20.Key? key;

  final String parkingName;

  final String capacity;

  final String description;

  final String location;

  final String phoneContact;

  final String mailContact;

  final String adress;

  @override
  String toString() {
    return 'ParkingDetailsRouteArgs{key: $key, parkingName: $parkingName, capacity: $capacity, description: $description, location: $location, phoneContact: $phoneContact, mailContact: $mailContact, adress: $adress}';
  }
}

/// generated route for
/// [_i5.PasswordOtpScreen]
class PasswordOtpRoute extends _i19.PageRouteInfo<PasswordOtpRouteArgs> {
  PasswordOtpRoute({
    _i20.Key? key,
    required String email,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          PasswordOtpRoute.name,
          args: PasswordOtpRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordOtpRoute';

  static const _i19.PageInfo<PasswordOtpRouteArgs> page =
      _i19.PageInfo<PasswordOtpRouteArgs>(name);
}

class PasswordOtpRouteArgs {
  const PasswordOtpRouteArgs({
    this.key,
    required this.email,
  });

  final _i20.Key? key;

  final String email;

  @override
  String toString() {
    return 'PasswordOtpRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i6.ResetPasswordScreen]
class ResetPasswordRoute extends _i19.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i20.Key? key,
    required String email,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i19.PageInfo<ResetPasswordRouteArgs> page =
      _i19.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i20.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i7.SettingScreen]
class SettingRoute extends _i19.PageRouteInfo<void> {
  const SettingRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SignupScreen]
class SignupRoute extends _i19.PageRouteInfo<void> {
  const SignupRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i10.UpdateProfileScreen]
class UpdateProfileRoute extends _i19.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i19.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UserManagementScreen]
class UserManagementRoute extends _i19.PageRouteInfo<void> {
  const UserManagementRoute({List<_i19.PageRouteInfo>? children})
      : super(
          UserManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i12.VerifyOtpScreen]
class VerifyOtpRoute extends _i19.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i20.Key? key,
    required String email,
    required dynamic json,
    List<_i19.PageRouteInfo>? children,
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

  static const _i19.PageInfo<VerifyOtpRouteArgs> page =
      _i19.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i20.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i13.WelcomeScreen]
class WelcomeRoute extends _i19.PageRouteInfo<void> {
  const WelcomeRoute({List<_i19.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i14.accountScreen]
class AccountRoute extends _i19.PageRouteInfo<void> {
  const AccountRoute({List<_i19.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i15.eventScreen]
class EventRoute extends _i19.PageRouteInfo<void> {
  const EventRoute({List<_i19.PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i16.homeScreen]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute({List<_i19.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i17.mainScreen]
class MainRoute extends _i19.PageRouteInfo<void> {
  const MainRoute({List<_i19.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i18.parkingsScreen]
class ParkingsRoute extends _i19.PageRouteInfo<void> {
  const ParkingsRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ParkingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParkingsRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}
