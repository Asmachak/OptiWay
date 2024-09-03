import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/domain/entities/organiser_entity.dart';
part 'edit_state.freezed.dart';

@freezed
abstract class OrganiserEditState with _$OrganiserEditState {
  const factory OrganiserEditState.initial() = Initial;
  const factory OrganiserEditState.loading() = Loading;
  const factory OrganiserEditState.failure(AppException exception) = Failure;
  const factory OrganiserEditState.success(OrganiserEntity organiser) = Success;
}
