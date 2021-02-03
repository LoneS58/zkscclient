import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Sold extends StatefulWidget {
  @override
  _SoldState createState() => _SoldState();
}

class _SoldState extends State<Sold> {
  SharedPreferences logindata;
  Map user;
  var count;
  List trades;
  List tradestoDisplay;
  var f = new NumberFormat("###,##0.00", "en_US");
  var q = new NumberFormat("###,##0", "en_US");
  void getSold() async {
    http.Response response = await http
        .get("http://89.40.11.242:8000/trades/user/S/${user["email"]}");
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
    getSold();
    return user;
  }

  @override
  void initState() {
    setUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[100],
      child: () {
        if (count == null) {
          return Center(
              child: SpinKitChasingDots(
            color: Colors.red,
          ));
        } else if (count == 0) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "No trades in history.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return tradestoDisplay != null
              ? ListView.builder(
                  itemCount: tradestoDisplay.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0 ? _searchBar() : _itemlist(index - 1);
                  })
              : Center(
                  child: SpinKitChasingDots(
                    color: Colors.red,
                  ),
                );
        }
      }(),
    );
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
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: new Card(
          color: Colors.pink[100],
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Scrip:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Quantity:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Buyrate:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Buyamount:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(
                      "Saledate:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Salerate:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Saleamount:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Netprofit:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Comm amount",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Div/Bon:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Status:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      tradestoDisplay[index]["buydate"],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      tradestoDisplay[index]["scrip"],
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${q.format(tradestoDisplay[index]["qty"])}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${f.format(tradestoDisplay[index]["buyrate"]).toString()}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${f.format(tradestoDisplay[index]["buyamount"]).toString()}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Divider(),
                    Text(
                      tradestoDisplay[index]["saledate"],
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${f.format(tradestoDisplay[index]["salerate"]).toString()}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${f.format(tradestoDisplay[index]["saleamount"]).toString()}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${f.format(tradestoDisplay[index]["pls"]).toString()}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${f.format(tradestoDisplay[index]["commamount"]).toString()}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      () {
                        if (tradestoDisplay[index]["divbon"] == "") {
                          return " ";
                        } else {
                          return tradestoDisplay[index]["divbon"];
                        }
                      }(),
                      style: TextStyle(fontSize: 12),
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
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
