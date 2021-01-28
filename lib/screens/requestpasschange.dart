import 'package:flutter/material.dart';

class RequestPass extends StatefulWidget {
  @override
  _RequestPassState createState() => _RequestPassState();
}

class _RequestPassState extends State<RequestPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Text("Please contact admin to retrieve your password."),
      ),
    );
  }
}
