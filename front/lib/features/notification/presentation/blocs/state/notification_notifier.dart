import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/notification/domain/use_cases/get_notification_use_case.dart';
import 'package:front/features/notification/domain/use_cases/notification_use_cases.dart';
import 'package:front/features/notification/presentation/blocs/state/notification_state.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationUseCases _notificationUseCases;

  NotificationNotifier(this._notificationUseCases)
      : super(const NotificationState.initial());

  Future<void> getNotifications(String iduser) async {
    state = const NotificationState.loading();
    final result = await _notificationUseCases.getNotificationsUsecases
        .call(GetNotificationsParams(iduser: iduser));
    return result.fold(
      (failure) {
        state = NotificationState.failure(failure);
      },
      (notifications) {
        state = NotificationState.loaded(notifications: notifications);
      },
    );
  }
}
