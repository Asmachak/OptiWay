import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'delete_notification_state.freezed.dart';

@freezed
abstract class DeleteNotificationState with _$DeleteNotificationState {
  const factory DeleteNotificationState.initial() = Initial;
  const factory DeleteNotificationState.loading() = Loading;
  const factory DeleteNotificationState.failure(AppException exception) = Failure;
  const factory DeleteNotificationState.deleted() = Deleted;
}
