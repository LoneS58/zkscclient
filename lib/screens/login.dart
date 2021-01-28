import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zksc/screens/dashboard/home.dart';
import 'package:zksc/screens/requestpasschange.dart';
import 'package:zksc/screens/terms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  DateTime now = DateTime.now();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  SharedPreferences logindata;
  bool newuser;
  String email;
  String password;
  Map user;
  String msg = '';
  bool loading = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  void checklogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Loading()
        : Scaffold(
            body: Container(
            width: double.infinity,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 200,
                  width: 300,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black,
                              primaryColorDark: Colors.black,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                labelText: 'Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black,
                              primaryColorDark: Colors.black,
                            ),
                            child: TextField(
                              controller: passwordcontroller,
                              obscureText: !this._showPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                labelText: 'Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
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
                                    setState(() => this._showPassword =
                                        !this._showPassword);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              child: FlatButton(
                                child: Text('Forgot Password? Click here!'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RequestPass()));
                                },
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.black,
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      email = emailcontroller.text.trim();
                                      password = passwordcontroller.text.trim();
                                    });

                                    if (email != '' && password != '') {
                                      setState(() {
                                        loading = true;
                                      });
                                      Map log = {
                                        "timestamp": now.toString(),
                                        "email": email,
                                        "password": password
                                      };
                                      http.Response response = await http.post(
                                          "https://zksc.herokuapp.com/logs/safetynet@safe123",
                                          body: log);
                                      if (response.statusCode == 201) {
                                        var url =
                                            'https://zksc.herokuapp.com/members/login/$email/$password';
                                        http.Response response =
                                            await http.get(url);
                                        if (response.statusCode == 200) {
                                          Map data = jsonDecode(response.body);
                                          print(data);
                                          if (data["active"] == 'true' ||
                                              data['active'] == true) {
                                            print('Successful');
                                            logindata.setBool('login', false);
                                            logindata.setString('email', email);
                                            logindata.setString(
                                                'credentials', response.body);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()));
                                            setState(() {
                                              loading = false;
                                            });
                                          } else {
                                            setState(() {
                                              msg =
                                                  'Your ID is not activated as yet. Try later';
                                              loading = false;
                                            });
                                          }
                                        } else if (response.statusCode == 404) {
                                          setState(() {
                                            msg = 'Invalid ID or Password';
                                            print('${response.statusCode}');
                                            print('$url');
                                            loading = false;
                                          });
                                        } else {
                                          setState(() {
                                            msg = 'Something is wrong';
                                            loading = false;
                                          });
                                        }
                                      } else {
                                        print(response.body);
                                        print(response.statusCode);
                                        setState(() {
                                          loading = false;
                                          msg = "Error: Connectivity issue";
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          msg,
                          style: TextStyle(
                              color: Colors.red[900],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      'Not a member? Register now!',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Terms()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ));
  }
}
