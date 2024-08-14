import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/notification/domain/providers/provider.dart';
import 'package:front/features/notification/domain/use_cases/notification_use_cases.dart';
import 'package:front/features/notification/presentation/blocs/state/notification_notifier.dart';
import 'package:front/features/notification/presentation/blocs/state/notification_state.dart';

final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final getNotificationsUseCases = ref.read(getNotificationsUseCaseProvider);

  final notificationUseCases = NotificationUseCases(
    getNotificationsUsecases: getNotificationsUseCases,
  );

  return NotificationNotifier(notificationUseCases);
});
