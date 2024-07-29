import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';
part 'reservationParking_state.freezed.dart';

@freezed
abstract class ReservationParkingState with _$ReservationParkingState {
  const factory ReservationParkingState.initial() = Initial;
  const factory ReservationParkingState.loading() = Loading;
  const factory ReservationParkingState.loaded(
      {required List<ReservationParkingModel> reservations}) = Loaded;
  const factory ReservationParkingState.failure(AppException exception) = Failure;
  const factory ReservationParkingState.success(
      {required ReservationParkingModel reservation}) = Success;
  const factory ReservationParkingState.extended(
      {required ReservationParkingModel reservation}) = Extended;
}
