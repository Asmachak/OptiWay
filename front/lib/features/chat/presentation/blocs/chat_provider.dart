import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final List<String> _messages = [];

  List<String> get messages => _messages;

  void addMessage(String message) {
    if (message.isNotEmpty) {
      _messages.add(message);
      notifyListeners();
    }
  }
}
