import 'package:bit_rupee/views/Home_page.dart';
import 'package:bit_rupee/views/Login_page.dart';
import 'package:bit_rupee/views/Send_money.dart';
import 'package:bit_rupee/views/Signup_page.dart';
import 'package:bit_rupee/views/Wallet.dart';
import 'package:bit_rupee/views/landingpage.dart';
import 'package:bit_rupee/views/QR.dart';
// import 'package:bit_rupee/views/qr.dart';
import 'package:flutter/material.dart';

import 'KYC/kyc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => Home(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) => Signup(),
        );
      case '/landing':
        final Map<String, dynamic>? arguments =
            settings.arguments as Map<String, dynamic>?;

        if (arguments != null &&
            arguments.containsKey('id') &&
            arguments.containsKey('walletaddress') &&
            arguments.containsKey('balance')) {
          return MaterialPageRoute(
            builder: (context) => landingpage(
              id: arguments['id'],
              walletaddress: arguments['walletaddress'],
              balance: arguments['balance'],
            ),
          );
        }
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

        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case '/sendmoney':
        final Map<String, dynamic>? arguments =
            settings.arguments as Map<String, dynamic>?;

        if (arguments != null &&
            arguments.containsKey('id') &&
            arguments.containsKey('walletAddress')) {
          return MaterialPageRoute(
            builder: (context) => send_money(
              senderId: arguments['id'],
              walletaddress: arguments['walletAddress'],
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );

      // case '/QRScannerScreen':
      //   final Map<String, dynamic>? arguments =
      //       settings.arguments as Map<String, dynamic>?;

      //   if (arguments != null && arguments.containsKey('id')) {
      //     return MaterialPageRoute(
      //       builder: (context) => QRScannerScreen(
      //         id: arguments['id'],
      //       ),
      //     );
      //   }

      //   return MaterialPageRoute(
      //     builder: (context) => LoginPage(),
      //   );

      case '/QRScreen':
        final Map<String, dynamic>? arguments =
            settings.arguments as Map<String, dynamic>?;

        if (arguments != null && arguments.containsKey('id')) {
          return MaterialPageRoute(
            builder: (context) => QRScreen(
              id: arguments['id'],
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // color: Colors.grey,

      home: KYC_Form(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
