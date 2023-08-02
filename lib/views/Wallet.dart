import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Wallet extends StatefulWidget {
  final int id;
  final String walletaddress;
  late  int balance; // final changed to late.

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
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
Future<void> fetchDataAndUpdateData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://172.16.2.222:8080/bitrupee/api/wutxo/${widget.id}'));

      // Parse the response and update the state with the fetched data
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          // Update 'data' using the fetched data, assuming the response data structure is Map<String, dynamic>
          // For example: data = responseData['data'];
          widget.balance=responseData['balance'];
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      // Handle any errors, e.g., show an error message to the user
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
            icon: Icon(Icons.wallet),
            onPressed: () {},
          ),
        ],
        title: Text('Wallet'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 85, 209, 89),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ),
      body: RefreshIndicator(
        onRefresh: 
          fetchDataAndUpdateData
        ,
        child: SingleChildScrollView(
          // child: Container(
          //   decoration: BoxDecoration(
          //     color: Colors.grey,
          //   ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 450),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _isExpanded ? 400.0 : 170.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: .5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 70.0,
                              width: 8.0,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 85, 209, 89),
                                  child: Icon(Icons.wallet_outlined,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 5.0),
                                Text("Total Wallet Balance",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            // SizedBox(
                            //   width: 90.0,
                            // ),
                            // Text("BTR", style: TextStyle(fontSize: 15)),
      
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right:
                                              20.0), // Adjust the padding as needed
                                      child: Text(
                                        'BTR',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    // Other widgets under the text, if needed
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("BTR ${widget.balance}",
                          style: TextStyle(fontSize: 30)),
                      Center(
                        child: IconButton(
                          icon: Icon(_isExpanded
                              ? Icons.expand_less
                              : Icons.expand_more),
                          onPressed: _toggleContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sendmoney', arguments: {
                      'id': widget.id,
                      'walletAddress': widget.walletaddress,
                    });
                  },
                  child: Text("Send Money"),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(350, 50)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 85, 209, 89)),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white, fontSize: 16)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onTabTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_balance_wallet, color: Colors.black),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.explore, color: Colors.black),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.qr_code, color: Colors.black),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications, color: Colors.black),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings, color: Colors.black),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }
}
