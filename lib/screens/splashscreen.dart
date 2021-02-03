import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zksc/screens/login.dart';
import 'package:zksc/screens/updatepage.dart';
import 'package:zksc/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool approve;
  var version;
  void checkVersion() async {
    http.Response response = await http.get("http://89.40.11.242:8000/version");
    setState(() {
      version = jsonDecode(response.body);
    });

    if (response.statusCode == 200) {
      if (v == version["version"]) {
        setState(() {
          approve = true;
        });
      } else {
        setState(() {
          approve = false;
        });
      }
      print(version["version"]);
    }
  }

  @override
  void initState() {
    checkVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (approve) {
      case true:
        return Login();
      case false:
        return UpdatePage(
          ver: version["version"],
        );
        break;
      default:
        return Material(
          type: MaterialType.transparency,
          child: Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('images/logo.png'),
                    height: 200,
                    width: 300,
                  ),
                  SizedBox(height: 40),
                  SpinKitRipple(
                    color: Colors.white,
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    () {
                      if (approve == null) {
                        return "Checking version";
                      } else if (approve == true) {
                        return "Version: $v";
                      }
                    }(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              )),
        );
    }
  }
}
