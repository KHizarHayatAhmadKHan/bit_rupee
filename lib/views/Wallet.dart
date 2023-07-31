// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class Wallet extends StatefulWidget {
//   const Wallet({super.key});

//   @override
//   State<Wallet> createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> {
//   bool _isExpanded = false;
//  int _currentIndex = 0; // Index of the currently selected tab
//  // Function to switch between tabs
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _toggleContainer() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.wallet),
//             onPressed: () {
//               // Handle search action press 
//             },
//           ),
//         ],

//         title: Text('Wallet'),
//         centerTitle: true,
//         leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
//         // color: Colors.,
//         // size: 30,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey,
           
//           ),
//           // height:double.infinity,
//           // width: double.infinity,
          
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20, 10, 20, 450),
//             child: Column(
//               children: [
//                AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                    height: _isExpanded ? 400.0 : 170.0, // Set the desired expanded and collapsed heights
//                   decoration: BoxDecoration(
                    
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white, // Shadow color
//                       blurRadius: .5, // Blur radius
//                       // Spread radius (optional)
//                       // offset: Offset(2, 4), // Shadow offset (optional)
                      
//                     ),
                    
//                   ],
                  
//                 ),
//                   child: Column(
//                     children: [
//                       SingleChildScrollView(
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             SizedBox(
//                               height: 70.0,
//                               width: 10.0,
//                             ),
//                             // SizedBox(width: 30.0,),
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   child: Icon(Icons.wallet_outlined),
//                                 ),
//                                 SizedBox(width: 10.0),
//                                 Text("Total Wallet Balance",
//                                     style: TextStyle(fontSize: 12)),
//                               ],
//                             ),
                
//                             SizedBox(
//                               width: 90.0,
//                             ),
//                             Text("BTR", style: TextStyle(fontSize: 15)),
//                           ],
//                         ),
      
//                       ),
//                            Text("BTR  8888", style: TextStyle(fontSize: 30),),
//                      Center(
//                       // child: IconButton(onPressed: (){}, icon:Icon(Icons.keyboard_arrow_down_rounded)),
//        child: 
          
//         IconButton(
//               icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
//               onPressed: _toggleContainer,
//             ),
        
//                      )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 4.0,),
//                  ElevatedButton(onPressed: (){}, child:Text("Send Money"), style: ButtonStyle(
//           minimumSize: MaterialStateProperty.all(Size(350, 50)),
//           backgroundColor: MaterialStateProperty.all(Colors.lightGreen[600]),
//           textStyle: MaterialStateProperty.all(TextStyle(
//         color: Colors.white,
//         fontSize: 16,
//           )),
//       shape: MaterialStateProperty.all(RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//           )),
         
      
//         ),
//       )
//               ],
//             ),
//           ),
      
          
//         ),
//       ),
//         bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_balance_wallet,color: Colors.black),
//           label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore,color: Colors.black),
//              label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.qr_code,color: Colors.black),
//              label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications,color: Colors.black),
//              label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings,color: Colors.black,),
//              label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.wallet),
            onPressed: () {
              // Handle search action press
            },
          ),
        ],
        title: Text('Wallet'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 450),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _isExpanded ? 400.0 : 170.0, // Set the desired expanded and collapsed heights
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, // Shadow color
                        blurRadius: .5, // Blur radius
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
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.wallet_outlined),
                                ),
                                SizedBox(width: 10.0),
                                Text("Total Wallet Balance", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            SizedBox(
                              width: 90.0,
                            ),
                            Text("BTR", style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      Text("BTR ${widget.balance}", style: TextStyle(fontSize: 30)),
                      Center(
                        child: IconButton(
                          icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                          onPressed: _toggleContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sendmoney');
                  },
                  child: Text("Send Money"),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(350, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.lightGreen[600]),
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white, fontSize: 16)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  ),
                )
              ],
            ),
          ),
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
