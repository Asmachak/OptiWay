import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/notification/domain/repositories/notification_repo.dart';
import 'package:front/shared/use_case.dart';

class DeleteNotificationsUsecases
    implements UseCase<String, DeleteNotificationsParams> {
  final NotificationRepository notificationRepository;

  DeleteNotificationsUsecases(this.notificationRepository);
  @override
  Future<Either<AppException, String>> call(
      DeleteNotificationsParams params) async {
    return await notificationRepository.deleteNotification(id: params.id);
  }
}

class DeleteNotificationsParams<T> {
  final String id;
  DeleteNotificationsParams({
    required this.id,
  });
}

class DeleteNotificationsUseCases {
  final DeleteNotificationsUsecases deleteNotificationsUsecases;

  DeleteNotificationsUseCases({required this.deleteNotificationsUsecases});
}
