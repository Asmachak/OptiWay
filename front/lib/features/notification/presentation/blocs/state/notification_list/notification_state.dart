import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/notification/data/models/notification_model.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = Initial;
  const factory NotificationState.loading() = Loading;
  const factory NotificationState.loaded(
      {required List<NotificationModel> notifications}) = NotificationLoaded;
  const factory NotificationState.failure(AppException exception) = Failure;
  const factory NotificationState.success() = Success;
}
