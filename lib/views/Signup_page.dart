import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String _cnic = '';
  late String _secretKey = '';

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
                      String privateKey = generatePrivateKey(_cnic, _secretKey);
                      print('Generated Private Key: $privateKey');
                      String publicKey = await generatePublicKey(privateKey);

                      print('Generated Public Key: $publicKey');
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
                  ), // Text displayed on the button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generatePrivateKey(String cnic, String secretKey) {
    // Combine CNIC and Secret_key
    String combinedData = '$cnic$secretKey';

    // Generate SHA-256 hash of the combined data
    Uint8List sha256Result =
        SHA256Digest().process(Uint8List.fromList(combinedData.codeUnits));

    // Convert the hash to a hexadecimal string
    String privateKey = '';
    for (var byte in sha256Result) {
      privateKey += byte.toRadixString(16).padLeft(2, '0');
    }

    return privateKey;
  }

  Future<String> generatePublicKey(String privateKey) async {
    // Create an RSA key generator object
    var keyGen = RSAKeyGenerator();

    // Create an RSA key generator parameters object with 2048 bits modulus length, public exponent 65537, and certainty 12
    var keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 12);

    // Create a secure random object
    var secureRandom = SecureRandom('Fortuna');

    // Create a random seed parameter object from the private key string
    var randomParams = ParametersWithRandom(keyParams, secureRandom);
    var seed = createUint8ListFromHexString(privateKey);
    secureRandom.seed(KeyParameter(seed));

    // Initialize the key generator with the random parameters
    keyGen.init(randomParams);

    // Generate an RSA key pair
    var keyPair = keyGen.generateKeyPair();

    // Return the public key from the key pair
    RSAPublicKey publicKey = keyPair.publicKey as RSAPublicKey;

    // Convert the public key components to a hexadecimal string
    String publicExponentHex =
        publicKey.exponent!.toRadixString(16).padLeft(2, '0');
    String modulusHex = publicKey.modulus!.toRadixString(16).padLeft(2, '0');
    String publicKeyHex = modulusHex + publicExponentHex;

    return publicKeyHex;
  }

// Utility method to create a Uint8List from a hexadecimal string
  Uint8List createUint8ListFromHexString(String hex) {
    var result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      var num = hex.substring(i, i + 2);
      var byte = int.parse(num, radix: 16);
      result[i ~/ 2] = byte;
    }
    return result;
  }
}
