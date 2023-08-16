// Function to sign a message using the private key
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

Uint8List signMessage(Uint8List privateKeyBytes, Uint8List message) {
  ECCurve_secp256k1 curve = ECCurve_secp256k1();
  ECPrivateKey privateKey =
      ECPrivateKey(BigInt.parse(hex.encode(privateKeyBytes), radix: 16), curve);

  // Create a secure random number generator
  SecureRandom secureRandom = FortunaRandom();
  secureRandom.seed(KeyParameter(Uint8List.fromList(privateKeyBytes)));

  final sha256Digest = SHA256Digest();
  final hmac = HMac(sha256Digest, 64);
  final signer = ECDSASigner(sha256Digest, hmac); // Use the digests here
  signer.init(true, PrivateKeyParameter(privateKey));

  final signature = signer.generateSignature(Uint8List.fromList(message));

  // Extract r and s from the Signature object
  BigInt r = (signature as ECSignature).r;
  BigInt s = (signature).s;

  // Convert r and s to 32-byte Uint8Lists
  Uint8List rBytes = _encodeBigInt(r, 32);
  Uint8List sBytes = _encodeBigInt(s, 32);

  // Concatenate r and s to get the 64-byte signature
  Uint8List signatureBytes = Uint8List.fromList([...rBytes, ...sBytes]);

  return signatureBytes;
}

Uint8List _encodeBigInt(BigInt value, int size) {
  var result = Uint8List(size);
  for (var i = size - 1; i >= 0; i--) {
    result[i] = value.toUnsigned(8).toInt();
    value >>= 8;
  }
  return result;
}
