import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'otp_state.freezed.dart';

@freezed
abstract class OtpState with _$OtpState {
  const factory OtpState.initial() = Initial;
  const factory OtpState.loading() = Loading;
  const factory OtpState.failure(AppException exception) = Failure;
  const factory OtpState.verified() = Verified;
  const factory OtpState.received() = Received;
  const factory OtpState.success() = Success;
}
