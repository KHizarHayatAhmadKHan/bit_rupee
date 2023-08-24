import 'dart:convert';
import 'dart:io';
import 'package:bit_rupee/crypto/privateKey.dart';
import 'package:bit_rupee/crypto/publicKey.dart';
import 'package:bit_rupee/crypto/signMessage.dart';
import 'package:bit_rupee/crypto/verifySignature.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:bit_rupee/config/Config.dart';
import 'package:bit_rupee/views/test.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256r1.dart';

import '../crypto/verifyCertificate.dart';
// import 'package:asn1lib/asn1lib.dart';
// import 'dart:typed_data';
// import 'package:cryptography/cryptography.dart' as Crpto ;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String _cnic = '';
  late String _secretKey = '';
  void saveCertificateFiles(Uint8List certificateBytes, String saveDirectory) {
    final directory = Directory(saveDirectory);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final cerFile = File('${directory.path}/self_signed_certificate.cer');
    final pemFile = File('${directory.path}/self_signed_certificate.pem');

    final pemCertificate = base64.encode(certificateBytes);
    final pemString = '''-----BEGIN CERTIFICATE-----
$pemCertificate
-----END CERTIFICATE-----''';

    cerFile.writeAsBytesSync(certificateBytes);
    pemFile.writeAsStringSync(pemString);
  }

  Future<void> makeApiRequest(
      Uint8List publicKey, Uint8List signature, Uint8List messageBytes) async {
    final url =
        '${Config.backendEndpoint}/Test/${hex.encode(publicKey)}/${hex.encode(signature)}/${hex.encode(messageBytes)}';

    try {
      print('Making API request.');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // API call was successful
        final responseData = json.decode(response.body);
        print('API Response  in JAVA: $responseData');
      } else {
        // API call failed
        print('API Request failed with status code : ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during API call
      print('API Request failed with exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 85, 209, 89)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please enter your valid credentials',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Icon(
                Icons.wallet,
                size: 78,
                color: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: 'Enter CNIC',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your CNIC.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cnic = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: 'Enter Secret_key',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your secret key.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _secretKey = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Uint8List privateKey =
                          generatePrivateKey(_cnic, _secretKey);
                      print('Private Key: 0x${hex.encode(privateKey)}');
                      // generatePrivateKey2();
                      Uint8List publicKey =
                          generatePublicKey(privateKey).Q!.getEncoded(true);
                      print('Public Key: 0x${hex.encode(publicKey)}');
                      // print(
                      // 'Public Key: 0x${Uint8List.fromList(publicKey).toSet()}');
                      // print('Public Key: ${publicKey}');
                      // print('Public Key: ${publicKey.length}');
                      print('Certificate ' +
                          hex.encode(generateSelfSignedCertificate(
                              privateKey, publicKey)));
                      final certificateBytes =
                          generateSelfSignedCertificate(privateKey, publicKey);
                      final isCertificateValid =
                          verifyCertificate(certificateBytes);

                      if (isCertificateValid) {
                        print("The certificate is valid.");
                      } else {
                        print("The certificate is NOT valid.");
                      }
                      // print('Certificate ' +
                      // final certificateBytes =
                      //     generateSelfSignedCertificate(privateKey, publicKey);

                      // // Specify the directory to save certificate files
                      // final saveDirectory = 'D:';

                      // saveCertificateFiles(certificateBytes, saveDirectory);

                      // print("Certificate files saved.");
                      String message = "hassan";
                      Uint8List messageBytes =
                          Uint8List.fromList(message.codeUnits);
                      print('Message: 0x${hex.encode(messageBytes)}');
                      // print('Message: $messageBytes');
                      // print('Message: ${messageBytes.length}');

                      Uint8List signature =
                          signMessage(privateKey, messageBytes);
                      print('Signature: 0x${hex.encode(signature)}');
                      // print('Signature: ${signature}');
                      // print('Signature: ${signature.length}');
                      bool isSignatureValid =
                          VerifySignature(publicKey, messageBytes, signature);
                      print(
                          'Signature Verification in DART: $isSignatureValid');

                      makeApiRequest(publicKey, signature, messageBytes);

                      ECPublicKey bytesToPublicKey(Uint8List publicKeyBytes) {
                        final curve =
                            ECCurve_secp256r1(); // Use the appropriate curve
                        final ecPoint = curve.curve.decodePoint(publicKeyBytes);

                        return ECPublicKey(ecPoint, curve);
                      }

                      // bool iscertificateValid = verifySelfSignedCertificate(
                      //     generateSelfSignedCertificate(privateKey, publicKey),
                      //    generatePublicKey(privateKey));

                      //     print('Certificate is: $iscertificateValid');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      color: Color.fromARGB(255, 85, 209, 89),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//
//  Future<X509Certificate> generateSelfSignedCertificate(
//     Uint8List privateKeyBytes, String commonName) async {
//   // Create an X509CertificateBuilder object
//   X509CertificateBuilder builder = X509CertificateBuilder();

//   // Set the certificate version
//   builder.setVersion(X509Version.v3);

//   // Set the serial number
//   builder.setSerialNumber(BigInt.from(DateTime.now().microsecondsSinceEpoch));

//   // Set the issuer name
//   builder.setIssuer(X509Name.fromList([
//     X509NameEntry(X509NameEntry.commonName, commonName),
//     X509NameEntry(X509NameEntry.countryName, "US"),
//     X509NameEntry(X509NameEntry.organizationName, "My Organization"),
//     X509NameEntry(X509NameEntry.organizationalUnitName, "My Unit"),
//   ]);

//   // Set the subject name
//   builder.setSubject(X509Name.fromList([
//     X509NameEntry(X509NameEntry.commonName, commonName),
//     X509NameEntry(X509NameEntry.countryName, "US"),
//     X509NameEntry(X509NameEntry.organizationName, "My Organization"),
//     X509NameEntry(X509NameEntry.organizationalUnitName, "My Unit"),
//   ]);

//   // Set the public key
//   builder.setPublicKey(ECPublicKey.fromBytes(privateKeyBytes));

//   // Set the validity period
//   builder.setNotBefore(DateTime.now());
//   builder.setNotAfter(DateTime.now().add(Duration(days: 365)));

//   // Sign the certificate with the private key
//   X509Certificate certificate = await builder.build(privateKeyBytes);

//   // Return the certificate
//   return certificate;
// }
// Uint8List generateSelfSignedCertificate(Uint8List privateKeyBytes, Uint8List publicKeyBytes) {
//   final publicAsn1 = ASN1ObjectIdentifier.fromBytes(publicKeyBytes);

//   final publicKey = ASN1BitString(Uint8List.fromList(publicAsn1.encodedBytes));

//   final privateAsn1 = ASN1ObjectIdentifier.fromBytes(privateKeyBytes);
//   final privateKey = ASN1OctetString(Uint8List.fromList(privateAsn1.encodedBytes));

//   final cert = ASN1Sequence()
//     ..add(ASN1Integer(BigInt.from(1)))  // Serial number
//     ..add(ASN1Sequence()
//       ..add(ASN1ObjectIdentifier.fromBytes([2, 5, 4, 6]))  // OID for "C"
//       ..add(ASN1PrintableString("US")))  // Country code
//     // Add other fields as needed
//     ..add(publicKey)  // Public key
//     ..add(privateKey);  // Private key

//   return cert.encodedBytes;
// }
//  S code
// X509Certificate generateSelfSignedCertificate(
//     BigInt serialNumber, ECPublicKey publicKey, ECPrivateKey privateKey) {
//   // Create a subject distinguished name
//   var subject  = X509Subject(
//     country: 'Pak',
//     designation: 'The warriers of care pvt. ltd',
//     locality: 'Islamabad',
//     address: 'I93',
//     email: 'asif.mehmood@carepvtled.com',
//   );
//    DateTime now = DateTime.now();

//   // Calculate a date one year ahead of now
//   DateTime calAfter = now.add(Duration(days: 365));

//   // Calculate a date one year before now
//   DateTime calBefore = now.subtract(Duration(days: 365));

//   // Create the ECDSA signer
//   Uint8List ecdsaSigner = signMessage(privateKey as Uint8List, publicKey as Uint8List);

// //built a certificate

// return X509Certificate;
// }

// bool verifyCertificate(Uint8List certificateBytes, Uint8List trustedPublicKeyBytes) {
//   final sequence = ASN1Parser(certificateBytes).nextObject() as ASN1Sequence;

//   final tbsCertificate = sequence.elements[0] as ASN1Sequence;
//   final signatureAlgorithm = sequence.elements[1] as ASN1Sequence;
//   final signatureValueBitString = sequence.elements[2] as ASN1BitString;

//   final publicKeyBitString = tbsCertificate.elements[6] as ASN1BitString;
//   final publicKeyBytes = publicKeyBitString.contentBytes;

//   final verifier = Signer("SHA-256/ECDSA");
//   verifier.init(false, PublicKeyParameter<ECPublicKey>(ECPoint.fromBytes(publicKeyBytes).Q));

//   final hash = SHA256Digest().process(certificateBytes.sublist(0, certificateBytes.length - signatureValueBitString.contentBytes.length));

//   try {
//     return verifier.verifySignature(hash, ECSignature(signatureValueBitString.contentBytes));
//   } catch (e) {
//     return false;
//   }
// }
}
// class X509Subject {
//   final String country;
//   final String designation;
//   final String locality;
//   final String address;
//   final String email;

//   X509Subject({
//     required this.country,
//     required this.designation,
//     required this.locality,
//     required this.address,
//     required this.email,
// }
// );
// }
