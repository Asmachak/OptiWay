import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'otp_state.freezed.dart';

@freezed
abstract class OrganiserOtpState with _$OrganiserOtpState {
  const factory OrganiserOtpState.initial() = Initial;
  const factory OrganiserOtpState.loading() = Loading;
  const factory OrganiserOtpState.failure(AppException exception) = Failure;
  const factory OrganiserOtpState.verified() = Verified;
  const factory OrganiserOtpState.received() = Received;
  const factory OrganiserOtpState.success() = Success;
}
