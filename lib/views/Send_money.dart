// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class send_money extends StatefulWidget {
  const send_money({Key? key}) : super(key: key);

  @override
  State<send_money> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<send_money> {
  final _formKey = GlobalKey<FormState>();
  String _amount = '';
  String _user_id = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Now you can use the _amount and _user_id variables as needed, e.g., send them to an API or process the form data.
      print('Amount to send: $_amount');
      // Your logic to send money here...
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
              SizedBox(
                height: 12,
              ),
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
                    _user_id = value!;
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
                              MaterialStateProperty.all<Color>(Colors.green)),
                      onPressed: () {},
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
