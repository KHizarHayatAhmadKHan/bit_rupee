import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  final int id;
  final String walletaddress;
  final int balance;

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
      body: SingleChildScrollView(
        // child: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.grey,
        //   ),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 7),
              child: AnimatedContainer(
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black),
            label: '',
          ),
        ],
      ),
    );
  }
}
