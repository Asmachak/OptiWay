import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/notification/data/data_sources/notification_remote_data_src.dart';
import 'package:front/features/notification/data/models/notification_model.dart';
import 'package:front/features/notification/domain/repositories/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;

  NotificationRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, List<NotificationModel>>> getNotifications({
    required String iduser,
  }) {
    return remoteDataSource.getNotifications(userid: iduser);
  }

  @override
  Future<Either<AppException, String>> deleteNotification({
    required String id,
  }) {
    return remoteDataSource.deleteNotification(id: id);
  }
}
