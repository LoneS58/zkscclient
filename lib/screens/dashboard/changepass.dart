import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  final Map credentials;
  @override
  ChangePass({Key key, @required this.credentials}) : super(key: key);
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  void checkcredentials() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    checkcredentials();
    super.initState();
  }

  SharedPreferences logindata;
  final _formKey = GlobalKey<FormState>();
  TextEditingController confpass = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool matched = false;
  String err = "";
  var password;
  bool _showPassword = false;
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Changing password"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue[100],
        body: () {
          if (matched == false) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child: Card(
                      elevation: 20,
                      color: Colors.blue[200],
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextField(
                          controller: confpass,
                          obscureText: !this._showPassword,
                          decoration: InputDecoration(
                              suffixIcon: FlatButton(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: Text(() {
                                    if (!this._showPassword) {
                                      return "SHOW";
                                    } else {
                                      return "HIDE";
                                    }
                                  }()),
                                ),
                                onPressed: () {
                                  setState(() =>
                                      this._showPassword = !this._showPassword);
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "Current Password",
                              labelStyle: TextStyle(fontSize: 17)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                              elevation: 20,
                              padding: EdgeInsets.all(15),
                              color: Colors.blue[300],
                              child: Text("Confirm Password"),
                              onPressed: () {
                                if (widget.credentials["password"] ==
                                    confpass.text) {
                                  setState(() {
                                    matched = true;
                                  });
                                } else {
                                  setState(() {
                                    err =
                                        "Password did not match. Retry entering password or for support, contact Admin";
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      err,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  )
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: Card(
                          elevation: 20,
                          color: Colors.blue[200],
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
                                child: TextFormField(
                                  controller: _pass,
                                  decoration: InputDecoration(
                                      suffixIcon: FlatButton(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Text(() {
                                            if (!this._showPassword1) {
                                              return "SHOW";
                                            } else {
                                              return "HIDE";
                                            }
                                          }()),
                                        ),
                                        onPressed: () {
                                          setState(() => this._showPassword1 =
                                              !this._showPassword1);
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelText: "New Password",
                                      labelStyle: TextStyle(fontSize: 17)),
                                  obscureText: !this._showPassword1,
                                  validator: (a) => a.length < 6
                                      ? "Enter a password with more than 6 characters"
                                      : null,
                                  onChanged: (a) {
                                    setState(() => password = a);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                                child: TextFormField(
                                    controller: _confirmPass,
                                    decoration: InputDecoration(
                                        suffixIcon: FlatButton(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Text(() {
                                              if (!this._showPassword2) {
                                                return "SHOW";
                                              } else {
                                                return "HIDE";
                                              }
                                            }()),
                                          ),
                                          onPressed: () {
                                            setState(() => this._showPassword2 =
                                                !this._showPassword2);
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: "Re-Enter Password",
                                        labelStyle: TextStyle(fontSize: 17)),
                                    obscureText: !this._showPassword2,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return 'Please re-enter.';
                                      if (val != _pass.text)
                                        return 'Does not match above password.';
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    }),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: RaisedButton(
                                elevation: 20,
                                padding: EdgeInsets.all(15),
                                color: Colors.blue[300],
                                child: Text("Change Password"),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    List<Map> edit = [
                                      {
                                        "propName": "password",
                                        "value": password
                                      }
                                    ];
                                    String json = jsonEncode(edit);
                                    http.Response response = await http.patch(
                                        "http://89.40.11.242:8000/members/${widget.credentials["_id"]}",
                                        headers: {
                                          "content-type": "application/json"
                                        },
                                        body: json);
                                    if (response.statusCode == 200) {
                                      Map creds;
                                      setState(() {
                                        creds = widget.credentials;
                                        creds["password"] = password;
                                      });
                                      String json = jsonEncode(creds);
                                      logindata.remove("credentials");
                                      logindata.setString("credentials", json);
                                      Navigator.pop(context);
                                    } else {
                                      print("Error updating the password");
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }());
  }
}
