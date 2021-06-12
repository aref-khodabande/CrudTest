
import 'package:aref_khodabande_crud_test/Customer.dart';
import 'package:aref_khodabande_crud_test/main.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class CustomerList extends StatefulWidget {
  @override
  CustomerListState createState() => CustomerListState();
}

class CustomerListState extends State<CustomerList> {
//get all saved data in DB
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,

          title: Text(
            'Saved List',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: EnhancedFutureBuilder(
          future: customers(),
          rememberFutureResult: false,
          whenDone: (List<Customer> customersList) =>
              CustomersList(customers: customersList),
          whenError: (Object error) {
            print(error);
            return Container();
          },
          whenNotDone: CircularProgressIndicator(),
        ));
  }
}

class CustomersList extends StatefulWidget {
  final List<Customer> customers;

  CustomersList({Key key, this.customers}) : super(key: key);

  @override
  CustomersListState createState() => CustomersListState(customers);
}

class CustomersListState extends State<CustomersList> {
  final List<Customer> customers;

  CustomersListState(this.customers);
  Future<void> deleteCustomer(email,index) async {
    final db = await database;
    await db.delete('customers', where: "email = ?", whereArgs: [email]).
    then((_) =>
        setState(() {
          customers.removeAt(index);
        })

    );
  }
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 48.0),
      itemCount: customers.length,
      addAutomaticKeepAlives: false,
      shrinkWrap: true,
      cacheExtent: 1000,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: const EdgeInsets.only(
                right: 8.0, top: 8.0, left: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[100], width: 0.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0.0, 5.0), // changes position of shadow
                ),
              ],
            ),
            child: personWidget(customers[index],index));
      },
    );
  }

  Widget personWidget(Customer customer,index) {
    return ListTile(
        trailing:
        IconButton(icon: Icon(Icons.delete_forever),
        onPressed: ()=> deleteCustomer(customer.email,index),),
        leading: Icon(
          CupertinoIcons.person_crop_circle_fill,
          size: 30,
          color: Colors.blue,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'FirstName : ' + customer.firstName.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'lastName : ' + customer.lastName.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'dateOfBirth : ' + customer.dateOfBirth.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'phoneNumber : ' + customer.phoneNumber.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'email : ' + customer.email.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'bankAccountNumber : ' + customer.bankAccountNumber.toString(),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ));
  }
}
