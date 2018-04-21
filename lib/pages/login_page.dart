import 'package:flutter/material.dart';
import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import '../model/consts.dart';
import '../model/appconfs.dart';
import '../model/apptoken_storage.dart';
import '../pages/home_page.dart';


class LoginPage extends StatefulWidget {
  final String title = "Login";

  final List<CameraDescription> cameras;

  AppTokenStorage storage;

  LoginPage(this.storage, this.cameras);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {

  String _username;

  String _email;

  // usato per identificare telefono
  String _apptoken = '';

  // codice di validazione, inviato via email
  String _code = '';

  bool _codeValid = false;

  // esegue chiama al servizio per la registrazione dell'utente
  static Future<Map> doRegisterUser(Map reqBody) async {
    http.Response res = await http.post(Consts.API_BASE_URL + '/users/register',
        body: json.encode(reqBody));
    final responseJson = json.decode(res.body);
    return responseJson;
  }

  static Future<bool> doValidateCode(Map reqBody) async {
    http.Response res = await http.post(Consts.API_BASE_URL + '/users/codeValidation',
        body: json.encode(reqBody));
    return (res.statusCode == 200);
  }

  void registerUser(String email, String username) {
    Future<Map>  response =  doRegisterUser(
        {'username': username, 'email': email});
    response.then(
            (value) {
              if (value['head']['success'] == true)
              {
                setState(() {
                 this._apptoken = value['body']['appToken'];
                });
              }
            },
          onError: (e) { print (e); } );
  }

  void validateCode(String apptoken, String code) {
    Future<bool>  response =  doValidateCode(
        {'AppToken': apptoken, 'Code': code});
    response.then( (value) {
          if (value) {
            setState(() {
              this._codeValid = true;

              print ("codice valido!");
              AppConfs newAppConfs = new AppConfs();
              newAppConfs.username = this._username;
              newAppConfs.email = this._email;
              newAppConfs.appToken = this._apptoken;

              widget.storage.writeConfs(newAppConfs);

              Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (context) => new MyHomePage(title: Consts.APP_TITLE
                          , cameras: widget.cameras
                          , appConfs: newAppConfs)
                  )
              );
              // TODO
              // salva configurazioni
              // vai a home page
            });
          } else {
            // TODO
            // mostra messaggio di errore
          }
        },
        onError: (e) { print (e); } );
  }


  void sendData(String email, String username, String code) {
    if (code == '') {
      registerUser(email, username);
    } else {
      validateCode(this._apptoken, this._code);
    }
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
                sendData(_email, _username, _code);
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
              onChanged:  (val) => setState(() {this._email = val; }),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Codice di validazione",
              ),
              onChanged:  (val) => setState(() {this._code = val; }),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          new Text(_apptoken)
        ],
      ),
    );
  }
}
