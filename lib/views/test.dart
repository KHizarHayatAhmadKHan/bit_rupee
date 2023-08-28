// // // // // import 'dart:convert'; // Import this for JSON decoding

// // // // // // ...

// // // // // ElevatedButton(
// // // // //   onPressed: () async {
// // // // //     if (_formKey.currentState!.validate()) {
// // // // //       _formKey.currentState!.save(); // Save the user input to _id variable

// // // // //       // Make the API call
// // // // //       final response = await http.get(Uri.parse('http://172.16.2.222:8080/bitrupee/api/wutxo/$_id'));

// // // // //       if (response.statusCode == 200) {
// // // // //         // If the API call is successful (status code 200)
// // // // //         // Parse the response JSON and check if the IDs match
// // // // //         final responseData = json.decode(response.body);
// // // // //         if (responseData['id'] == int.parse(_id)) {
// // // // //           // If the IDs match, navigate to the Wallet page
// // // // //           Navigator.push(
// // // // //             context,
// // // // //             MaterialPageRoute(builder: (context) => Wallet()),
// // // // //           );
// // // // //         } else {
// // // // //           // If the IDs don't match, show an error message
// // // // //           showDialog(
// // // // //             context: context,
// // // // //             builder: (context) {
// // // // //               return AlertDialog(
// // // // //                 title: Text('Invalid ID'),
// // // // //                 content: Text('The provided ID does not match the response ID.'),
// // // // //                 actions: <Widget>[
// // // // //                   TextButton(
// // // // //                     child: Text('OK'),
// // // // //                     onPressed: () {
// // // // //                       Navigator.of(context).pop();
// // // // //                     },
// // // // //                   ),
// // // // //                 ],
// // // // //               );
// // // // //             },
// // // // //           );
// // // // //         }
// // // // //       } else {
// // // // //         // If the API call fails, show an error message
// // // // //         showDialog(
// // // // //           context: context,
// // // // //           builder: (context) {
// // // // //             return AlertDialog(
// // // // //               title: Text('API Error'),
// // // // //               content: Text('Failed to fetch data from the API.'),
// // // // //               actions: <Widget>[
// // // // //                 TextButton(
// // // // //                   child: Text('OK'),
// // // // //                   onPressed: () {
// // // // //                     Navigator.of(context).pop();
// // // // //                   },
// // // // //                 ),
// // // // //               ],
// // // // //             );
// // // // //           },
// // // // //         );
// // // // //       }
// // // // //     }
// // // // //   },
// // // // //   // Rest of the button code...
// // // // // )

// // // // // import 'dart:typed_data';
// // // // // import 'package:pointycastle/pointycastle.dart';
// // // // // import 'package:pointycastle/random/fortuna_random.dart';

// // // // // void main() {
// // // // //   final secureRandom = FortunaRandom(); // Use FortunaRandom for strong randomness
// // // // //   final keyBytes = secureRandom.nextBytes(32); // for AES-256

// // // // //   final aesKey = KeyParameter(Uint8List.fromList(keyBytes));

// // // // //   print('Key: ${aesKey.key}');
// // // // // }
// // // // import 'dart:io';
// // // // import 'dart:typed_data';
// // // // import 'package:asn1lib/asn1lib.dart';
// // // // import 'package:cryptography/cryptography.dart';

// // // // Future<X509Certificate> generateSelfSignedCertificate(Uint8List privateKeyBytes,final publicKey) async {
// // // //   // final publicKey = generatePublicKey(privateKeyBytes);

// // // //   final certificate = X509Certificate  (
// // // //     subject: X509DistinguishedName(commonName: 'Self-Signed'),
// // // //     issuer: X509DistinguishedName(commonName: 'Self-Signed'),
// // // //     serialNumber: DateTime.now().millisecondsSinceEpoch,
// // // //     validity: X509Validity(
// // // //       notBefore: DateTime.now(),
// // // //       notAfter: DateTime.now().add(Duration(days: 365)),
// // // //     ),
// // // //     subjectPublicKey: await publicKey.extractRawSubjectPublicKey(),
// // // //     issuerPrivateKey: privateKeyBytes,
// // // //   );

// // // //   return certificate;
// // // // }

// // // import 'dart:typed_data';

// // // import 'package:asn1lib/asn1lib.dart';
// // // import 'package:bit_rupee/crypto/verifySignature.dart';
// // // import 'package:pointycastle/api.dart';
// // // import 'package:pointycastle/ecc/api.dart';
// // // import 'package:pointycastle/ecc/curves/secp256r1.dart';
// // // import 'package:pointycastle/macs/hmac.dart';
// // // import 'package:pointycastle/signers/ecdsa_signer.dart';

// // // Uint8List generateSelfSignedCertificate(
// // //     Uint8List privateKeyBytes, Uint8List publicKeyBytes) {
// // //   final publicAsn1 = ASN1ObjectIdentifier(Uint8List.fromList(publicKeyBytes));

// // //   final publicKey = ASN1BitString(Uint8List.fromList(publicAsn1.encodedBytes));

// // //   final privateAsn1 = ASN1ObjectIdentifier(Uint8List.fromList(privateKeyBytes));
// // //   final privateKey =
// // //       ASN1OctetString(Uint8List.fromList(privateAsn1.encodedBytes));

// // //   final cert = ASN1Sequence()
// // //     ..add(ASN1Integer(BigInt.from(1))) // Serial number
// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("PK"))) // Country code

// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("ICT"))) // state or province

// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("ISL"))) // locality

// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("CARE"))) // organization

// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("LOGIN"))) // organization unit

// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("bitrupee"))) // common name

// // //     ..add(ASN1Sequence()
// // //       ..add(
// // //           ASN1ObjectIdentifier(Uint8List.fromList([5, 5, 4, 6]))) // OID for "C"
// // //       ..add(ASN1PrintableString("US"))) // email

// // //     ..add(ASN1Sequence()
// // //       ..add(ASN1UtcTime(DateTime.now())) // Not before
// // //       ..add(ASN1UtcTime(DateTime.now().add(Duration(days: 365))))) // Not after

// // //     ..add(ASN1Sequence()
// // //       ..add(ASN1ObjectIdentifier(Uint8List.fromList(
// // //           [1, 2, 840, 10045, 2, 1]))) // OID for EC public key
// // //       ..add(publicKey)) // Public key
// // //     ..add(ASN1Sequence()
// // //       ..add(ASN1ObjectIdentifier(Uint8List.fromList(
// // //           [1, 2, 840, 10045, 3, 1, 7]))) // OID for EC private key
// // //       ..add(privateKey)); // Private key

// // //   return cert.encodedBytes;
// // // }

// // // // Uint8List intToBytes(int value, int length) {
// // // //   final result = Uint8List(length);
// // // //   for (var i = length - 1; i >= 0; i--) {
// // // //     result[i] = value & 0xff;
// // // //     value >>= 8;
// // // //   }
// // // //   return result;
// // // // }

// // // // bool verifySelfSignedCertificate(Uint8List certificateBytes,Uint8List message, Uint8List signatureBytes) {
// // // //   try {
// // // //     final decodedCert = ASN1Parser(certificateBytes).nextObject() as ASN1Sequence;

// // // //     final publicKeyBitString = decodedCert.elements[6] as ASN1BitString;
// // // //     final decodedPublicKey = ASN1Parser(publicKeyBitString.contentBytes()).nextObject() as ASN1Sequence;

// // // //     final x = (decodedPublicKey.elements[0] as ASN1Integer).intValue;
// // // //     final y = (decodedPublicKey.elements[1] as ASN1Integer).intValue;

// // // //     final curve = ECCurve_secp256r1();
// // // //     final ecPoint = curve.curve.decodePoint(Uint8List.fromList([0x04] + intToBytes(x, 32) + intToBytes(y, 32)));

// // // //     final publicKey = ECPublicKey(
// // // //       ecPoint,
// // // //       curve // Use the appropriate curve for your certificate
// // // //     );

// // // //     final signatureBitString = decodedCert.elements[2] as ASN1BitString;
// // // //     final signatureBytes = signatureBitString.contentBytes();
// // // // final derParser = ASN1Parser(signatureBytes);
// // // //     final derSequence = derParser.nextObject() as ASN1Sequence;
// // // //     final r = (derSequence.elements[0] as ASN1Integer).intValue;
// // // //     final s = (derSequence.elements[1] as ASN1Integer).intValue;

// // // //     final signature = ECSignature(BigInt.parse(r.toString()), BigInt.parse(s.toString()));
// // // // //l verifySignature(
// // // //    //   Uint8List publicKeyBytes, Uint8List message, Uint8List signatureBytes)
// // // //  Uint8List publicKeyToBytes(ECPublicKey publicKey) {
// // // //   final ecPoint = publicKey.Q;
// // // //   final ecPointBytes = ecPoint!.getEncoded(false);

// // // //   // Assuming uncompressed point format, ecPointBytes contains X and Y coordinates
// // // //   return ecPointBytes;
// // // // }
// // // //     final verifier = VerifySignature( publicKeyToBytes(publicKey), message, signatureBytes);
// // // //     return verifier;
// // // //   } catch (e) {
// // // //     print("Error verifying certificate: $e");
// // // //     return false;
// // // //   }
// // // // }

// // // // Uint8List intToBytes(int value, int length) {
// // // //   final result = Uint8List(length);
// // // //   for (var i = length - 1; i >= 0; i--) {
// // // //     result[i] = value & 0xff;
// // // //     value >>= 8;
// // // //   }
// // // //   return result;
// // // // }

// // // // bool verifySelfSignedCertificate(Uint8List certificateBytes, ECPublicKey publicKey) {
// // // //   try {
// // // //     final decodedCert = ASN1Parser(certificateBytes).nextObject() as ASN1Sequence;

// // // //     final signatureBitString = decodedCert.elements[2] as ASN1BitString;
// // // //     final signatureBytes = signatureBitString.contentBytes();

// // // //     // Decode DER encoded signature
// // // //     final derParser = ASN1Parser(signatureBytes);
// // // //     final derSequence = derParser.nextObject() as ASN1Sequence;
// // // //     final r = (derSequence.elements[0] as ASN1Integer).intValue;
// // // //     final s = (derSequence.elements[1] as ASN1Integer).intValue;

// // // //     final signature = ECSignature(BigInt.parse(r.toString()), BigInt.parse(s.toString()));

// // // //     final signer = ECDSASigner(null, HMac(Digest("SHA-256"), 64));
// // // //     signer.init(false, PublicKeyParameter<ECPublicKey>(publicKey));

// // // //     return signer.verifySignature(Uint8List.fromList(signatureBytes), signature);
// // // //   } catch (e) {
// // // //     print("Error verifying certificate: $e");
// // // //     return false;
// // // //   }
// // // // }
// // import 'dart:convert';
// // import 'dart:typed_data';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:pointycastle/api.dart';
// // import 'package:pointycastle/key_generators/api.dart';
// // import 'package:pointycastle/ecc/api.dart';
// // import 'package:pointycastle/key_generators/ec_key_generator.dart';

// // final storage = FlutterSecureStorage();

// // AsymmetricKeyPair<PublicKey, PrivateKey> generateKeyPair() {
// //   final keyGen = ECKeyGenerator(); // Use EC for key pair generation
// //   final keyPair = keyGen.generateKeyPair();
// //   print(keyPair.privateKey.toString());
// //   return keyPair;
// // }

// // Future<void> signUp(String username, String password) async {
// //   final keyPair = generateKeyPair();

// //   // Convert private key to a string representation
// //   final privateKeyBytes = keyPair.privateKey.d.toRadixBytes();
// //   final privateKeyString = base64.encode(privateKeyBytes);

// //   // Store private key securely
// //   await storage.write(key: 'privateKey_$username', value: privateKeyString);

// //   final publicKey = keyPair.publicKey;
// //   final publicKeyBytes = publicKey.Q!.getEncoded();

// //   await registerUserOnServer(username, publicKeyBytes, password);
// // }

// // Future<void> registerUserOnServer(
// //     String username, Uint8List publicKey, String password) async {
// //   // Implement your API call to register the user on the server
// //   // Store user data securely, using hashing and salting for passwords
// // }

// // void main() {
// //   signUp('username', 'password'); // Replace with actual user data
// // }

import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/src/platform_check/platform_check.dart';
import "package:pointycastle/export.dart";

// SecureRandom exampleSecureRandom() {
//   final secureRandom = SecureRandom('Fortuna')
//     ..seed(
//         KeyParameter(Platform.instance.platformEntropySource().getBytes(32)));
//   return secureRandom;
// }

// AsymmetricKeyPair<ECPublicKey, ECPrivateKey> generateECkeyPair(
//     SecureRandom secureRandom,
//     {int bitLength = 2048}) {
//   // Create an RSA key generator and initialize it

//   final keyGen = KeyGenerator('EC'); // Get using registry
//   // final keyGen = RSAKeyGenerator();
//   ECDomainParameters params = ECDomainParameters('secp256r1');
//   keyGen.init(
//       ParametersWithRandom(ECKeyGeneratorParameters(params), secureRandom));

//   // Use the generator

//   final pair = keyGen.generateKeyPair();

//   // Cast the generated key pair into the RSA key types

//   final myPublic = pair.publicKey as ECPublicKey;
//   final myPrivate = pair.privateKey as ECPrivateKey;

//   return AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(myPublic, myPrivate);
// }

// void main() {
//   final secureRandom = exampleSecureRandom();
//   final keyPair = generateECkeyPair(secureRandom);
//   print(keyPair.privateKey.toString());
//   print(keyPair.publicKey.toString());
//   print(keyPair.privateKey.d.toString());
//   print(keyPair.publicKey.Q!.toString());
// }

// import 'dart:typed_data';
// import 'package:pointycastle/pointycastle.dart';

SecureRandom exampleSecureRandom(Uint8List seed) {
  final secureRandom = SecureRandom('Fortuna')..seed(KeyParameter(seed));
  return secureRandom;
}

AsymmetricKeyPair<ECPublicKey, ECPrivateKey> generateECkeyPair(
    SecureRandom secureRandom,
    {int bitLength = 256}) {
  final keyGen = ECKeyGenerator();
  ECDomainParameters params = ECDomainParameters('secp256r1');
  keyGen.init(
      ParametersWithRandom(ECKeyGeneratorParameters(params), secureRandom));

  final pair = keyGen.generateKeyPair();

  final myPublic = pair.publicKey as ECPublicKey;
  final myPrivate = pair.privateKey as ECPrivateKey;

  return AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(myPublic, myPrivate);
}

Signature ECDSASign(ECPrivateKey privateKey, Uint8List dataToSign) {
  
  final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));

  signer.init(true, PrivateKeyParameter<ECPrivateKey>(privateKey));

  final sig = signer.generateSignature(dataToSign);

  return sig;
}

bool ECDSAVerify(
    ECPublicKey publicKey, Uint8List signedData, ECSignature signature) {
  final verifier = ECDSASigner(null, HMac(SHA256Digest(), 64));

  verifier.init(false, PublicKeyParameter<ECPublicKey>(publicKey));

  return verifier.verifySignature(signedData, signature);
}

void main() {
  // Take your two input strings
  String input1 = "12345678910";
  String input2 = "hassanshakilanjumsaee";

  // Convert input strings to bytes and concatenate them
  Uint8List seed = Uint8List.fromList((input1 + input2).codeUnits);

  final secureRandom = exampleSecureRandom(seed);
  final keyPair = generateECkeyPair(secureRandom);

  print("Private Key: ${keyPair.privateKey.d.toString()}");
  print("Public Key: ${keyPair.publicKey.Q!.toString()}");

  // Data to sign
  final dataToSign = Uint8List.fromList('Hello, world!'.codeUnits);

  // Sign the data
  Signature signature = ECDSASign(keyPair.privateKey, dataToSign);

  print('Data to Sign: ${String.fromCharCodes(dataToSign)}');
  print('Signature: ${signature.toString()}');

  // Verify the signature
  final isVerified =
      ECDSAVerify(keyPair.publicKey, dataToSign, signature as ECSignature);
  print('Signature Verification Result: $isVerified');

  
}
