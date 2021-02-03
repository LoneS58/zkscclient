import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zksc/screens/dashboard/addtrade.dart';
import 'package:zksc/screens/dashboard/selltrade.dart';
import 'package:intl/intl.dart';

class Holding extends StatefulWidget {
  @override
  _HoldingState createState() => _HoldingState();
}

class _HoldingState extends State<Holding> {
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
        await http.get("http://89.40.11.242:8000/liverates");
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          liverates = jsonDecode(response.body);
        });
      }
    }
  }

  Future<List> getHold() async {
    http.Response response = await http
        .get("http://89.40.11.242:8000/trades/user/PENDING/${user["email"]}");
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
    return tradestoDisplay;
  }

  Future<Map> setUser() async {
    logindata = await SharedPreferences.getInstance();
    String credentials = logindata.getString("credentials");
    setState(() {
      user = jsonDecode(credentials);
    });
    print(user);
    getHold();
    return user;
  }

  @override
  void initState() {
    setUser();
    getLiveRates();
    super.initState();
  }

  int balance = 0;
  int commission = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.greenAccent[100],
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(children: [
                Expanded(
                  child: RaisedButton(
                      color: Colors.green[300],
                      child: Text("Add Buy Trade"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTrade(
                                    email: user["email"],
                                    username: user["username"],
                                    id: user["_id"]))).then((value) {
                          setState(() {
                            tradestoDisplay = null;
                          });
                          getHold();
                        });
                      }),
                )
              ]),
            ),
            () {
              if (count == null) {
                print("1");
                return Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Center(
                      child: SpinKitChasingDots(
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              } else if (count == 0) {
                print("2");
                return Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No holdings.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                print("3");
                return Expanded(
                    child: SizedBox(
                        height: double.infinity,
                        child: tradestoDisplay != null
                            ? ListView.builder(
                                itemCount: tradestoDisplay.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return index == 0
                                      ? _searchBar()
                                      : _itemlist(index - 1);
                                })
                            : SpinKitChasingDots(
                                color: Colors.green,
                              )));
              }
            }(),
          ],
        ));
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
                color: Colors.green[100],
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
                            "Buy rate:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Buy amount:",
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
                                  return " ";
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
                      getHold();
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
