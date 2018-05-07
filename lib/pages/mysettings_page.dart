import 'package:flutter/material.dart';
import '../model/appconfs.dart';
import '../model/apptoken_storage.dart';
import '../pages/login_page.dart';


/// pagina con dati utente, e possibilità di Logout
class MySettingsPage extends StatelessWidget{
  final AppConfs appConfs;
  final AppTokenStorage storage;

  MySettingsPage(this.appConfs, this.storage);
  
  void doLogout(BuildContext context) {
    this.appConfs.appToken = '';
    this.appConfs.username = '';
    this.appConfs.email = '';
    storage.writeConfs(this.appConfs);
    
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => new LoginPage( this.storage)
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text("My settings"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Username: " + appConfs.username),
            new Text("Email: " + appConfs.email),
            new RaisedButton( 
              child: new Text("Logout"),
              onPressed: () => doLogout(context)),
          ]
        )
      )
    );
  }
  
}



