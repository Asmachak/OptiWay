import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/notification/domain/use_cases/delete_notification_use_case.dart';
import 'package:front/features/notification/presentation/blocs/state/notification_delete/delete_notification_state.dart';

class DeleteNotificationNotifier
    extends StateNotifier<DeleteNotificationState> {
  final DeleteNotificationsUseCases _notificationUseCases;

  DeleteNotificationNotifier(this._notificationUseCases)
      : super(const DeleteNotificationState.initial());

  Future<void> deleteNotifications(String id) async {
    state = const DeleteNotificationState.loading();
    final result = await _notificationUseCases.deleteNotificationsUsecases
        .call(DeleteNotificationsParams(id: id));
    return result.fold(
      (failure) {
        state = DeleteNotificationState.failure(failure);
      },
      (notifications) {
        state = DeleteNotificationState.deleted();
      },
    );
  }
}
