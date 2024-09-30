import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/notification/presentation/blocs/notification_provider.dart';
import 'package:front/features/notification/presentation/blocs/socket_service.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NotificationPage extends ConsumerStatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage>
    with WidgetsBindingObserver {
  final SocketService _socketService = SocketService();
  var iduser = GetIt.instance.get<AuthLocalDataSource>().currentUser?.id;
  bool _notificationsEnabled = true; // Add this to track notifications state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _socketService.connectToSocket(_handleNewNotification);

    // Delay the modification to after the widget tree is built
    Future.microtask(() {
      ref.read(notificationNotifierProvider.notifier).getNotifications(iduser!);
    });
  }

  void _handleNewNotification(Map<String, String> notification) {
    // Refresh the notifications list from the database
    if (_notificationsEnabled) {
      ref.read(notificationNotifierProvider.notifier).getNotifications(iduser!);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _socketService.disposeSocket();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _socketService.disconnectSocket();
    } else if (state == AppLifecycleState.resumed) {
      _socketService.connectToSocket(_handleNewNotification);
    }
  }

  // Add function to delete notifications
  void _deleteNotification(String notificationId) {
    // ref
    //     .read(notificationNotifierProvider.notifier)
    //     .deleteNotification(notificationId, iduser!);
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Switch(
            activeColor: Colors.green,
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
                if (!_notificationsEnabled) {
                  _socketService.disconnectSocket();
                } else {
                  _socketService.connectToSocket(_handleNewNotification);
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_notificationsEnabled ? 'On' : 'Off'),
          ),
        ],
      ),
      body: notificationState.when(
        initial: () => const Center(child: Text('No notifications yet')),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (notifications) {
          final modifiableNotifications = List.from(notifications);

          // Sort notifications by createdAt (newest first)
          modifiableNotifications.sort((a, b) {
            final DateTime dateA = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parse(a.createdAt, true)
                .toLocal();
            final DateTime dateB = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parse(b.createdAt, true)
                .toLocal();
            return dateB.compareTo(dateA);
          });

          return ListView.builder(
            itemCount: modifiableNotifications.length,
            itemBuilder: (context, index) {
              final notification = modifiableNotifications[index];
              final bool isHighlighted =
                  index == 0; // Highlight the newest notification

              // Format the createdAt date/time
              final String timeAgo = _formatTimeAgo(notification.createdAt);

              return Column(
                children: [
                  Container(
                    color: isHighlighted
                        ? Colors.blue[50]
                        : Colors
                            .transparent, // Blue background for the highlighted notification
                    child: ListTile(
                      title: Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: isHighlighted
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification.description),
                          Text(
                            timeAgo,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isHighlighted)
                            const Icon(Icons.info, color: Colors.blue),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deleteNotification(notification.id),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index < modifiableNotifications.length - 1)
                    const Divider(), // Add a divider between notifications
                ],
              );
            },
          );
        },
        failure: (exception) =>
            Center(child: Text('Error: ${exception.message}')),
        success: () => const Center(child: Text('Operation Successful')),
      ),
    );
  }

  // Helper method to format the createdAt date/time to a 'time ago' format
  String _formatTimeAgo(String createdAtString) {
    final DateTime createdAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
        .parse(createdAtString, true)
        .toLocal();
    final Duration difference = DateTime.now().difference(createdAt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return DateFormat('yMMMd').format(createdAt); // e.g., Aug 10, 2023
    }
  }
}
