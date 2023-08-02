import 'dart:html';

import 'package:bit_rupee/views/Wallet.dart';
import 'package:bit_rupee/views/notification.dart';
import 'package:bit_rupee/views/qr.dart';
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

  final List<Widget> _screens = [
      // Wallet(id: id, walletaddress: walletaddress, balance: balance),
    explore(),
    explore(),
    qr(),
    notification(),
    setting(),
  ];
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Bottom Navigation Bar'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavBarItem(Icons.account_balance_wallet_rounded, 'Screen 1', 0),
            buildNavBarItem(Icons.explore_rounded, 'Screen 2', 1),
            buildNavBarItem(Icons.qr_code, 'Screen 3', 2),
            buildNavBarItem(Icons.notifications_active, 'Screen 4', 3),
            buildNavBarItem(Icons.settings, 'Screen 5', 4),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData iconData, String title, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.blue : Colors.grey;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueGrey[200] : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(iconData, color: color),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
