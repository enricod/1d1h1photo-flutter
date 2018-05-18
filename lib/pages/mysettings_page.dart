import 'package:flutter/material.dart';
import '../model/appconfs.dart';
import '../model/apptoken_storage.dart';
import '../pages/login_page.dart';

/// pagina con dati utente, e possibilità di Logout
class MySettingsPage extends StatelessWidget{
  final AppConfs appConfs;

  MySettingsPage(this.appConfs);
  
  void doLogout(BuildContext context) {
    this.appConfs.appToken = '';
    this.appConfs.username = '';
    this.appConfs.email = '';

    AppTokenStorage storage = new AppTokenStorage();
    storage.writeConfs(this.appConfs);
    
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => new LoginPage( )
      )
    );
  }

  
  @override
  Widget build(BuildContext context) {

    double _fontSize = 18.0;
    var _textStyle = new TextStyle(
                    color: Colors.grey[222],
                    fontSize: _fontSize
                  );
    var _labelTextStyle = new TextStyle(
                    color: Colors.grey[222],
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold
                  );                  
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text("My settings"),
      ),
      body:  new Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text('Username: ',
                    style: _labelTextStyle,
                  ),
                  new Text( appConfs.username,
                    style: _textStyle,
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text("Email: ",
                    style: _labelTextStyle, 
                  ),
                  new Text( appConfs.email,
                    style: _textStyle,
                  ),
                ]
              ),
              new RaisedButton( 
                child: new Text("Logout"),
                onPressed: () => doLogout(context)),
          ]
        )
      )
      )
    ;
  }
  
}



