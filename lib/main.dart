import 'package:aref_khodabande_crud_test/TabBarPage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
var database;
void main() async{
  runApp(MyApp());
  //open  and create data base
  database = openDatabase(
    join(await getDatabasesPath(), 'customer_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE customers(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, dateOfBirth INTEGER, phoneNumber TEXT, email TEXT type UNIQUE,bankAccountNumber TEXT)",
      );
    },
    version: 1,
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: TabBarPage(),
    );
  }
}
