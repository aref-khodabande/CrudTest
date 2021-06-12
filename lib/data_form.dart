import 'package:aref_khodabande_crud_test/Customer.dart';
import 'package:aref_khodabande_crud_test/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DataForm extends StatefulWidget {
  @override
  DataFormState createState() => DataFormState();
}

class DataFormState extends State<DataForm> {
// Does not allow null data to be stored.

  checkData(Customer customer) {

    if(_firstName!=''&&
        _lastName!=''&&
        _dateOfBirth!=''&&
        _phoneNumber!=''&&
        _email!=''&&
        _bankAccountNumber!=''){

      insertCustomer(customer);


    }
    else {
    showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
    top: Radius.circular(25),
    ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 3,
    builder: (BuildContext context) {return emptyField();},
    );
    }

  }

// insert new customer in DB
  Future<void> insertCustomer(Customer customer) async {
    final Database db = await database;
    await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ).then((_) => showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3,
      builder: (BuildContext context) {return saveModal();},
    ),);
    print(await customers());

  }

  // get customer list from DB
  Future<List<Customer>> customers() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('customers');

    return List.generate(maps.length, (i) {
      return Customer(
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
        dateOfBirth: maps[i]['dateOfBirth'].toString(),
        phoneNumber: maps[i]['phoneNumber'],
        email: maps[i]['email'],
        bankAccountNumber: maps[i]['bankAccountNumber'],
      );
    });
  }

  String _firstName='';

  String _lastName='';

  String _dateOfBirth='';

  String _phoneNumber='';

  String _email='';

  String _bankAccountNumber='';

//set Iran to default in phone number field
  String initialCountry = 'IR';
  PhoneNumber number = PhoneNumber(isoCode: 'IR');

// set data taken from user to customer model
  setCustomerData() {
    return Customer(
      firstName: _firstName,
      lastName: _lastName,
      dateOfBirth: _dateOfBirth,
      phoneNumber: _phoneNumber,
      email: _email,
      bankAccountNumber: _bankAccountNumber,
    );
  }

  // clear variable and controller data
  clearData() {
    _firstName = '';
    _lastName = '';
    _dateOfBirth = '';
    _phoneNumber = '';
    _email = '';
    _bankAccountNumber = '';
    firstNameController.clear();
    lastNameController.clear();
    dateOfBirthController.clear();
    phoneNumberController.clear();
    emailController.clear();
    bankAccountNumberController.clear();
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final bankAccountNumberController = TextEditingController();

  firstNameListener() {
    setState(() {
      _firstName = firstNameController.text;
    });
  }

  lastNameListener() {
    setState(() {
      _lastName = lastNameController.text;
    });
  }

  dateOfBirthListener() {
    setState(() {
      _dateOfBirth = dateOfBirthController.text;
    });
  }

  phoneNumberListener() {
    print('phone number is : ${phoneNumberController.text}');
    setState(() {
      _phoneNumber = '0' + phoneNumberController.text;
    });
  }

  emailListener() {
    setState(() {
      _email = emailController.text;
    });
  }

  bankAccountNumberListener() {
    setState(() {
      _bankAccountNumber = bankAccountNumberController.text;
    });
  }

  @override
  void initState() {
    super.initState();

    firstNameController.addListener(firstNameListener);
    lastNameController.addListener(lastNameListener);
    dateOfBirthController.addListener(dateOfBirthListener);
    phoneNumberController.addListener(phoneNumberListener);
    emailController.addListener(emailListener);
    bankAccountNumberController.addListener(bankAccountNumberListener);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    bankAccountNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24.0, left: 32.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'welcome',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 32.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter the required information to continue',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 8.0, top: 32.0, right: 32.0, left: 32.0),
              child: TextFormField(
                controller: firstNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: 'Enter FirstName',
                  labelText: 'FirstName',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 8.0, top: 16.0, right: 32.0, left: 32.0),
              child: TextFormField(
                controller: lastNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: 'Enter LastName',
                  labelText: 'LastName',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 8.0, top: 16.0, right: 32.0, left: 32.0),
              child: TextFormField(
                controller: dateOfBirthController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.cake_outlined,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: '1999',
                  labelText: 'Date of birth',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 8.0, top: 16.0, right: 32.0, left: 32.0),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,

                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: phoneNumberController,
                hintText: '9120000000',
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 8.0, top: 16.0, right: 32.0, left: 32.0),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: 'email@gmail.com',
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  bottom: 8.0, top: 16.0, right: 32.0, left: 32.0),
              child: TextFormField(
                controller: bankAccountNumberController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.credit_card_outlined,
                    color: Colors.blue,
                  ),
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: 'Enter bank account number',
                  labelText: 'Bank account number',
                ),
              ),
            ),
            TextButton(
                onPressed: () =>  checkData( setCustomerData()) ,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    border: Border.all(
                        color: Colors.purple, width: 1.0), // set border width
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      bottom: 8.0, top: 16.0, right: 32.0, left: 32.0),
                  child: Text(
                    'save',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(right: 42.0, left: 42.0),
              height: 1,
              color: Colors.grey[200],
            ),
            TextButton(
              onPressed: () => clearData(),
              child: Text('cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveModal() {
    return Container(
      height: 220,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 3,
            color: Colors.grey[400],
            margin: EdgeInsets.only(top: 8),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
                alignment: Alignment.center,
                child: Text(
                  'Dear user',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
                alignment: Alignment.center,
                child: Text(
                  'The entered information was saved successfully.',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                  onPressed: () {
                    clearData();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                          color: Colors.purple, width: 1.0), // set border width
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        bottom: 32.0, top: 16.0, right: 32.0, left: 32.0),
                    child: Text(
                      'ok',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget emptyField() {
    return Container(
      height: 240,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 3,
            color: Colors.grey[400],
            margin: EdgeInsets.only(top: 8),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
                alignment: Alignment.center,
                child: Text(
                  'Dear user',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
                alignment: Alignment.center,
                child: Text(
                  'No field should be empty.',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                          color: Colors.purple, width: 1.0), // set border width
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        bottom: 22.0, top: 16.0, right: 32.0, left: 32.0),
                    child: Text(
                      'ok',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
