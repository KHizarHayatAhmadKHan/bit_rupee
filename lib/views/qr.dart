import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:bit_rupee/config/Config.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
  final int id;
  QRScreen({required this.id});
  String get baseUrl => '${Config.backendEndpoint}/wutxo/$id';
}

class _QRScreenState extends State<QRScreen> {
  QRViewController? scannerController;
  bool isScanning = false;

  String get qrData => 'QR Code Data';

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send/ Recieve Money",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.wallet, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
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
            if (!isScanning)
              QrImageView(
                data: widget.baseUrl,
                key: qrKey,
                backgroundColor: Colors.white,
                size: 200.0,
              )
            else
              Container(
                width: 300,
                height: 300,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (controller) {
                    setState(() {
                      scannerController = controller;
                    });

                    controller.scannedDataStream.listen((scanData) {
                      if (isScanning) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('QR Code Scanned'),
                            content: Text('Data: ${scanData.code}'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isScanning = !isScanning;
                  if (isScanning) {
                    scannerController?.resumeCamera();
                  } else {
                    scannerController?.pauseCamera();
                  }
                });
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
              child: Text(
                isScanning ? 'Go back' : 'Send Money',
                style: TextStyle(
                  color: Color.fromARGB(255, 241, 245, 241),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
