import 'package:bit_rupee/views/Wallet.dart';
import 'package:bit_rupee/views/notification.dart';
import 'package:bit_rupee/views/QR.dart';
import 'package:bit_rupee/views/settings.dart';
import 'package:flutter/material.dart';
import 'Send_money.dart';
import 'explore.dart';

class landingpage extends StatefulWidget {
  final int id;
  final String walletaddress;
  final int balance;

  landingpage({
    required this.id,
    required this.walletaddress,
    required this.balance,
  });

  @override
  State<landingpage> createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      Wallet(
          id: widget.id,
          walletaddress: widget.walletaddress,
          balance: widget.balance),
      explore(),
      QRScreen(
        id: widget.id,
      ),
      NotificationPage(),
      settings(
        id: widget.id,
        walletaddress: widget.walletaddress,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavBarItem(Icons.account_balance_wallet_rounded, 'Wallet', 0),
            buildNavBarItem(Icons.explore_rounded, 'Explore', 1),
            buildNavBarItem(Icons.qr_code, 'QR', 2),
            buildNavBarItem(Icons.notifications_active, 'Notification', 3),
            buildNavBarItem(Icons.settings, 'Settings', 4),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData iconData, String title, int index) {
    final isSelected = _currentIndex == index;
    int notificationCount = NotificationCenter.notifications.length;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Stack(
          children: [
            Icon(
              iconData,
              size: 30,
              color: isSelected ? Colors.blue : Colors.black,
            ),
            if (index == 3 &&
                notificationCount >
                    0) // Show badge only for "Notification" icon
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$notificationCount',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
