import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zksc/screens/dashboard/selltrade.dart';
import 'package:intl/intl.dart';

class SaleCall extends StatefulWidget {
  @override
  _SaleCallState createState() => _SaleCallState();
}

class _SaleCallState extends State<SaleCall> {
  SharedPreferences logindata;
  Map user;
  var count;
  List trades;
  List tradestoDisplay;
  Map liverates;
  var f = new NumberFormat("###,##0.00", "en_US");
  var q = new NumberFormat("###,##0", "en_US");
  void getLiveRates() async {
    http.Response response =
        await http.get("https://zksc.herokuapp.com/liverates");
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          liverates = jsonDecode(response.body);
        });
      }
    }
  }

  void getSales() async {
    http.Response response = await http
        .get("https://zksc.herokuapp.com/trades/salecalllist/${user["email"]}");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (this.mounted) {
        setState(() {
          count = json["count"];
          trades = json["trades"];
          tradestoDisplay = trades;
        });
      }
    }
  }

  Future<Map> setUser() async {
    logindata = await SharedPreferences.getInstance();
    String credentials = logindata.getString("credentials");
    setState(() {
      user = jsonDecode(credentials);
    });
    print(user);
    getSales();
    return user;
  }

  @override
  void initState() {
    setUser();
    getLiveRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[100],
        child: () {
          if (count == null) {
            return Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
              ),
            );
          } else if (count == 0) {
            return Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "No sale calls",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ));
          } else {
            return tradestoDisplay != null
                ? ListView.builder(
                    itemCount: tradestoDisplay.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return index == 0 ? _searchBar() : _itemlist(index - 1);
                    })
                : Center(
                    child: SpinKitChasingDots(
                      color: Colors.blue,
                    ),
                  );
          }
        }());
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search by scrip...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            tradestoDisplay = trades.where((trade) {
              var tradeScrip = trade["scrip"].toLowerCase();
              return tradeScrip.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _itemlist(index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: new Card(
                color: Colors.lightBlue[50],
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Buydate:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Scrip:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quantity:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Buyrate:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Buyamount:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Current rate:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Current amount:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "PLS:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Status:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Div/Bon:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tradestoDisplay[index]["buydate"],
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            tradestoDisplay[index]["scrip"],
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "${q.format(tradestoDisplay[index]["qty"])}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "${f.format(tradestoDisplay[index]["buyrate"]).toString()}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "${f.format(tradestoDisplay[index]["buyamount"]).toString()}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            () {
                              if (liverates != null) {
                                return "${f.format(liverates[tradestoDisplay[index]['scrip']]).toString()}";
                              } else {
                                return "Fetching...";
                              }
                            }(),
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            () {
                              if (liverates != null) {
                                var currentamount =
                                    liverates[tradestoDisplay[index]['scrip']] *
                                        tradestoDisplay[index]['qty'];
                                return "${f.format(currentamount).toString()}";
                              } else {
                                return "Fetching...";
                              }
                            }(),
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            () {
                              if (liverates != null) {
                                var currentamount =
                                    liverates[tradestoDisplay[index]['scrip']] *
                                        tradestoDisplay[index]['qty'];
                                var pls = currentamount -
                                    tradestoDisplay[index]["buyamount"];
                                return "${f.format(pls).toString()}";
                              } else {
                                return "Calculating...";
                              }
                            }(),
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            () {
                              switch (tradestoDisplay[index]["status"]) {
                                case "a":
                                  return "Approved";
                                case "u":
                                  return "Unapproved";
                                case "s":
                                  return "Sale Call";
                                  break;
                                default:
                              }
                            }(),
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            () {
                              if (tradestoDisplay[index]["divbon"] == "") {
                                return " ";
                              } else {
                                return tradestoDisplay[index]["divbon"];
                              }
                            }(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              children: [
                Expanded(
                    child: RaisedButton(
                  child: Text("Sell"),
                  elevation: 10,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellTrade(
                                id: user["_id"],
                                trade: tradestoDisplay[index]))).then((value) {
                      setState(() {
                        tradestoDisplay = null;
                      });
                      getSales();
                    });
                  },
                  color: Colors.red[100],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
