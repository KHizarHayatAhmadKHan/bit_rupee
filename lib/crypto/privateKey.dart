import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

Uint8List generatePrivateKey(String input1, String input2) {
    // Concatenate the inputs to create the seed
    String seed = input1 + input2;

    // Create a SHA-256 digest of the seed
    Digest sha256Digest = SHA256Digest();
    Uint8List seedBytes = Uint8List.fromList(seed.codeUnits);
    Uint8List digest = sha256Digest.process(seedBytes);

    // Create an ECC private key using the secp256k1 curve
    ECCurve_secp256k1 curve = ECCurve_secp256k1();
    ECPrivateKey privateKey =
        ECPrivateKey(BigInt.parse(hex.encode(digest), radix: 16), curve);

    // Make sure the private key is within the valid range for the curve
    BigInt n = curve.n;
    BigInt privateKeyInt = privateKey.d!;
    privateKeyInt = privateKeyInt % n;

    String privateKeyHex = privateKeyInt.toRadixString(16).padLeft(64, '0');
    Uint8List privateKeyBytes = Uint8List.fromList(hex.decode(privateKeyHex));

    return privateKeyBytes;
  }