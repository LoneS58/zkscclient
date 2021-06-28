import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SellTrade extends StatefulWidget {
  final String id;
  final Map trade;
  @override
  SellTrade({Key key, @required this.id, @required this.trade})
      : super(key: key);
  @override
  _SellTradeState createState() => _SellTradeState();
}

class _SellTradeState extends State<SellTrade> {
  bool processing = false;
  String err = "";
  DateTime snow = DateTime.now();
  bool decision = false;
  bool newdecision = false;
  bool ratedes = false;
  final _formKey = GlobalKey<FormState>();
  bool allmethod;
  var username;
  var email;
  var divbon;
  var scrip;
  var buydate;
  var qty;
  var buyrate;
  var buyamount;
  var soldpending;
  var saledate;
  var salerate;
  var saleamount;
  var commrate;
  var cgtrate;
  var pls;
  var netprofit;
  var commamount;
  var status;
  var url;
  var balance;
  //custom var
  var quantity;
  var newquantity;
  var newbuyamount;
  var f = new NumberFormat("###,##0.00", "en_US");
  var q = new NumberFormat("###,##0", "en_US");

  String setDate() {
    setState(() {
      saledate = "${snow.month}-${snow.day}-${snow.year}";
    });
    return saledate;
  }

  void settingpr() {
    if (widget.trade != null) {
      username = widget.trade["username"];
      email = widget.trade["email"];
      divbon = widget.trade["divbon"];
      scrip = widget.trade["scrip"];
      buydate = widget.trade["buydate"];
      qty = widget.trade["qty"];
      buyrate = widget.trade["buyrate"];
      buyamount = widget.trade["buyamount"];
      soldpending = widget.trade["soldpending"];
      salerate = widget.trade["salerate"];
      saleamount = widget.trade["saleamount"];
      saledate = widget.trade["saledate"];
      commrate = widget.trade["commrate"];
      cgtrate = widget.trade["cgtrate"];
      pls = widget.trade["pls"];
      netprofit = widget.trade["netprofit"];
      commamount = widget.trade["commamount"];
      status = widget.trade["status"];
      url = widget.trade["url"];
    }
    setDate();
  }

  void getbal() async {
    http.Response response =
        await http.get("http://89.40.11.242:8000/members/${widget.id}");
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (this.mounted) {
        setState(() {
          balance = data["member"]["balance"];
        });
      }
      print(widget.trade);
      print(balance);
    }
  }

  @override
  void initState() {
    getbal();
    settingpr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Text("Sell Trade"),
      ),
      backgroundColor: Colors.red[200],
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  color: Colors.red[100],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                            child: Text(
                              () {
                                if (balance != null) {
                                  return "Available balance: PKR ${f.format(balance)}";
                                } else {
                                  return "Available balance: Fetching...";
                                }
                              }(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "Holding - ",
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                            child: Text(
                              "${widget.trade["scrip"]}",
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
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
                              "Quantity:  ${q.format(widget.trade["qty"]).toString()}",
                              style: TextStyle(
                                fontSize: 14,
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
                              "Buy rate:   PKR ${f.format(widget.trade["buyrate"]).toString()}",
                              style: TextStyle(
                                fontSize: 14,
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
                              "Buy amount:   PKR ${f.format(widget.trade["buyamount"]).toString()}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                () {
                  if (decision == false) {
                    return Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.red[300],
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Text("Sell all"),
                                  onPressed: () {
                                    setState(() {
                                      decision = true;
                                      allmethod = true;
                                    });
                                  },
                                ))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.red[300],
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Text("Sell custom quantity"),
                                  onPressed: () {
                                    setState(() {
                                      decision = true;
                                      allmethod = false;
                                    });
                                  },
                                ))
                              ],
                            )),
                      ],
                    );
                  } else {
                    if (allmethod == true) {
                      return Card(
                        elevation: 10,
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        color: Colors.red[100],
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Text(
                                    "Sale-date:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 20, 0),
                                      child: Text(
                                        saledate,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 20, 20),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: RaisedButton(
                                      elevation: 2,
                                      color: Colors.red[200],
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate:
                                                    DateTime(snow.year - 20),
                                                lastDate:
                                                    DateTime(snow.year + 5))
                                            .then((value) {
                                          setState(() {
                                            saledate =
                                                "${value.month}-${value.day}-${value.year}";
                                          });
                                        });
                                      },
                                      child: Text("Edit")),
                                )
                              ],
                            ),
                            () {
                              if (newdecision == false) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              color: Colors.red[300],
                                              onPressed: () {
                                                setState(() {
                                                  newdecision = true;
                                                  ratedes = true;
                                                });
                                              },
                                              child: Text("Sale rate"),
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
                                              color: Colors.red[300],
                                              onPressed: () {
                                                setState(() {
                                                  newdecision = true;
                                                });
                                              },
                                              child: Text("Sale amount"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                if (ratedes == true) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 30, 10),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) =>
                                              value != null || value != ""
                                                  ? null
                                                  : "Please enter the salerate",
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Sale Rate",
                                              labelStyle:
                                                  TextStyle(fontSize: 17)),
                                          onChanged: (value) {
                                            if (value != null || value != "") {
                                              setState(() {
                                                soldpending = "S";
                                              });
                                            } else {
                                              setState(() {
                                                soldpending = "PENDING";
                                              });
                                            }
                                            setState(() {
                                              salerate = double.parse(value);
                                              saleamount =
                                                  double.parse(value) * qty;
                                              pls = saleamount - buyamount;
                                              commamount = pls / 100 * commrate;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text(
                                              "Sale amount:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 20, 0),
                                            child: Text(
                                              () {
                                                if (salerate == null ||
                                                    salerate == 0 ||
                                                    salerate == "0" ||
                                                    soldpending == "PENDING") {
                                                  return " PKR 0";
                                                } else {
                                                  return "PKR ${f.format(saleamount)}";
                                                }
                                              }(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 30, 10),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) => value != null ||
                                                  value != ""
                                              ? null
                                              : "Please enter the saleamount",
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Sale Amount",
                                              labelStyle:
                                                  TextStyle(fontSize: 17)),
                                          onChanged: (value) {
                                            if (value != null || value != "") {
                                              setState(() {
                                                soldpending = "S";
                                              });
                                            } else {
                                              setState(() {
                                                soldpending = "PENDING";
                                              });
                                            }
                                            setState(() {
                                              saleamount = int.parse(value);
                                              salerate = int.parse(value) / qty;
                                              pls =
                                                  int.parse(value) - buyamount;
                                              commamount = pls / 100 * commrate;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text(
                                              "Sale rate:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 20, 0),
                                            child: Text(
                                              () {
                                                if (salerate == null ||
                                                    salerate == 0 ||
                                                    salerate == "0" ||
                                                    soldpending == "PENDING") {
                                                  return " PKR 0";
                                                } else {
                                                  return "PKR ${f.format(salerate)}";
                                                }
                                              }(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Profit/Loss:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 20, 0),
                                  child: Text(
                                    () {
                                      if (pls == null ||
                                          pls == 0 ||
                                          pls == "0" ||
                                          soldpending == "PENDING") {
                                        return " PKR 0";
                                      } else {
                                        return "PKR ${f.format(pls)}";
                                      }
                                    }(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Commission Amount:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 20, 0),
                                  child: Text(
                                    () {
                                      if (commamount == null ||
                                          commamount == 0 ||
                                          commamount == "0" ||
                                          soldpending == "PENDING") {
                                        return " PKR 0";
                                      } else {
                                        return "PKR ${f.format(commamount)}";
                                      }
                                    }(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(err,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                10,
                                0,
                                10,
                                10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(15),
                                      onPressed: soldpending == "PENDING" ||
                                              processing == true
                                          ? null
                                          : () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  processing = true;
                                                });
                                                List<Map> data = [
                                                  {
                                                    "propName": "soldpending",
                                                    "value": soldpending
                                                  },
                                                  {
                                                    "propName": "saledate",
                                                    "value": saledate
                                                  },
                                                  {
                                                    "propName": "salerate",
                                                    "value": salerate
                                                  },
                                                  {
                                                    "propName": "commamount",
                                                    "value": commamount
                                                  },
                                                  {
                                                    "propName": "saleamount",
                                                    "value": saleamount
                                                  },
                                                  {
                                                    "propName": "pls",
                                                    "value": pls
                                                  },
                                                  {
                                                    "propName": "status",
                                                    "value": "u"
                                                  },
                                                ];
                                                String json1 = jsonEncode(data);
                                                http.Response response =
                                                    await http.patch(url,
                                                        headers: {
                                                          "content-type":
                                                              "application/json"
                                                        },
                                                        body: json1);
                                                if (response.statusCode ==
                                                    200) {
                                                  var newbal =
                                                      balance + saleamount;
                                                  List<Map> bal = [
                                                    {
                                                      "propName": "balance",
                                                      "value": newbal
                                                    }
                                                  ];
                                                  String patch =
                                                      jsonEncode(bal);
                                                  http.Response response =
                                                      await http.patch(
                                                          "http://89.40.11.242:8000/members/${widget.id}",
                                                          headers: {
                                                            "content-type":
                                                                "application/json"
                                                          },
                                                          body: patch);
                                                  if (response.statusCode ==
                                                      200) {
                                                    Navigator.pop(context);
                                                  } else {
                                                    setState(() {
                                                      err =
                                                          "Problem updating balance";
                                                      processing = false;
                                                    });
                                                  }
                                                } else {
                                                  print(
                                                      "Error: ${response.statusCode}");
                                                  setState(() {
                                                    err = "Error updating";
                                                    processing = false;
                                                  });
                                                }
                                              }
                                            },
                                      child: Text("Save Sell"),
                                      color: Colors.red[200],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Card(
                        elevation: 10,
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        color: Colors.red[100],
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Text(
                                    "Sale-date:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 20, 0),
                                      child: Text(
                                        saledate,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 20, 20),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: RaisedButton(
                                      elevation: 2,
                                      color: Colors.red[200],
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate:
                                                    DateTime(snow.year - 20),
                                                lastDate:
                                                    DateTime(snow.year + 5))
                                            .then((value) {
                                          setState(() {
                                            saledate =
                                                "${value.month}-${value.day}-${value.year}";
                                          });
                                        });
                                      },
                                      child: Text("Edit")),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 30, 10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null &&
                                      int.parse(value) < widget.trade["qty"]) {
                                    return null;
                                  } else {
                                    return "Please enter valid quantity";
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Quantity to sell",
                                    labelStyle: TextStyle(fontSize: 17)),
                                onChanged: (value) {
                                  setState(() {
                                    //posted
                                    newquantity = int.parse(value);
                                    newbuyamount = int.parse(value) * buyrate;
                                    // edited patch

                                    quantity = qty - int.parse(value);
                                    buyamount = quantity * buyrate;
                                  });
                                },
                              ),
                            ),
                            //inserting new rate at this spot
                            () {
                              if (newdecision == false) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              color: Colors.red[300],
                                              onPressed: () {
                                                setState(() {
                                                  newdecision = true;
                                                  ratedes = true;
                                                });
                                              },
                                              child: Text("Sale rate"),
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
                                              color: Colors.red[300],
                                              onPressed: () {
                                                setState(() {
                                                  newdecision = true;
                                                });
                                              },
                                              child: Text("Sale amount"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                if (ratedes == true) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 30, 10),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) =>
                                              value != null || value != ""
                                                  ? null
                                                  : "Please enter the salerate",
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Sale Rate",
                                              labelStyle:
                                                  TextStyle(fontSize: 17)),
                                          onChanged: (value) {
                                            if (value != null || value != "") {
                                              setState(() {
                                                soldpending = "S";
                                              });
                                            } else {
                                              setState(() {
                                                soldpending = "PENDING";
                                              });
                                            }
                                            setState(() {
                                              salerate = double.parse(value);
                                              saleamount = double.parse(value) *
                                                  newquantity;
                                              pls = saleamount - newbuyamount;
                                              commamount = pls / 100 * commrate;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text(
                                              "Sale amount:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 20, 0),
                                            child: Text(
                                              () {
                                                if (salerate == null ||
                                                    salerate == 0 ||
                                                    salerate == "0" ||
                                                    soldpending == "PENDING") {
                                                  return " PKR 0";
                                                } else {
                                                  return "PKR ${f.format(saleamount)}";
                                                }
                                              }(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 30, 10),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) => value != null ||
                                                  value != ""
                                              ? null
                                              : "Please enter the saleamount",
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Sale Amount",
                                              labelStyle:
                                                  TextStyle(fontSize: 17)),
                                          onChanged: (value) {
                                            if (value != null || value != "") {
                                              setState(() {
                                                soldpending = "S";
                                              });
                                            } else {
                                              setState(() {
                                                soldpending = "PENDING";
                                              });
                                            }
                                            setState(() {
                                              saleamount = int.parse(value);
                                              salerate = int.parse(value) /
                                                  newquantity;
                                              pls = int.parse(value) -
                                                  newbuyamount;
                                              commamount = pls / 100 * commrate;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text(
                                              "Sale rate:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 20, 0),
                                            child: Text(
                                              () {
                                                if (salerate == null ||
                                                    salerate == 0 ||
                                                    salerate == "0" ||
                                                    soldpending == "PENDING") {
                                                  return " PKR 0";
                                                } else {
                                                  return "PKR ${f.format(salerate)}";
                                                }
                                              }(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
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
                            //to this spot
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Profit/Loss:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 20, 0),
                                  child: Text(
                                    () {
                                      if (pls == null ||
                                          pls == 0 ||
                                          pls == "0" ||
                                          soldpending == "PENDING") {
                                        return " PKR 0";
                                      } else {
                                        return "PKR ${f.format(pls)}";
                                      }
                                    }(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Commission Amount:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 20, 0),
                                  child: Text(
                                    () {
                                      if (commamount == null ||
                                          commamount == 0 ||
                                          commamount == "0" ||
                                          soldpending == "PENDING") {
                                        return " PKR 0";
                                      } else {
                                        return "PKR ${f.format(commamount)}";
                                      }
                                    }(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(err,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                10,
                                0,
                                10,
                                10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(15),
                                      onPressed: soldpending == "PENDING" ||
                                              processing == true
                                          ? null
                                          : () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  processing = true;
                                                });
                                                List<Map> data = [
                                                  {
                                                    "propName": "qty",
                                                    "value": quantity
                                                  },
                                                  {
                                                    "propName": "buyamount",
                                                    "value": buyamount
                                                  },
                                                ];
                                                String json1 = jsonEncode(data);
                                                http.Response response =
                                                    await http.patch(url,
                                                        headers: {
                                                          "content-type":
                                                              "application/json"
                                                        },
                                                        body: json1);
                                                if (response.statusCode ==
                                                    200) {
                                                  var newbal =
                                                      balance + saleamount;
                                                  List<Map> bal = [
                                                    {
                                                      "propName": "balance",
                                                      "value": newbal
                                                    }
                                                  ];
                                                  String patch =
                                                      jsonEncode(bal);
                                                  http.Response response =
                                                      await http.patch(
                                                          "http://89.40.11.242:8000/members/${widget.id}",
                                                          headers: {
                                                            "content-type":
                                                                "application/json"
                                                          },
                                                          body: patch);
                                                  if (response.statusCode ==
                                                      200) {
                                                    Map newdata = {
                                                      "email": email,
                                                      "username": username,
                                                      "divbon": divbon,
                                                      "scrip": scrip,
                                                      "buydate": buydate,
                                                      "qty": newquantity,
                                                      "buyrate": buyrate,
                                                      "buyamount": newbuyamount,
                                                      "soldpending":
                                                          soldpending,
                                                      "saledate": saledate,
                                                      "salerate": salerate,
                                                      "saleamount": saleamount,
                                                      "commrate": commrate,
                                                      "cgtrate": cgtrate,
                                                      "pls": pls,
                                                      "netprofit": netprofit,
                                                      "commamount": commamount,
                                                      "status": "u"
                                                    };
                                                    String newdat =
                                                        jsonEncode(newdata);
                                                    http.Response response =
                                                        await http.post(
                                                            "http://89.40.11.242:8000/trades",
                                                            headers: {
                                                              "content-type":
                                                                  "application/json"
                                                            },
                                                            body: newdat);
                                                    if (response.statusCode ==
                                                        201) {
                                                      Navigator.pop(context);
                                                    } else {
                                                      setState(() {
                                                        err =
                                                            "Err: Couldn't post new trade";
                                                        processing = false;
                                                      });
                                                    }
                                                  } else {
                                                    setState(() {
                                                      err =
                                                          "Problem updating balance";
                                                      processing = false;
                                                    });
                                                  }
                                                } else {
                                                  print(
                                                      "Error: ${response.statusCode}");
                                                  setState(() {
                                                    err =
                                                        "Error updating split";
                                                    processing = false;
                                                  });
                                                }
                                              }
                                            },
                                      child: Text("Save Sell"),
                                      color: Colors.red[200],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }
                }(),
              ],
            )),
      ),
    );
  }
}
