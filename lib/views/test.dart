// // import 'dart:convert'; // Import this for JSON decoding

// // // ...

// // ElevatedButton(
// //   onPressed: () async {
// //     if (_formKey.currentState!.validate()) {
// //       _formKey.currentState!.save(); // Save the user input to _id variable

// //       // Make the API call
// //       final response = await http.get(Uri.parse('http://172.16.2.222:8080/bitrupee/api/wutxo/$_id'));

// //       if (response.statusCode == 200) {
// //         // If the API call is successful (status code 200)
// //         // Parse the response JSON and check if the IDs match
// //         final responseData = json.decode(response.body);
// //         if (responseData['id'] == int.parse(_id)) {
// //           // If the IDs match, navigate to the Wallet page
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => Wallet()),
// //           );
// //         } else {
// //           // If the IDs don't match, show an error message
// //           showDialog(
// //             context: context,
// //             builder: (context) {
// //               return AlertDialog(
// //                 title: Text('Invalid ID'),
// //                 content: Text('The provided ID does not match the response ID.'),
// //                 actions: <Widget>[
// //                   TextButton(
// //                     child: Text('OK'),
// //                     onPressed: () {
// //                       Navigator.of(context).pop();
// //                     },
// //                   ),
// //                 ],
// //               );
// //             },
// //           );
// //         }
// //       } else {
// //         // If the API call fails, show an error message
// //         showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               title: Text('API Error'),
// //               content: Text('Failed to fetch data from the API.'),
// //               actions: <Widget>[
// //                 TextButton(
// //                   child: Text('OK'),
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                   },
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       }
// //     }
// //   },
// //   // Rest of the button code...
// // )

// // import 'dart:typed_data';
// // import 'package:pointycastle/pointycastle.dart';
// // import 'package:pointycastle/random/fortuna_random.dart';

// // void main() {
// //   final secureRandom = FortunaRandom(); // Use FortunaRandom for strong randomness
// //   final keyBytes = secureRandom.nextBytes(32); // for AES-256

// //   final aesKey = KeyParameter(Uint8List.fromList(keyBytes));

// //   print('Key: ${aesKey.key}');
// // }
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:asn1lib/asn1lib.dart';
// import 'package:cryptography/cryptography.dart';

// Future<X509Certificate> generateSelfSignedCertificate(Uint8List privateKeyBytes,final publicKey) async {
//   // final publicKey = generatePublicKey(privateKeyBytes);

//   final certificate = X509Certificate  (
//     subject: X509DistinguishedName(commonName: 'Self-Signed'),
//     issuer: X509DistinguishedName(commonName: 'Self-Signed'),
//     serialNumber: DateTime.now().millisecondsSinceEpoch,
//     validity: X509Validity(
//       notBefore: DateTime.now(),
//       notAfter: DateTime.now().add(Duration(days: 365)),
//     ),
//     subjectPublicKey: await publicKey.extractRawSubjectPublicKey(),
//     issuerPrivateKey: privateKeyBytes,
//   );

//   return certificate;
// }

import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';

Uint8List generateSelfSignedCertificate(
    Uint8List privateKeyBytes, Uint8List publicKeyBytes) {
  final publicAsn1 = ASN1ObjectIdentifier(Uint8List.fromList(publicKeyBytes));

  final publicKey = ASN1BitString(Uint8List.fromList(publicAsn1.encodedBytes));

  final privateAsn1 = ASN1ObjectIdentifier(Uint8List.fromList(privateKeyBytes));
  final privateKey =
      ASN1OctetString(Uint8List.fromList(privateAsn1.encodedBytes));

  final cert = ASN1Sequence()
    ..add(ASN1Integer(BigInt.from(1))) // Serial number
    ..add(ASN1Sequence()
      ..add(
          ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
      ..add(ASN1PrintableString("US"))) // Country code
    // Add other fields as needed
    ..add(publicKey) // Public key
    ..add(privateKey); // Private key

  return cert.encodedBytes;
}
