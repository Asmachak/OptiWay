import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/notification/data/models/notification_model.dart';
import 'package:front/features/notification/domain/repositories/notification_repo.dart';
import 'package:front/shared/use_case.dart';

class GetNotificationsUsecases
    implements UseCase<List<NotificationModel>, GetNotificationsParams> {
  final NotificationRepository notificationRepository;

  GetNotificationsUsecases(this.notificationRepository);
  @override
  Future<Either<AppException, List<NotificationModel>>> call(
      GetNotificationsParams params) async {
    return await notificationRepository.getNotifications(iduser: params.iduser);
  }
}

class GetNotificationsParams<T> {
  final String iduser;
  GetNotificationsParams({
    required this.iduser,
  });
}
