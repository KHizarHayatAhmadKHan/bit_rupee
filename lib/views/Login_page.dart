import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome to bitRupee",
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
                'Please Enter the Wallet ID to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
                      labelText: 'Enter Wallet Number',
                      labelStyle: const TextStyle(color: Colors.white)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your id.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _id = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      try {
                        final response = await http.get(Uri.parse(
                            'http://172.16.2.222:8080/bitrupee/api/wutxo/$_id'));

                        if (response.statusCode == 200) {
                          final responseData = json.decode(response.body);
                          if (responseData != null &&
                              responseData.containsKey('id') &&
                              responseData.containsKey('walletAddress') &&
                              responseData.containsKey('balance')) {
                            Navigator.pushNamed(
                              context,
                              '/landing',
                              arguments: {
                                'id': responseData['id'],
                                'walletaddress': responseData['walletAddress'],
                                'balance': responseData['balance'],
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Invalid ID'),
                                  content: const Text(
                                      'The provided ID is invalid or does not exist.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('API Error'),
                                content: const Text(
                                    'Failed to fetch data from the API.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        print('Error during API call: $e');
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'An error occurred while fetching data from the API.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Invalid ID'),
                            content: const Text('Please enter a valid ID.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
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
                      ))),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Color.fromARGB(255, 85, 209, 89),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
