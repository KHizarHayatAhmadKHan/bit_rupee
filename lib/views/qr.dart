import 'package:flutter/material.dart';

class qr extends StatefulWidget {
  const qr({super.key});

  @override
  State<qr> createState() => _qrState();
}

class _qrState extends State<qr> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child: Icon(Icons.qr_code),
      ),
    );
  }
}