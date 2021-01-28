import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zksc/screens/dashboard/changepass.dart';
import 'package:zksc/screens/dashboard/editbalance.dart';
import 'package:zksc/screens/dashboard/summary.dart';
import 'package:zksc/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var balance;
  var f = new NumberFormat("###,##0.00", "en_US");
  SharedPreferences logindata;
  Map user;
  Future<Map> setUser() async {
    logindata = await SharedPreferences.getInstance();
    String credentials = logindata.getString("credentials");
    setState(() {
      user = jsonDecode(credentials);
    });
    getBal();
    print(user);
    return user;
  }

  void getBal() async {
    http.Response response =
        await http.get("https://zksc.herokuapp.com/members/${user["_id"]}");
    if (response.statusCode == 200) {
      setState(() {
        Map json = jsonDecode(response.body);
        balance = json["member"]["balance"];
      });
    }
  }

  @override
  void initState() {
    setUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Scaffold(
            backgroundColor: Colors.blue[200],
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Card(
                    color: Colors.lightBlue[50],
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ClientSummary(
                                                email: user["email"],
                                                username: user["username"],
                                                url:
                                                    "https://zksc.herokuapp.com/members/${user["_id"]}")));
                                  },
                                  child: Text("Position Summary"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  "Client Info",
                                  style: TextStyle(
                                      color: Colors.blue[300],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 3),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text("Username: ${user["username"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text("Email: ${user["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text("Number: ${user["number"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text("Country: ${user["country"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(() {
                                  if (user["active"] == "true") {
                                    return "Status: Active member";
                                  } else {
                                    return "Status: Unactive member";
                                  }
                                }(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                  child: () {
                                    if (balance == null) {
                                      return Text("Balance: Fetching...",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ));
                                    } else {
                                      return Text(
                                          "Balance: ${f.format(balance)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ));
                                    }
                                  }()),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: RaisedButton(
                                onPressed: balance == null
                                    ? null
                                    : () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditBalance(
                                                            id: user["_id"],
                                                            balance: balance)))
                                            .then((value) => getBal());
                                      },
                                child: Text("Edit"),
                                color: Colors.blue[200],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangePass(credentials: user)));
                                  },
                                  child: Text("Change Password"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    print(logindata.getBool('login'));
                                    logindata.setBool('login', true);
                                    logindata.remove('credentials');
                                    logindata.remove('email');
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Text("Logout"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
