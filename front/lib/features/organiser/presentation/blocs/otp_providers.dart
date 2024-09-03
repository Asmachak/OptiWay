import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/providers/organiser_providers.dart';
import 'package:front/features/organiser/domain/use_cases/otp_use_cases.dart';
import 'package:front/features/organiser/presentation/blocs/state/otp/otp_notifier.dart';
import 'package:front/features/organiser/presentation/blocs/state/otp/otp_state.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/otp_use_cases.dart';
import 'package:front/features/user/presentation/blocs/state/otp/otp_notifier.dart';
import 'package:front/features/user/presentation/blocs/state/otp/otp_state.dart';

final otpOrganiserNotifierProvider =
    StateNotifierProvider<OrganiserOtpNotifier, OrganiserOtpState>((ref) {
  final loginOtpUseCase = ref.read(loginOtpOrganiserUseCaseProvider);
  final verifyOtpUseCase = ref.read(verifyOtpOrganiserUseCaseProvider);

  // final editProfileUseCases = ref.read(editProfileUseCaseProvider);
  // final updatePasswordUseCases = ref.read(updatePasswordUseCaseProvider);

  final authUseCases = OtpOrganiserUseCases(
      loginOtpUseCase: loginOtpUseCase, verifyOtpUseCase: verifyOtpUseCase);
  // final hiveBox = ref.watch(hiveBoxProvider);
  return OrganiserOtpNotifier(authUseCases);
});
