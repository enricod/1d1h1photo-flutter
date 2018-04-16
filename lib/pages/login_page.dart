import 'package:flutter/material.dart';
import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/consts.dart';

class LoginPage extends StatefulWidget {
  final String title = "Login";

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool alreadyregistered = false;
  String _username;
  String email;
  String apptoken = '';


  // esegue chiama al servizio per la registrazione dell'utente
  static Future<Map> doRegisterUser(Map reqBody) async {
    http.Response res = await http.post(Consts.API_BASE_URL + '/users/register',
        body: json.encode(reqBody));
    final responseJson = json.decode(res.body);
    return responseJson;
  }

  void registerUser(String email, String username) {
    Future<Map>  response =  doRegisterUser(
        {'username': username, 'email': email});
    response.then(
            (value) {
              if (value['head']['success'] == true)
              {
                setState(() {
                  apptoken = value['body']['appToken'];
                });
              }
            },
          onError: (e) { print (e); } );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                registerUser(email, _username);
              })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Username",
              ),
              onChanged:  (val) => setState(() {this._username = val; }),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Email",
              ),
              onChanged:  (val) => setState(() {this.email = val; }),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          new Text(apptoken)
        ],
      ),
    );
  }
}
