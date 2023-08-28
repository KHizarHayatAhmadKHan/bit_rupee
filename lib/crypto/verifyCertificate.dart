// import 'dart:typed_data';
// import 'package:asn1lib/asn1lib.dart';
// import 'package:pointycastle/api.dart';
// import 'package:pointycastle/ecc/api.dart';
// import 'package:pointycastle/macs/hmac.dart';
// import 'package:pointycastle/signers/ecdsa_signer.dart';
// import 'package:pointycastle/ecc/curves/secp256k1.dart';
// import 'package:pointycastle/digests/sha256.dart';
// import 'package:pointycastle/src/utils.dart' as pointycastle_utils;
import 'package:dart_crypto/dart_crypto.dart' as crypto;
// // Create the EC private key

// // bool verifyCertificate(Uint8List certificateBytes) {
// //   // Load the certificate using the ASN1Parser
// //   final parser = ASN1Parser(certificateBytes);
// //   final certSeq = parser.nextObject() as ASN1Sequence;

// //   // Extract the public key
// //   final publicKeyBitString = certSeq.elements[9] as ASN1BitString;
// //   final publicKeyBytes = publicKeyBitString.contentBytes();

// //   // Extract the signature
// //   final signatureBitString = certSeq.elements[11] as ASN1BitString;
// //   final signatureBytes = signatureBitString.contentBytes();

// //   // Extract the signed certificate data for verification
// //   final signedData = certificateBytes.sublist(0, certSeq.encodedBytes.length - signatureBitString.encodedBytes.length);
// //  // Verify the signature
// //   final curve = ECCurve_secp256k1();
// //   final publicKey = ECPublicKey(curve.curve.decodePoint(publicKeyBytes), curve);
// //   final sig = ECSignature(BigInt.parse(signatureBytes[0] as String), BigInt.parse(signatureBytes[1] as String));
// //   final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
// //   signer.init(false, PublicKeyParameter<PublicKey>(publicKey));
// //   return signer.verifySignature(Uint8List.fromList(signedData), sig);

// // }
// bool verifyCertificate(Uint8List certificateBytes) {
//   final parser = ASN1Parser(certificateBytes);
//   final certSeq = parser.nextObject() as ASN1Sequence;

//   // Extract the public key
//   final publicKeyBitString = certSeq.elements[7] as ASN1BitString;
//   final publicKeyBytes = publicKeyBitString.contentBytes();

//   // Extract the signature
//   final signatureBitString = certSeq.elements[9] as ASN1BitString;
//   final signatureBytes = signatureBitString.contentBytes();

//   // Calculate the length of the ASN.1 encoded signature bit string
//   final signatureBitStringLength = signatureBytes.length;

//   // Extract the signed certificate data for verification
//   final signedData = certificateBytes.sublist(0, certificateBytes.length - signatureBitStringLength);

//   // Verify the signature
//   final curve = ECCurve_secp256k1();
//   final publicKey = ECPublicKey(curve.curve.decodePoint(publicKeyBytes), curve);
//   final sig = ECSignature(BigInt.parse(signatureBytes[0]), BigInt.parse(signatureBytes[1]));
//   final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
//   signer.init(false, PublicKeyParameter<PublicKey>(publicKey));
//   return signer.verifySignature(Uint8List.fromList(signedData), sig);
// }
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

bool verifyCertificate(Uint8List certificateBytes) {
  final parser = ASN1Parser(certificateBytes);
  final certSeq = parser.nextObject() as ASN1Sequence;

  // Assuming public key info is in the second element of the sequence
  final publicKeyInfo = certSeq.elements[1] as ASN1Sequence;

  // Assuming public key is the first element within the public key info
  final publicKeyBitString = publicKeyInfo.elements[0] as ASN1BitString;
  final publicKeyBytes = publicKeyBitString.contentBytes();

  // Extract the signature
  final signatureBitString = certSeq.elements[9] as ASN1BitString;
  final signatureBytes = signatureBitString.contentBytes();

  // Calculate the length of the ASN.1 encoded signature bit string
  final signatureBitStringLength = signatureBytes.length;

  // Extract the signed certificate data for verification
  final signedData = certificateBytes.sublist(
      0, certificateBytes.length - signatureBitStringLength);

  // Verify the signature
  final curve = ECCurve_secp256k1();
  final publicKey = ECPublicKey(curve.curve.decodePoint(publicKeyBytes), curve);

  final r = BigInt.parse(signatureBytes[0].toString());
  final s = BigInt.parse(signatureBytes[1].toString());
  final sig = ECSignature(r, s);

  final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
  signer.init(false, PublicKeyParameter<PublicKey>(publicKey));
  return signer.verifySignature(Uint8List.fromList(signedData), sig);
}
