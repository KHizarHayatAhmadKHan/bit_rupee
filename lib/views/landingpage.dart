import 'package:bit_rupee/views/Wallet.dart';
import 'package:bit_rupee/views/notification.dart';
import 'package:bit_rupee/views/QR.dart';
// import 'package:bit_rupee/views/qr.dart';
import 'package:bit_rupee/views/setting.dart';
import 'package:flutter/material.dart';

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
  late List<Widget> _screens; // Declare the _screens list

  @override
  void initState() {
    super.initState();
    // Initialize the _screens list in the initState where you have access to widget properties
    _screens = [
      Wallet(
          id: widget.id,
          walletaddress: widget.walletaddress,
          balance: widget.balance),
      explore(),
      QRScreen(
        id: widget.id,
      ),
      notification(),
      setting(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
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
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            Icon(iconData,
                size: 30, color: isSelected ? Colors.green : Colors.black),
            // SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
