import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';

part 'vehicule_list_state.freezed.dart';

@freezed
abstract class VehiculeListState with _$VehiculeListState {
  const factory VehiculeListState.initial() = Initial;
  const factory VehiculeListState.loading() = Loading;
  const factory VehiculeListState.loaded(
      {required List<VehiculeModel> vehicules}) = VehiculeLoaded;
  const factory VehiculeListState.failure(AppException exception) = Failure;
}
