import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/features/reservation/domain/entities/reservation_entity.dart';

part 'reservation_state.freezed.dart';

@freezed
abstract class ReservationState with _$ReservationState {
  const factory ReservationState.initial() = Initial;
  const factory ReservationState.loading() = Loading;
  const factory ReservationState.failure(AppException exception) = Failure;
  const factory ReservationState.success({required ReservationModel reservation}) =
      Success;
}
