import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
part 'delete_organiser_state.freezed.dart';

@freezed
abstract class DeleteOrganiserState with _$DeleteOrganiserState {
  const factory DeleteOrganiserState.initial() = Initial;
  const factory DeleteOrganiserState.loading() = Loading;
  const factory DeleteOrganiserState.failure(AppException exception) = Failure;
  const factory DeleteOrganiserState.deleted(String msg) = Deleted;
}
