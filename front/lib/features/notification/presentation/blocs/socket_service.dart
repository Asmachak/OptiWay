import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:front/features/user/data/data_sources/local_data_source.dart';

class SocketService {
  late IO.Socket _socket;

  final List<Map<String, String>> notifications = [];

  void connectToSocket(void Function(Map<String, String>) onNewNotification) {
    final userId = GetIt.instance.get<AuthLocalDataSource>().currentUser?.id;

    if (userId != null) {
      _socket = IO.io('http://10.0.2.2:8000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'reconnection': true,
        'reconnectionAttempts': 5,
        'reconnectionDelay': 2000,
        'auth': {
          'userId': userId,
        },
      });

      _socket.connect();

      _socket.onConnect((_) {
        print('Connected to the server');
      });

      _socket.on('new_notification', (data) {
        final Map<String, String> notification = {
          'title': data['title'],
          'description': data['description'],
        };
        onNewNotification(notification);
      });

      _socket.onDisconnect((_) {
        print('Disconnected from the server');
      });

      _socket.onReconnectAttempt((attempt) {
        print('Attempting to reconnect: $attempt');
      });
    } else {
      print('User ID is null, unable to connect to socket.');
    }
  }

  void disconnectSocket() {
    _socket.disconnect();
  }

  void disposeSocket() {
    _socket.dispose();
  }
}
