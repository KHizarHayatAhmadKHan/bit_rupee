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

import 'dart:js_interop';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:bit_rupee/crypto/verifySignature.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256r1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';




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



// Uint8List intToBytes(int value, int length) {
//   final result = Uint8List(length);
//   for (var i = length - 1; i >= 0; i--) {
//     result[i] = value & 0xff;
//     value >>= 8;
//   }
//   return result;
// }

// bool verifySelfSignedCertificate(Uint8List certificateBytes,Uint8List message, Uint8List signatureBytes) {
//   try {
//     final decodedCert = ASN1Parser(certificateBytes).nextObject() as ASN1Sequence;

//     final publicKeyBitString = decodedCert.elements[6] as ASN1BitString;
//     final decodedPublicKey = ASN1Parser(publicKeyBitString.contentBytes()).nextObject() as ASN1Sequence;

//     final x = (decodedPublicKey.elements[0] as ASN1Integer).intValue;
//     final y = (decodedPublicKey.elements[1] as ASN1Integer).intValue;

//     final curve = ECCurve_secp256r1();
//     final ecPoint = curve.curve.decodePoint(Uint8List.fromList([0x04] + intToBytes(x, 32) + intToBytes(y, 32)));

//     final publicKey = ECPublicKey(
//       ecPoint,
//       curve // Use the appropriate curve for your certificate
//     );

//     final signatureBitString = decodedCert.elements[2] as ASN1BitString;
//     final signatureBytes = signatureBitString.contentBytes();
// final derParser = ASN1Parser(signatureBytes);
//     final derSequence = derParser.nextObject() as ASN1Sequence;
//     final r = (derSequence.elements[0] as ASN1Integer).intValue;
//     final s = (derSequence.elements[1] as ASN1Integer).intValue;

//     final signature = ECSignature(BigInt.parse(r.toString()), BigInt.parse(s.toString()));
// //l verifySignature(
//    //   Uint8List publicKeyBytes, Uint8List message, Uint8List signatureBytes)
//  Uint8List publicKeyToBytes(ECPublicKey publicKey) {
//   final ecPoint = publicKey.Q;
//   final ecPointBytes = ecPoint!.getEncoded(false);
  
//   // Assuming uncompressed point format, ecPointBytes contains X and Y coordinates
//   return ecPointBytes;
// }
//     final verifier = VerifySignature( publicKeyToBytes(publicKey), message, signatureBytes);
//     return verifier;
//   } catch (e) {
//     print("Error verifying certificate: $e");
//     return false;
//   }
// }




// Uint8List intToBytes(int value, int length) {
//   final result = Uint8List(length);
//   for (var i = length - 1; i >= 0; i--) {
//     result[i] = value & 0xff;
//     value >>= 8;
//   }
//   return result;
// }

// bool verifySelfSignedCertificate(Uint8List certificateBytes, ECPublicKey publicKey) {
//   try {
//     final decodedCert = ASN1Parser(certificateBytes).nextObject() as ASN1Sequence;

//     final signatureBitString = decodedCert.elements[2] as ASN1BitString;
//     final signatureBytes = signatureBitString.contentBytes();

//     // Decode DER encoded signature
//     final derParser = ASN1Parser(signatureBytes);
//     final derSequence = derParser.nextObject() as ASN1Sequence;
//     final r = (derSequence.elements[0] as ASN1Integer).intValue;
//     final s = (derSequence.elements[1] as ASN1Integer).intValue;

//     final signature = ECSignature(BigInt.parse(r.toString()), BigInt.parse(s.toString()));

//     final signer = ECDSASigner(null, HMac(Digest("SHA-256"), 64));
//     signer.init(false, PublicKeyParameter<ECPublicKey>(publicKey));

//     return signer.verifySignature(Uint8List.fromList(signatureBytes), signature);
//   } catch (e) {
//     print("Error verifying certificate: $e");
//     return false;
//   }
// }