import 'package:flutter/material.dart';
import 'package:zksc/screens/dashboard/holding.dart';
import 'package:zksc/screens/dashboard/profile.dart';
import 'package:zksc/screens/dashboard/salecall.dart';
import 'package:zksc/screens/dashboard/sold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences logindata;
  String email;
  String credentials;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email');
      credentials = logindata.getString('credentials');
    });
  }

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return SaleCall();
      case 1:
        return Holding();
      case 2:
        return Sold();
      case 3:
        return Profile();
        break;

      default:
        return SaleCall();
    }
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
                label: 'Sale Call',
                backgroundColor: Colors.black
                ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
                label: 'Holding',
                backgroundColor: Colors.black
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
                backgroundColor: Colors.black
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.black),
          ]),
    );
  }
}
