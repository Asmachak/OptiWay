import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
part 'cancel_reservation_state.freezed.dart';

@freezed
abstract class CancelReservationState with _$CancelReservationState {
  const factory CancelReservationState.initial() = Initial;
  const factory CancelReservationState.loading() = Loading;
  const factory CancelReservationState.failure(AppException exception) =
      Failure;
  const factory CancelReservationState.canceled() = Canceled;
}
