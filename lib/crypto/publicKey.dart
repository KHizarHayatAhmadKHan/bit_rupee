import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

ECPublicKey generatePublicKey(Uint8List privateKeyBytes) {
    ECCurve_secp256k1 curve = ECCurve_secp256k1();
    ECPrivateKey privateKey = ECPrivateKey(
        BigInt.parse(hex.encode(privateKeyBytes), radix: 16), curve);

    ECPoint? publicKeyPoint = curve.G * privateKey.d!;
    return ECPublicKey(publicKeyPoint, curve);
  }