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
            icon: const Icon(Icons.more_vert, ),
            onPressed: () {},
          ),
        ],
        
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/profile_picture.jpg"),
            ),
            SizedBox(height: 20),
            Text(
              "XYZ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "ID: $id",
              style: TextStyle(fontSize: 16, ),
            ),
            SizedBox(height: 10),
            Text(
              "Wallet Address: $walletaddress",
              style: TextStyle(fontSize: 16,),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
