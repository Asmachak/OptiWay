import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  final String roomId =
      'room123'; // Example room ID, this should be unique per conversation
  final String userId = GetIt.instance
      .get<AuthLocalDataSource>()
      .currentUser!
      .id!; // Replace with a dynamic user ID based on your app logic

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io('http://10.0.2.2:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('connected');
      // Register the user on the server
      socket.emit('register_user', userId);
      // Join the user to the private room
      joinOrCreateRoom(roomId);
    });

    socket.on('load_messages', (data) {
      setState(() {
        messages = List<String>.from(data.map((message) => message['message']));
      });
    });

    socket.on('receive_message', (data) {
      setState(() {
        messages.add(data['message']);
      });
    });

    socket.onDisconnect((_) => print('disconnected'));
  }

  void joinOrCreateRoom(String roomId) {
    socket.emit('create_or_join_room', {
      'roomId': roomId,
      'userId': userId,
    });
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      socket.emit('send_message', {
        'roomId': roomId,
        'senderId': userId,
        'message': messageController.text,
      });
      setState(() {
        messages.add(messageController.text);
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
