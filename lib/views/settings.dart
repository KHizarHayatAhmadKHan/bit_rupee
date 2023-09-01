import 'package:bit_rupee/views/settings_page.dart';
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
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildListTile(
            Icons.person,
            'Your Profile',
            () {
              Navigator.pushNamed(context, '/Profile', arguments: {
                'id': widget.id,
                'walletaddress': widget.walletaddress,
              });
            },
          ),
          buildListTile(
            Icons.settings,
            'Settings',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          buildListTile(
            Icons.logout,
            'Logout',
            logoutUser,
          ),
        ],
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, VoidCallback onPressed) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
