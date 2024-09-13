import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservationOrganiser/reservation_organiser_model.dart';
part 'reservationOrganiser_state.freezed.dart';

@freezed
abstract class ReservationOrganiserState with _$ReservationOrganiserState {
  const factory ReservationOrganiserState.initial() = Initial;
  const factory ReservationOrganiserState.loading() = Loading;
  const factory ReservationOrganiserState.loaded(
      {required List<ReservationOrganiserModel> reservations}) = Loaded;
  const factory ReservationOrganiserState.failure(AppException exception) =
      Failure;
}
