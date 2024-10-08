import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/otp_use_cases.dart';
import 'package:front/features/user/presentation/blocs/state/otp/otp_notifier.dart';
import 'package:front/features/user/presentation/blocs/state/otp/otp_state.dart';

final otpNotifierProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  final loginOtpUseCase = ref.read(loginOtpUseCaseProvider);
  final verifyOtpUseCase = ref.read(verifyOtpUseCaseProvider);

  // final editProfileUseCases = ref.read(editProfileUseCaseProvider);
  // final updatePasswordUseCases = ref.read(updatePasswordUseCaseProvider);

  final authUseCases = OtpUseCases(
      loginOtpUseCase: loginOtpUseCase, verifyOtpUseCase: verifyOtpUseCase);
  // final hiveBox = ref.watch(hiveBoxProvider);
  return OtpNotifier(authUseCases);
});
