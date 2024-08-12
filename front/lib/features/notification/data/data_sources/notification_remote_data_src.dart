import 'package:front/features/notification/data/models/notification_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class NotificationRemoteDataSource {
  Future<void> sendNotification(NotificationModel notification);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Socket socket;

  NotificationRemoteDataSourceImpl(this.socket);

  @override
  Future<void> sendNotification(NotificationModel notification) async {
    socket.emit('notification', {
      'title': notification.title,
      'message': notification.description,
      'time': notification.createdAt,
    });
  }
}


