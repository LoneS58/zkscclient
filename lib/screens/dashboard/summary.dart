import 'dart:convert';
import 'package:intl/intl.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ClientSummary extends StatefulWidget {
  final String email;
  final String username;
  final String url;
  @override
  ClientSummary(
      {Key key,
      @required this.email,
      @required this.username,
      @required this.url})
      : super(key: key);
  @override
  _ClientSummaryState createState() => _ClientSummaryState();
}

class _ClientSummaryState extends State<ClientSummary> {
  var f = new NumberFormat("###,##0.00", "en_US");
  var q = new NumberFormat("###,##0", "en_US");
  Map holddata;
  Map liverate;
  List scrips;
  Map saledata;
  var receivedcomm;
  var unrealizedgain;
  var realizedcomm;
  var totalcomm;
  var commamt;
  var balance;
  var duecomm;
  var commrate;
  double totalmval = 0;
  String fetching = "Fetching...";
  @override
  void initState() {
    getData();
    getSales();
    fetchbal();
    comreceived();
    super.initState();
  }

  void comreceived() async {
    http.Response response = await http.get(
        "http://89.40.11.242:8000/payments/safetynet@safe123/summary/user/${widget.email}");
    if (response.statusCode == 200) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ${response.body}");
      setState(() {
        Map data = jsonDecode(response.body);
        receivedcomm = data["cashreceived"];
      });
    }
  }

  void fetchbal() async {
    http.Response response = await http.get(widget.url);
    if (response.statusCode == 200) {
      Map client = jsonDecode(response.body);
      setState(() {
        commrate = client["member"]["commrate"];
        balance = client["member"]["balance"];
      });
      print(client);
    }
  }

  void getData() async {
    print(widget.email);
    http.Response response = await http.get(
        "http://89.40.11.242:8000/trades/summary/user/PENDING/${widget.email}");
    if (response.statusCode == 200) {
      setState(() {
        holddata = jsonDecode(response.body);
        scrips = holddata["scrips"];
      });
      print(holddata);
    }
    getRates();
  }

  void getRates() async {
    http.Response response =
        await http.get("http://89.40.11.242:8000/liverates");
    if (response.statusCode == 200) {
      setState(() {
        liverate = jsonDecode(response.body);
      });
      for (int i = 0; i < scrips.length; i++) {
        var rate = liverate["${scrips[i]["Scrip"]}"];
        var mval = rate * scrips[i]["Quantity"];
        setState(() {
          totalmval += mval;
        });
      }
      print(" A+ ${scrips.length}");
      print(" A+ $scrips");
    }
  }

  void getSales() async {
    http.Response response = await http
        .get("http://89.40.11.242:8000/trades/summary/user/S/${widget.email}");
    if (response.statusCode == 200) {
      setState(() {
        saledata = jsonDecode(response.body);
      });
      print(saledata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Summary"),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      backgroundColor: Colors.blue[100],
      body: scrips != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                        child: Text(
                          "Client -",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 0, 10),
                        child: Text(
                          "${widget.username}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.05);
                        return Colors.blue[200]; // Use the default value.
                      }),
                      columnSpacing: 20,
                      columns: [
                        DataColumn(
                          label: Text("Scrip"),
                          numeric: false,
                          tooltip: "Shows the name of scrip",
                        ),
                        DataColumn(
                          label: Text("Quantity"),
                          numeric: false,
                          tooltip: "The quantity of rows in all trades",
                        ),
                        DataColumn(
                          label: Text("Buy Rate"),
                          numeric: false,
                          tooltip: "Buying rate per share of scrip",
                        ),
                        DataColumn(
                          label: Text("    Cost"),
                          numeric: false,
                          tooltip: "The sum of all buying of the scrip",
                        ),
                        DataColumn(
                          label: Text("M/Rate"),
                          numeric: false,
                          tooltip: "Current rate of each scrip in holding",
                        ),
                        DataColumn(
                          label: Text("M/Value"),
                          numeric: false,
                          tooltip: "Current amount of each scrip in holding",
                        ),
                        DataColumn(
                          label: Text("     PLS"),
                          numeric: false,
                          tooltip: "Profit and loss of each scrip",
                        ),
                        DataColumn(
                          label: Text("  PLS %"),
                          numeric: false,
                          tooltip:
                              "Percentage of profit and loss of each scrip",
                        ),
                      ],
                      rows: scrips
                          .map(
                            (scrips) => DataRow(cells: [
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (holddata == null) {
                                      return fetching;
                                    } else {
                                      return scrips["Scrip"];
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (holddata == null) {
                                      return fetching;
                                    } else {
                                      return q
                                          .format(scrips["Quantity"])
                                          .toString();
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (scrips == null) {
                                      return fetching;
                                    } else {
                                      var buyrate = scrips["Buyamount"] /
                                          scrips["Quantity"];
                                      return f.format(buyrate).toString();
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (holddata == null) {
                                      return fetching;
                                    } else {
                                      return f
                                          .format(scrips["Buyamount"])
                                          .toString();
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (liverate == null) {
                                      return fetching;
                                    } else {
                                      return f
                                          .format(liverate[scrips['Scrip']])
                                          .toString();
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (liverate == null) {
                                      return fetching;
                                    } else {
                                      var liveamount =
                                          liverate[scrips['Scrip']] *
                                              scrips["Quantity"];
                                      return f.format(liveamount).toString();
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (liverate == null || scrips == null) {
                                      return fetching;
                                    } else {
                                      var liveamount =
                                          liverate[scrips['Scrip']] *
                                              scrips["Quantity"];
                                      var pls =
                                          liveamount - scrips["Buyamount"];
                                      return f.format(pls).toString();
                                    }
                                  }()),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(() {
                                    if (liverate == null || scrips == null) {
                                      return fetching;
                                    } else {
                                      var liveamount =
                                          liverate[scrips['Scrip']] *
                                              scrips["Quantity"];
                                      var pls =
                                          liveamount - scrips["Buyamount"];
                                      var plsper =
                                          pls / scrips["Buyamount"] * 100;
                                      return "${f.format(plsper).toString()} %";
                                    }
                                  }()),
                                ),
                              ),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Container(
                      color: Colors.blue[200],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "DESCRIPTION",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "PKR         ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Holding Cost:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (holddata == null) {
                              return fetching;
                            } else {
                              return " ${f.format(holddata["totalbuyamount"]).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Market Value:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (totalmval == 0) {
                              return fetching;
                            } else {
                              return " ${f.format(totalmval).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Unrealized PLS:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (totalmval == 0 ||
                                holddata["totalbuyamount"] == null) {
                              return "Calculating...";
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  unrealizedgain =
                                      totalmval - holddata["totalbuyamount"];
                                });
                              }

                              return " ${f.format(unrealizedgain).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Realized PLS:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (totalmval == 0 || saledata == null) {
                              return "Fetching...";
                            } else {
                              return " ${f.format(saledata["totalpls"]).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total PLS:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (saledata == null || unrealizedgain == null) {
                              return "Calculating...";
                            } else {
                              var total = saledata["totalpls"] + unrealizedgain;
                              return " ${f.format(total).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Unrealized Commission:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (totalmval == 0 ||
                                holddata["totalbuyamount"] == null ||
                                commrate == null) {
                              return "Calculating...";
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  unrealizedgain =
                                      totalmval - holddata["totalbuyamount"];
                                  commamt = unrealizedgain * commrate / 100;
                                });
                              }

                              return " ${f.format(commamt).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Realized Commission:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (saledata == null) {
                              return "Fetching...";
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  realizedcomm =
                                      saledata["totalcommissionamount"];
                                });
                              }
                              return " ${f.format(realizedcomm).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total commission:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (commamt == null || saledata == null) {
                              return fetching;
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  totalcomm = commamt +
                                      saledata["totalcommissionamount"];
                                });
                              }

                              return " ${f.format(totalcomm).toString()}";
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Received:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (receivedcomm == null || totalcomm == null) {
                              return fetching;
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  duecomm = totalcomm - receivedcomm;
                                });
                              }

                              return f.format(receivedcomm).toString();
                            }
                          }(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total commission due:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (duecomm == null) {
                              return "Calculating...";
                            } else {
                              return f.format(duecomm).toString();
                            }
                          }(),
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cash Balance:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          () {
                            if (balance == null) {
                              return fetching;
                            } else {
                              return " ${f.format(balance)}";
                            }
                          }(),
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
              ),
            ),
    );
  }
}
