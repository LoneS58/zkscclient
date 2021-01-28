import 'dart:io';
import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(child: Text('Waiting Area')),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey,
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 150, 10, 0),
            child: Center(
                child: Column(
              children: <Widget>[
                Text(
                  'Thank you for joining Zia Khatri Stocks Consulting',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'We would contact you within the next 48 hours to validate your request and approve the creation of your account so you may sign in after confirmation.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  color: Colors.black,
                  child: Text(
                    'Close application',
                    style: TextStyle(fontSize: 18, color: Colors.grey[200]),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            ))));
  }
}
