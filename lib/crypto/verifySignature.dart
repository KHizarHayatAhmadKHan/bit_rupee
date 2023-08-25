//Function to verify a signature using the public key
  import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

bool VerifySignature(
      Uint8List publicKeyBytes, Uint8List message, Uint8List signatureBytes) {
    ECCurve_secp256k1 curve = ECCurve_secp256k1();
    ECPublicKey publicKey =
        ECPublicKey(curve.curve.decodePoint(publicKeyBytes), curve);

    ECDSASigner signer = ECDSASigner(SHA256Digest(), HMac(SHA256Digest(), 64));
    signer.init(false, PublicKeyParameter(publicKey));

    // Split the signatureBytes into r and s components
    int halfLength = signatureBytes.length ~/ 2;
    Uint8List rBytes = signatureBytes.sublist(0, halfLength);
    Uint8List sBytes = signatureBytes.sublist(halfLength);

    // Convert r and s to BigInt
    BigInt r = decodeBigInt(rBytes);
    BigInt s = decodeBigInt(sBytes);

    // Create the ECSignature instance
    ECSignature signature = ECSignature(r, s);

    return signer.verifySignature(Uint8List.fromList(message), signature);
  }

  BigInt decodeBigInt(Uint8List bytes) {
    BigInt result = BigInt.zero;
    for (int i = 0; i < bytes.length; i++) {
      result = (result << 8) + BigInt.from(bytes[i]);
    }
    return result;
  }