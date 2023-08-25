import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatefulWidget {
  final int id;
  final String walletaddress;
  settings({
    required this.id,
    required this.walletaddress,
  });

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<settings> {
  double userid = 0.0;

  Future<void> logoutUser() async {
    // Clear user data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushNamed(context, '/LoginPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Profile', arguments: {
                      'id': widget.id,
                      'walletaddress': widget.walletaddress,
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Your Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: logoutUser,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
