import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/entities/vehicule_entity.dart';

part 'vehicule_state.freezed.dart';

@freezed
abstract class VehiculeState with _$VehiculeState {
  const factory VehiculeState.initial() = Initial;
  const factory VehiculeState.loading() = Loading;
  const factory VehiculeState.failure(AppException exception) = Failure;
  const factory VehiculeState.success({required VehiculeEntity vehicule}) =
      Success;
}
