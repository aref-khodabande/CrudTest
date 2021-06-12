import 'dart:io';
import 'package:aref_khodabande_crud_test/customer_list.dart';
import 'package:aref_khodabande_crud_test/data_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TabBarPage extends StatefulWidget {


  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }


  void dispose() {
    super.dispose();
  }

  @override
  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = SnackBar(
    content: Text(
      'برای خروج دوباره دکمه بازگشت را فشار دهید .',
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
    ),
    duration: snackBarDuration,
  );

  DateTime backButtonPressTime;

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    exit(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () => handleWillPop(context),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(

                extendBody: true,
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DataForm(),
                    CustomerList(),

                  ],
                ),
                bottomNavigationBar: customBottomNavigationBar(context),
                backgroundColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
  Widget customBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.2),
      child: Container(
        color: Colors.white,
        height: 45.0,
        width: MediaQuery.of(context).size.width,
        child: TabBar(
          physics: NeverScrollableScrollPhysics(),
          isScrollable: false,
          labelPadding: EdgeInsets.all(0),
          tabs: [

            Tab(icon: Icon(Icons.ac_unit_outlined),),
            Tab(icon: Icon(Icons.menu),),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
            indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.purple, width: 2.0),
          insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 44.0),
        ),
         indicatorSize: TabBarIndicatorSize.tab,

        ),
      ),
      color: Colors.grey,
    );
  }
}