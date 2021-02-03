import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditBalance extends StatefulWidget {
  final String id;
  final dynamic balance;
  EditBalance({Key key, @required this.id, @required this.balance})
      : super(key: key);
  @override
  _EditBalanceState createState() => _EditBalanceState();
}

class _EditBalanceState extends State<EditBalance> {
  TextEditingController balpass = TextEditingController();
  bool processing = false;
  var f = new NumberFormat("###,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Edit balance"),
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Card(
                elevation: 30,
                color: Colors.blue[100],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Text(
                            "Current balance",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Text(
                            "PKR ${f.format(widget.balance).toString()}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: balpass,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "New balance",
                            labelStyle: TextStyle(fontSize: 17)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        elevation: 30,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Save balance",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                        onPressed: processing == true
                            ? null
                            : () async {
                                setState(() {
                                  processing = true;
                                });
                                List patch = [
                                  {
                                    "propName": "balance",
                                    "value": "${balpass.text}"
                                  }
                                ];
                                String json = jsonEncode(patch);
                                http.Response response = await http.patch(
                                    "http://89.40.11.242:8000/members/${widget.id}",
                                    headers: {
                                      "content-type": "application/json"
                                    },
                                    body: json);
                                if (response.statusCode == 200) {
                                  print(response.statusCode);
                                  setState(() {
                                    processing = false;
                                  });
                                  Navigator.pop(context);
                                } else {
                                  print(response.statusCode);
                                  setState(() {
                                    processing = false;
                                  });
                                }
                              },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
