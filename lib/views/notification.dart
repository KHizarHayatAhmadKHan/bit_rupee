import 'package:bit_rupee/views/Send_money.dart';
import 'package:flutter/material.dart';

import 'NotificationDetailPage.dart';

class NotificationPage extends StatelessWidget {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.wallet, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: NotificationCenter.notifications.length,
        itemBuilder: (context, index) {
          final notification = NotificationCenter.notifications[index];
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
                title: Text(notification.title),
                subtitle: Text(notification.message),
                trailing: Text(notification.timestamp.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NotificationDetailPage(notification: notification),
                    ),
                  );
                },
              ));
        },
      ),
    );
  }
}
