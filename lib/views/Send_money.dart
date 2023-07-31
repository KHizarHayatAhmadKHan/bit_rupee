import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class send_money extends StatefulWidget {
  final int senderId;
  final String walletaddress;

  const send_money(
      {Key? key, required this.senderId, required this.walletaddress})
      : super(key: key);

  @override
  State<send_money> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<send_money> {
  final _formKey = GlobalKey<FormState>();
  String _amount = '';
  String _receiverId = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse(
        'http://172.16.2.222:8080/bitrupee/api/transaction/${widget.senderId}/$_receiverId/$_amount',
      );

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Money transferred successfully!'),
                duration: Duration(seconds: 2),
              ),
            );

            await Future.delayed(Duration(seconds: 3));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Money transfer failed! Please try again.'),
                duration: Duration(seconds: 2),
              ),
            );
            await Future.delayed(Duration(seconds: 1));
            Navigator.pop(context);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Money transfer failed! Please try again.'),
              duration: Duration(seconds: 2),
            ),
          );
          await Future.delayed(Duration(seconds: 1));
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Money transfer failed! Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
        await Future.delayed(Duration(seconds: 1));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Send Money",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(),
              Icon(Icons.wallet, color: Colors.green, size: 78),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount to send',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _amount = value!;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Account number',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _receiverId = value!;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
