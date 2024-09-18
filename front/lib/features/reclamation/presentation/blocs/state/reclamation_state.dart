import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';

part 'reclamation_state.freezed.dart';

@freezed
abstract class ReclamationState with _$ReclamationState {
  const factory ReclamationState.initial() = Initial;
  const factory ReclamationState.loading() = Loading;
  const factory ReclamationState.failure(AppException exception) = Failure;
  const factory ReclamationState.success(
      {required ReclamationModel reclamation}) = Success;
}
