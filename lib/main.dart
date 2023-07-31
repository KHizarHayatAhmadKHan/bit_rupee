import 'package:bit_rupee/views/Login_page.dart';
import 'package:bit_rupee/views/Send_money.dart';
import 'package:bit_rupee/views/Wallet.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Route generator function
  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case '/wallet':
        final Map<String, dynamic>? arguments =
            settings.arguments as Map<String, dynamic>?;

        if (arguments != null &&
            arguments.containsKey('id') &&
            arguments.containsKey('walletaddress') &&
            arguments.containsKey('balance')) {
          return MaterialPageRoute(
            builder: (context) => Wallet(
              id: arguments['id'],
              walletaddress: arguments['walletaddress'],
              balance: arguments['balance'],
            ),
          );
        }
        // Handle invalid arguments or missing data
        return MaterialPageRoute(
          builder: (context) => LoginPage(), // Navigate back to login page or show an error page
        );
      case '/sendmoney':
        return MaterialPageRoute(
          builder: (context) => send_money(),
        );
      default:
        // Handle unknown routes
        return MaterialPageRoute(
          builder: (context) => LoginPage(), // Navigate back to login page or show an error page
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _onGenerateRoute, // Use the single route generator function
    );
  }
}
