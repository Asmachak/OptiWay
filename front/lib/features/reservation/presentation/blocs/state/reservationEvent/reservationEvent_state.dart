import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_event/reservationEvent_model.dart';
part 'reservationEvent_state.freezed.dart';

@freezed
abstract class ReservationEventState with _$ReservationEventState {
  const factory ReservationEventState.initial() = Initial;
  const factory ReservationEventState.loading() = Loading;
  const factory ReservationEventState.loaded(
      {required List<ReservationEventModel> reservations}) = Loaded;
  const factory ReservationEventState.failure(AppException exception) = Failure;
  const factory ReservationEventState.success(
      {required ReservationEventModel reservation}) = Success;
  const factory ReservationEventState.extended(
      {required ReservationEventModel reservation}) = Extended;
}
