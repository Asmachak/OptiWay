import 'package:front/features/notification/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<void> sendNotification(NotificationModel notification);
}
