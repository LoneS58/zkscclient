import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zksc/screens/waiting.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool absorb = false;

  String email = '';
  String password = '';
  String error = '';
  String number = '';
  String country = '';
  String username = '';
  String balance = '';
  bool processing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Request Membership'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Username(Original Name)'),
                  validator: (val) =>
                      val.length < 6 ? "Enter a valid username" : null,
                  onChanged: (val) {
                    setState(() => username = val.toUpperCase());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
                child: TextFormField(
                  controller: _pass,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (a) => a.length < 6
                      ? "Enter a password with more than 6 characters"
                      : null,
                  onChanged: (a) {
                    setState(() => password = a);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
                child: TextFormField(
                    controller: _confirmPass,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Confirm Password'),
                    obscureText: true,
                    validator: (val) {
                      if (val.isEmpty) return 'Please re-enter.';
                      if (val != _pass.text)
                        return 'Does not match above password.';
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => password = val);
                    }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
                child: TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Phone no. (Ex. +923230000000)'),
                    validator: (_number) =>
                        _number.length < 9 ? "Enter a valid number." : null,
                    onChanged: (_number) {
                      setState(() => number = _number);
                    }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Country'),
                  validator: (val) => val.length == 0
                      ? " Please enter your country name."
                      : null,
                  onChanged: (val) {
                    setState(() => country = val);
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Balance'),
                    validator: (val) => val.isEmpty || val == "" || val == " "
                        ? " Please enter an amount."
                        : null,
                    onChanged: (val) {
                      setState(() => balance = val);
                    },
                  )),
              Text(error),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: AbsorbPointer(
                  absorbing: absorb,
                  child: RaisedButton(
                    color: Colors.black,
                    onPressed: processing == true
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                email = email.trim();
                                password = password.trim();
                                processing = true;
                                absorb = true;
                              });
                              // Signup logic////////////////////////////////////////////////
                              final _body = {
                                "username": "$username",
                                "email": "$email",
                                "password": "$password",
                                "number": "$number",
                                "country": "$country",
                                "balance": balance,
                                "commrate": "5",
                                "active": "false"
                              };
                              var url =
                                  'http://89.40.11.242:8000/members/signup';
                              http.Response response =
                                  await http.post(url, body: _body);
                              if (response.statusCode == 409) {
                                Map data = jsonDecode(response.body);
                                setState(() {
                                  error = data["message"];
                                  absorb = false;
                                  processing = false;
                                });
                                print(response.statusCode);
                              } else if (response.statusCode == 201) {
                                print(response.statusCode);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Waiting()),
                                );
                              } else if (response.statusCode == 500) {
                                print(response.statusCode);
                                Map data = jsonDecode(response.body);
                                setState(() {
                                  error = data["error"];
                                  absorb = false;
                                  processing = false;
                                });
                              } else {
                                setState(() {
                                  error = "Something is wrong";
                                  absorb = false;
                                  processing = false;
                                });
                              }
                            }
                          },

                    ///////////////////////////////////////////////////////////
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    padding: EdgeInsets.fromLTRB(120, 20, 120, 20),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
