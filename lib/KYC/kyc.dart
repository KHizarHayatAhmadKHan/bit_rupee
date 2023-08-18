import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:file_picker/file_picker.dart';

class KYC_Form extends StatefulWidget {
  const KYC_Form({super.key});

  @override
  State<KYC_Form> createState() => _KYC_FormState();
}

class _KYC_FormState extends State<KYC_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _StreetAddress = '';
  String _ProvinceName = '';
  String _CityName = '';
  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectStatus;
  String? _selectOption;
  bool _isChecked = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Form submitted');
    }
  }

  void _handleGenderValueChanged(String? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _handleValueChanged(String? value) {
    setState(() {
      _selectedMaritalStatus = value;
    });
  }

  void _handleStatus(String? value) {
    setState(() {
      _selectStatus = value;
    });
  }

  void _handleOption(String? value) {
    setState(() {
      _selectOption = value;
    });
  }

  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
  }

  String _selectedNationality = 'United States';

  final List<String> _nationalities = [
    'United States',
    'Pakistan',
    'United Kingdom',
    'Canada',
    'Australia',
    'Other'
  ];

  Map<String, bool> _checkBoxValues = {
    'Passport': false,
    'Driving License': false,
    'Registered Lease': false,
    'Latest Telephone Bill': false,
    'Latest Gas Bill': false,
    'Latest Electricity Bill': false,
    'Ration Card': false,
    'Voter Identity Card': false,
    'Latest Bank Account Statement/Passbook': false,
  };

  // void _handleDrop(dynamic droppedFiles) {
  //   if (droppedFiles is List<PlatformFile>) {
  //     List<PlatformFile> platformFiles = droppedFiles;
  //     for (var file in platformFiles) {
  //       print('Dropped file: ${file.name}');
  //     }
  //   }
  // }

  List<String> droppedFiles = [];

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
          "KYC Form",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                padding: EdgeInsets.all(35.0),
                color: const Color.fromARGB(255, 15, 34, 49),
                child: const Text(
                  'A. Identity Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  '1. Name of the Applicant',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 16.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (value) => _firstName = value!,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 16.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        onSaved: (value) => _lastName = value!,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '2. Father/Spouse Name',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 16.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (value) => _firstName = value!,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 16.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        onSaved: (value) => _lastName = value!,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        '2a. Gender',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '2b. Marital Status',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        RadioListTile(
                          title: Text('Male'),
                          value: 'Option 1',
                          groupValue: _selectedGender,
                          onChanged: _handleGenderValueChanged,
                        ),
                        RadioListTile(
                          title: Text('Female'),
                          value: 'Option 2',
                          groupValue: _selectedGender,
                          onChanged: _handleGenderValueChanged,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        RadioListTile(
                          title: Text('Single'),
                          value: 'Option 1',
                          groupValue: _selectedMaritalStatus,
                          onChanged: _handleValueChanged,
                        ),
                        RadioListTile(
                          title: Text('Married'),
                          value: 'Option 2',
                          groupValue: _selectedMaritalStatus,
                          onChanged: _handleValueChanged,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '2c.  Date of Birth',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: 485.0,
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date (MM/dd/yyyy)',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 16.0)),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    onTap: () => _selectDate(context),
                    readOnly: true,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '3.  Nationality',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: 485.0,
                  height: 55,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 128, 125, 125)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: _selectedNationality,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedNationality = newValue!;
                        });
                      },
                      items: _nationalities
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '4.  Status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RadioListTile(
                title: Text('Resident Individual'),
                value: 'Option 1',
                groupValue: _selectStatus,
                onChanged: _handleStatus,
              ),
              RadioListTile(
                title: Text('Non Resident'),
                value: 'Option 2',
                groupValue: _selectStatus,
                onChanged: _handleStatus,
              ),
              RadioListTile(
                title: Text('Foreign National'),
                value: 'Option 3',
                groupValue: _selectStatus,
                onChanged: _handleStatus,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 100.0,
                padding: EdgeInsets.all(35.0),
                color: const Color.fromARGB(255, 15, 34, 49),
                child: const Text(
                  'B. Address Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  '1. Address for Correspondence',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 16.0))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Street Address';
                    }
                    return null;
                  },
                  onSaved: (value) => _StreetAddress = value!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Street Address',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 16.0))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Street Address Line 2',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 16.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city name';
                              }
                              return null;
                            },
                            onSaved: (value) => _CityName = value!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'City',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 16.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your State / Province name';
                              }
                              return null;
                            },
                            onSaved: (value) => _ProvinceName = value!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'State / Province',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 16.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Postal / Zip Code';
                              }
                              return null;
                            },
                            onSaved: (value) => _CityName = value!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Postal / Zip Code',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 1000.0,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 128, 125, 125)),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: _selectedNationality,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedNationality = newValue!;
                                  });
                                },
                                items: _nationalities
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Country',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '2.  Phone Number',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 540,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 16.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number.';
                      }
                      if (value.length != 11) {
                        return 'Please enter a valid 11-digit phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => _phoneNumber = value!,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Please enter a valid phone number.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '3. Email',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 540,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 16.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid email address.';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'example@example.com',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '4. Proof of Address to be Provided by Applicant',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _checkBoxValues.keys.map((String label) {
                    return CheckboxListTile(
                      title: Text(label),
                      value: _checkBoxValues[label],
                      onChanged: (bool? newValue) {
                        setState(() {
                          _checkBoxValues[label] = newValue!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  '5. Permanent Address of Resident Applicant',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 16.0))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Street Address';
                    }
                    return null;
                  },
                  onSaved: (value) => _StreetAddress = value!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Street Address',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 16.0))),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your Street Address';
                  //   }
                  //   return null;
                  // },
                  // onSaved: (value) => _StreetAddress = value!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Street Address Line 2',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 16.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city name';
                              }
                              return null;
                            },
                            onSaved: (value) => _CityName = value!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'City',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 16.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your State / Province name';
                              }
                              return null;
                            },
                            onSaved: (value) => _ProvinceName = value!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'State / Province',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 16.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Postal / Zip Code';
                              }
                              return null;
                            },
                            onSaved: (value) => _CityName = value!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Postal / Zip Code',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 1000.0,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 128, 125, 125)),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: _selectedNationality,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedNationality = newValue!;
                                  });
                                },
                                items: _nationalities
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Country',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '6. Proof of Address to be Provided by Applicant',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _checkBoxValues.keys.map((String label) {
                    return CheckboxListTile(
                      title: Text(label),
                      value: _checkBoxValues[label],
                      onChanged: (bool? newValue) {
                        setState(() {
                          _checkBoxValues[label] = newValue!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100.0,
                padding: EdgeInsets.all(35.0),
                color: const Color.fromARGB(255, 15, 34, 49),
                child: const Text(
                  'C. File Upload',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              DragTarget<String>(
                builder: (BuildContext context, List<String?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 200.0,
                    child: Center(
                      child: Text(
                        'Drag and drop files here',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
                onAccept: (String data) {
                  setState(() {
                    droppedFiles.add(data);
                  });
                },
              ),
              Container(
                width: double.infinity,
                height: 100.0,
                padding: EdgeInsets.all(35.0),
                color: const Color.fromARGB(255, 15, 34, 49),
                child: const Text(
                  'D. Declaration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'I hereby declare that the information provided in this form is accurate and complete. I confirm that any information is found incorrect and/or incomplete that leads a violation of regulations may initiate legal actions, and I accept that I am the responsible party for any and all charges, penalties and violations.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedGender != Null) {
                      _formKey.currentState!.save();
                      print('Form Submitted');
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 15, 34, 49),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ))),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ]),
      )),
    );
  }
}
