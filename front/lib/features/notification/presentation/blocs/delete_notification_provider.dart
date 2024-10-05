import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/notification/domain/providers/provider.dart';
import 'package:front/features/notification/domain/use_cases/delete_notification_use_case.dart';
import 'package:front/features/notification/presentation/blocs/state/notification_delete/delete_notification_notifier.dart';
import 'package:front/features/notification/presentation/blocs/state/notification_delete/delete_notification_state.dart';

final deleteNotificationNotifierProvider =
    StateNotifierProvider<DeleteNotificationNotifier, DeleteNotificationState>(
        (ref) {
  final deleteNotificationsUseCases =
      ref.read(deleteNotificationsUseCaseProvider);

  final notificationUseCases = DeleteNotificationsUseCases(
    deleteNotificationsUsecases: deleteNotificationsUseCases,
  );

  return DeleteNotificationNotifier(notificationUseCases);
});
