import 'package:bit_rupee/views/QRScannerScreen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class qr extends StatelessWidget {
  final String userId;
  final String baseUrl;
  const qr({super.key, required this.userId, required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Send/ Recieve Money",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.wallet, color: Colors.grey),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color.fromARGB(255, 248, 250, 248),
        centerTitle: true,
      ),
      // backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Please Scan the code to Send Money',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 85, 209, 89)),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: QrImageView(
                data: baseUrl,
                backgroundColor: Color.fromARGB(255, 223, 221, 221),
                size: 200.0),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRScannerScreen(baseUrl),
                  ),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 85, 209, 89)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ))),
              child: const Text(
                'Send Money',
                style: TextStyle(
                  color: Color.fromARGB(255, 251, 253, 252),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text('Your ID: $userId'),
        ],
      ),
    );
  }
}


// class _QRCodeScreenState extends State<qr> {
  
//   String data = "";
//   // TextEditingController _userIdController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Send/ Recieve Money",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.wallet, color: Colors.grey),
//             onPressed: () {},
//           ),
//         ],
//         backgroundColor: Color.fromARGB(255, 248, 250, 248),
//         centerTitle: true,
//       ),
//       // backgroundColor: Colors.grey[300],
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Please Scan the code to Send Money',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w400,
//                 color: Color.fromARGB(255, 85, 209, 89)),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Center(
//             child: QrImageView(
//                 data: userId,
//                 backgroundColor: Color.fromARGB(255, 223, 221, 221),
//                 size: 200.0),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           SizedBox(
//             width: 300,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 85, 209, 89)),
//                   padding: MaterialStateProperty.all<EdgeInsets>(
//                       const EdgeInsets.all(20)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ))),
//               child: const Text(
//                 'Send Money',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 251, 253, 252),
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
