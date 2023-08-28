import 'package:bit_rupee/views/Send_money.dart';
import 'package:flutter/material.dart';

import 'NotificationDetailPage.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _formatTime(DateTime time, BuildContext context) {
    final formattedTime = TimeOfDay.fromDateTime(time).format(context);
    return formattedTime;
  }

  Set<int> openedNotifications = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: NotificationCenter.notifications.length,
        itemBuilder: (context, index) {
          final notification = NotificationCenter.notifications[index];
          final isNotificationOpened = openedNotifications.contains(index);
          return Dismissible(
            key: Key(notification.timestamp.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              NotificationCenter.removeNotification(index);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              leading: Icon(
                isNotificationOpened
                    ? Icons.notifications
                    : Icons.notifications_active,
                color: isNotificationOpened ? Colors.black : Colors.green,
              ),
              title: Text(notification.title),
              subtitle: Text(notification.message),
              trailing: Text(
                _formatTime(notification.timestamp, context),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                if (!isNotificationOpened) {
                  setState(() {
                    openedNotifications.add(index);
                  });
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailPage(notification: notification),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
