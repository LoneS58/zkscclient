import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddTrade extends StatefulWidget {
  final String username;
  final String email;
  final String id;
  AddTrade(
      {Key key,
      @required this.email,
      @required this.username,
      @required this.id})
      : super(key: key);
  @override
  _AddTradeState createState() => _AddTradeState();
}

class _AddTradeState extends State<AddTrade> {
  //Constants
  bool br;
  bool selecting = true;
  bool processing = false;
  final _formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  String buydate;
  String scrip;
  String quantity;
  String soldpending = "PENDING";
  String buyquantity;
  var brate;
  var buyamount;
  String divbon = "";
  String saledate = "";
  String salerate = 0.toString();
  String saleamount = 0.toString();
  String commrate;
  String cgtrate = "0";
  String pls = "0";
  String netprofit = "0";
  String commamount = "0";
  String status = "u";
  String err = "";
  var balance;
  List scrips;
  var f = new NumberFormat("###,##0.00", "en_US");
  var q = new NumberFormat("###,##0", "en_US");

  void checkbal() async {
    http.Response response =
        await http.get("https://zksc.herokuapp.com/members/${widget.id}");
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (this.mounted) {
        setState(() {
          commrate = data["member"]["commrate"].toString();
          balance = data["member"]["balance"];
          print(balance);
        });
        print(data);
      }
    }
  }

  String setDate() {
    setState(() {
      buydate = "${now.month}-${now.day}-${now.year}";
    });
    return buydate;
  }

  @override
  void initState() {
    super.initState();
    setDate();
    checkbal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add trade"),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      backgroundColor: Colors.green[200],
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                elevation: 10,
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                color: Colors.green[100],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                          child: Text(
                            "Please avoid making errors when entering trades",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                          child: Text(
                            "Username:  ${widget.username}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                          child: Text(
                            "Email:          ${widget.email}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                          child: Text(
                            () {
                              if (balance != null) {
                                return "Balance:      PKR ${f.format(balance).toString()}";
                              } else {
                                return "Balance:      Fetching...";
                              }
                            }(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 30, 10),
                          child: Text(
                            "Buying:",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Datepicker for buy
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text(
                            "Buy-date:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                              child: Text(
                                buydate,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
                              child: Text(
                                "(mm-dd-yyyy)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: RaisedButton(
                              elevation: 2,
                              color: Colors.green[200],
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(now.year - 20),
                                        lastDate: DateTime(now.year + 5))
                                    .then((value) {
                                  setState(() {
                                    buydate =
                                        "${value.month}-${value.day}-${value.year}";
                                  });
                                });
                              },
                              child: Text("Edit")),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                      child: TextFormField(
                        validator: (value) =>
                            scrips.contains(value.trim().toUpperCase())
                                ? null
                                : "Please enter a valid scrip name",
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Scrip",
                            labelStyle: TextStyle(fontSize: 17)),
                        onChanged: (value) {
                          setState(() {
                            scrip = value.trim().toUpperCase();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) => value != null
                            ? null
                            : "Please enter quantity of shares bought.",
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Quantity",
                            labelStyle: TextStyle(fontSize: 17)),
                        onChanged: (value) {
                          setState(() {
                            quantity = value;
                          });
                        },
                      ),
                    ),
                    ////
                    () {
                      if (selecting == true) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("-----------------   "),
                                Text(
                                  "Choose one",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("   -----------------"),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RaisedButton(
                                      color: Colors.green[200],
                                      onPressed: () {
                                        setState(() {
                                          selecting = false;
                                          br = true;
                                        });
                                      },
                                      child: Text("Enter buy rate"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 10),
                                    child: RaisedButton(
                                      color: Colors.green[200],
                                      onPressed: () {
                                        setState(() {
                                          selecting = false;
                                          br = false;
                                        });
                                      },
                                      child: Text("Enter buy amount"),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        if (br == true) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 30, 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value != null
                                      ? null
                                      : "Please enter rate at which each share was bought.",
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Buy rate",
                                      labelStyle: TextStyle(fontSize: 17)),
                                  onChanged: (value) {
                                    setState(() {
                                      brate = double.parse(value);
                                      buyamount = double.parse(value) *
                                          int.parse(quantity);
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    child: Text(
                                      "Buy Amount:",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 20, 0),
                                    child: Text(
                                      () {
                                        if (buyamount == null ||
                                            buyamount == 0) {
                                          return "0";
                                        } else {
                                          return "PKR ${f.format(buyamount).toString()}";
                                        }
                                      }(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        } else if (br == false) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 30, 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value != null
                                      ? null
                                      : "Please enter rate at which each share was bought.",
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Buying Amount",
                                      labelStyle: TextStyle(fontSize: 17)),
                                  onChanged: (value) {
                                    setState(() {
                                      buyamount = double.parse(value);
                                      brate = double.parse(value) /
                                          int.parse(quantity);
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    child: Text(
                                      "Buy Rate:",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 20, 0),
                                    child: Text(
                                      () {
                                        if (brate == null || brate == 0) {
                                          return "0";
                                        } else {
                                          return "PKR ${f.format(brate).toString()}";
                                        }
                                      }(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                      }
                    }(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Text(
                        err,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(children: [
                  Expanded(
                    child: RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        color: Colors.green[400],
                        child: Text("Save trade"),
                        onPressed: processing == true
                            ? null
                            : () async {
                                setState(() {
                                  processing = true;
                                });
                                http.Response response = await http
                                    .get("https://zksc.herokuapp.com/scrips");
                                if (response.statusCode == 200) {
                                  print("stage A");
                                  setState(() {
                                    scrips = jsonDecode(response.body);
                                  });
                                  if (_formKey.currentState.validate()) {
                                    print("stage B");
                                    if (balance >= buyamount) {
                                      print("stage 1");
                                      print(buyamount.runtimeType);
                                      var bal = balance - buyamount;
                                      print(bal);
                                      List<Map> patch = [
                                        {
                                          "propName": "balance",
                                          "value": "${bal.toStringAsFixed(2)}"
                                        }
                                      ];
                                      print(patch);
                                      String json1 = jsonEncode(patch);
                                      http.Response response = await http.patch(
                                          "https://zksc.herokuapp.com/members/${widget.id}",
                                          headers: {
                                            "content-type": "application/json"
                                          },
                                          body: json1);
                                      if (response.statusCode == 200) {
                                        print("stage 2");
                                        setState(() {
                                          balance = bal;
                                        });
                                        Map data = {
                                          "username": widget.username,
                                          "email": widget.email,
                                          "divbon": divbon,
                                          "scrip": scrip,
                                          "buydate": buydate,
                                          "qty": quantity,
                                          "buyrate": brate.toStringAsFixed(3),
                                          "buyamount": buyamount,
                                          "soldpending": soldpending,
                                          "saledate": saledate,
                                          "salerate": salerate,
                                          "saleamount": saleamount,
                                          "commrate": commrate,
                                          "cgtrate": cgtrate,
                                          "pls": pls,
                                          "netprofit": netprofit,
                                          "commamount": commamount,
                                          "status": status
                                        };
                                        String json = jsonEncode(data);
                                        http.Response response = await http.post(
                                            "https://zksc.herokuapp.com/trades",
                                            headers: {
                                              "content-type": "application/json"
                                            },
                                            body: json);
                                        if (response.statusCode == 201) {
                                          print("Stage 3");
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        setState(() {
                                          err = "Error: balance request";
                                        });
                                      }
                                    } else {
                                      print("Stage a");
                                      var bal = 0;
                                      print(bal);
                                      List<Map> patch = [
                                        {
                                          "propName": "balance",
                                          "value": "${bal.toStringAsFixed(2)}"
                                        }
                                      ];
                                      print(patch);
                                      String json1 = jsonEncode(patch);
                                      http.Response response = await http.patch(
                                          "https://zksc.herokuapp.com/members/${widget.id}",
                                          headers: {
                                            "content-type": "application/json"
                                          },
                                          body: json1);
                                      if (response.statusCode == 200) {
                                        print("Stage b");
                                        setState(() {
                                          balance = bal;
                                        });
                                        Map data = {
                                          "username": widget.username,
                                          "email": widget.email,
                                          "divbon": divbon,
                                          "scrip": scrip,
                                          "buydate": buydate,
                                          "qty": quantity,
                                          "buyrate": brate.toStringAsFixed(3),
                                          "buyamount": buyamount,
                                          "soldpending": soldpending,
                                          "saledate": saledate,
                                          "salerate": salerate,
                                          "saleamount": saleamount,
                                          "commrate": commrate,
                                          "cgtrate": cgtrate,
                                          "pls": pls,
                                          "netprofit": netprofit,
                                          "commamount": commamount,
                                          "status": status
                                        };
                                        String json = jsonEncode(data);
                                        http.Response response = await http.post(
                                            "https://zksc.herokuapp.com/trades",
                                            headers: {
                                              "content-type": "application/json"
                                            },
                                            body: json);
                                        if (response.statusCode == 201) {
                                          print("Stage c");
                                          Navigator.pop(context);
                                        } else {
                                          print(response.statusCode);
                                          print(response.body);
                                          print(
                                              "Error: Could not place trade.");
                                          setState(() {
                                            err =
                                                "Error: Could not place trade.";
                                            processing = false;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          err = "Error: balance request";
                                          processing = false;
                                        });
                                      }
                                    }
                                  } else {
                                    setState(() {
                                      processing = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    processing = false;
                                    err =
                                        "Please check your internet connection";
                                  });
                                }
                              }),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
