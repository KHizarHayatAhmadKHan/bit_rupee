// import 'package:bit_rupee/views/qr.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerScreen extends StatefulWidget {
//   final int id;
//   QRScannerScreen({super.key, required this.id});

//   @override
//   _QRScannerScreenState createState() => _QRScannerScreenState();
// }

// class _QRScannerScreenState extends State<QRScannerScreen> {
//   late final String baseUrl;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   bool isScanning = true;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

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
//           Container(
//             // flex: 5,
//             width: 300,
//             height: 300,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           SizedBox(
//             width: 300,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/qr', arguments: {
//                   'id': widget.id,
//                 });
//               },
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
//                 'Go back',
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

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       if (isScanning) {
//         setState(() {
//           isScanning = false;
//         });
       
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('QR Code Scanned'),
//             content: Text('Data: ${scanData.code}'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
                
//                   setState(() {
//                     isScanning = true;
//                   });
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//     );
//   }
// }