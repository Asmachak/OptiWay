// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:front/features/user/presentation/pages/account_screen.dart'
    as _i10;
import 'package:front/features/user/presentation/pages/billing_details_screen.dart'
    as _i1;
import 'package:front/features/user/presentation/pages/events_screen.dart'
    as _i11;
import 'package:front/features/user/presentation/pages/home_screen.dart'
    as _i12;
import 'package:front/features/user/presentation/pages/login_screen.dart'
    as _i2;
import 'package:front/features/user/presentation/pages/main_screen.dart'
    as _i13;
import 'package:front/features/user/presentation/pages/otp_verify.dart' as _i8;
import 'package:front/features/user/presentation/pages/parkings_screen.dart'
    as _i14;
import 'package:front/features/user/presentation/pages/settings_screen.dart'
    as _i3;
import 'package:front/features/user/presentation/pages/signup.dart' as _i4;
import 'package:front/features/user/presentation/pages/splash_screen.dart'
    as _i5;
import 'package:front/features/user/presentation/pages/update_profile_screen.dart'
    as _i6;
import 'package:front/features/user/presentation/pages/user_management_screen.dart'
    as _i7;
import 'package:front/features/user/presentation/pages/welcome_screen.dart'
    as _i9;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    BillingDetailsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BillingDetailsScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SplashScreen(),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.UpdateProfileScreen(),
      );
    },
    UserManagementRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.UserManagementScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          json: args.json,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.WelcomeScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.accountScreen(),
      );
    },
    EventRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.eventScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.homeScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.mainScreen(),
      );
    },
    ParkingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.parkingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BillingDetailsScreen]
class BillingDetailsRoute extends _i15.PageRouteInfo<void> {
  const BillingDetailsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          BillingDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BillingDetailsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingScreen]
class SettingRoute extends _i15.PageRouteInfo<void> {
  const SettingRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignupScreen]
class SignupRoute extends _i15.PageRouteInfo<void> {
  const SignupRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SplashScreen]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.UpdateProfileScreen]
class UpdateProfileRoute extends _i15.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UpdateProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.UserManagementScreen]
class UserManagementRoute extends _i15.PageRouteInfo<void> {
  const UserManagementRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.VerifyOtpScreen]
class VerifyOtpRoute extends _i15.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i16.Key? key,
    required String email,
    required dynamic json,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<VerifyOtpRouteArgs> page =
      _i15.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    required this.json,
  });

  final _i16.Key? key;

  final String email;

  final dynamic json;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, json: $json}';
  }
}

/// generated route for
/// [_i9.WelcomeScreen]
class WelcomeRoute extends _i15.PageRouteInfo<void> {
  const WelcomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.accountScreen]
class AccountRoute extends _i15.PageRouteInfo<void> {
  const AccountRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.eventScreen]
class EventRoute extends _i15.PageRouteInfo<void> {
  const EventRoute({List<_i15.PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.homeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.mainScreen]
class MainRoute extends _i15.PageRouteInfo<void> {
  const MainRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.parkingsScreen]
class ParkingsRoute extends _i15.PageRouteInfo<void> {
  const ParkingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ParkingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParkingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
