import 'package:flutter/material.dart';
import 'Send_money.dart';

class NotificationDetailPage extends StatefulWidget {
  final NotificationData notification;

  const NotificationDetailPage({Key? key, required this.notification})
      : super(key: key);

  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  bool showCircle = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 90), () {
      setState(() {
        showCircle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification Detail",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.notification.message,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            if (showCircle) AnimatedCircle(),
          ],
        ),
      ),
    );
  }
}

class AnimatedCircle extends StatefulWidget {
  @override
  _AnimatedCircleState createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle> {
  double circleSize = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        circleSize = 150; // Adjust the size as needed
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: const Color.fromARGB(255, 85, 209, 89),
          width: 6,
        ),
      ),
    );
  }
}
