import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bit_rupee/config/Config.dart';

// ignore: must_be_immutable
class Wallet extends StatefulWidget {
  final int id;
  final String walletaddress;
  late int balance;

  Wallet({
    required this.id,
    required this.walletaddress,
    required this.balance,
  });

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> fetchDataAndUpdateData() async {
    try {
      final response = await http
          .get(Uri.parse('${Config.backendEndpoint}/wutxo/${widget.id}'));

      // Parse the response and update the state with the fetched data
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          widget.balance = responseData['balance'];
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.wallet),
            onPressed: () {},
          ),
        ],
        title: const Text('Wallet'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ),
      body: RefreshIndicator(
        onRefresh: fetchDataAndUpdateData,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? 400.0 : 170.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: .5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          height: 70.0,
                          width: 8.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 85, 209, 89),
                          child:
                              Icon(Icons.wallet_outlined, color: Colors.white),
                        ),
                        SizedBox(width: 5.0),
                        Text("Total Wallet Balance",
                            style: TextStyle(fontSize: 20)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                'BTR',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("BTR ${widget.balance}",
                        style: const TextStyle(fontSize: 30)),
                    IconButton(
                      alignment: _isExpanded
                          ? Alignment.bottomCenter
                          : Alignment.bottomCenter,
                      icon: Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: _toggleContainer,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sendmoney', arguments: {
                  'id': widget.id,
                  'walletAddress': widget.walletaddress,
                });
              },
              child: const Text("Send Money"),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(350, 50)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 85, 209, 89)),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white, fontSize: 16)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
