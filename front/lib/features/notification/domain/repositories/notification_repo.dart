import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/notification/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<AppException, List<NotificationModel>>> getNotifications({
    required String iduser,
  });
}
