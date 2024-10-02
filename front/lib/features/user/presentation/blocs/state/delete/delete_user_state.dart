import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'delete_user_state.freezed.dart';

@freezed
abstract class DeleteUserState with _$DeleteUserState {
  const factory DeleteUserState.initial() = Initial;
  const factory DeleteUserState.loading() = Loading;
  const factory DeleteUserState.failure(AppException exception) = Failure;
  const factory DeleteUserState.deleted(String msg) = Deleted;
}
