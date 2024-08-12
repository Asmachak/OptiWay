import 'package:front/features/notification/data/data_sources/notification_remote_data_src.dart';
import 'package:front/features/notification/data/models/notification_model.dart';
import 'package:front/features/notification/domain/repositories/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> sendNotification(NotificationModel notification) async {
    await remoteDataSource.sendNotification(notification);
  }
}
