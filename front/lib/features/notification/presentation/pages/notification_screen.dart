import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://10.0.2.2:8000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to socket');
    });

    socket.on('notification', (data) {
      print('New notification: $data');
      // Handle the notification (e.g., show a dialog or update the UI)
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket');
    });
  }
}

class NotificationScreen extends StatelessWidget {
  final NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    notificationService.connect();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification System'),
      ),
      body: Center(
        child: Text('Waiting for notifications...'),
      ),
    );
  }
}
