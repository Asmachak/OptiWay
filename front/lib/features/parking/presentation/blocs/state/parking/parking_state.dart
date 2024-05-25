import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/parking/data/models/parking_model.dart';

part 'parking_state.freezed.dart';

@freezed
abstract class ParkingState with _$ParkingState {
  const factory ParkingState.initial() = Initial;
  const factory ParkingState.loading() = Loading;
  const factory ParkingState.loaded({required List<ParkingModel> parkings}) =
      ParkingLoaded;
  const factory ParkingState.failure(AppException exception) = Failure;
  const factory ParkingState.success() = Success;
}
