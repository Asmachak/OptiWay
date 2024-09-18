import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'admin_otp_state.freezed.dart';

@freezed
abstract class AdminOtpState with _$AdminOtpState {
  const factory AdminOtpState.initial() = Initial;
  const factory AdminOtpState.loading() = Loading;
  const factory AdminOtpState.failure(AppException exception) = Failure;
  const factory AdminOtpState.verified() = Verified;
  const factory AdminOtpState.received() = Received;
  const factory AdminOtpState.success() = Success;
}
