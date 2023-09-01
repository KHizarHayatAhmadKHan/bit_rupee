import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final int id;
  final String walletaddress;
  Profile({
    required this.id,
    required this.walletaddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/profile_picture.jpg"),
              ),
              SizedBox(height: 20),
              Text(
                "Name:   XYZ", // Display "Name: XYZ"
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Text(
                "ID:               $id", // Display "ID: {id}"
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 10),
              Text(
                "Wallet Address: $walletaddress", // Display "Wallet Address: {walletaddress}"
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
