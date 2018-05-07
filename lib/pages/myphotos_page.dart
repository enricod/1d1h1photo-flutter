import 'package:flutter/material.dart';
import '../model/appconfs.dart';

class MyPhotosPage extends StatefulWidget {

  final AppConfs appConfs;

  MyPhotosPage(this.appConfs);

  @override
  _MyPhotosState createState() => new _MyPhotosState();
}

class _MyPhotosState extends State<MyPhotosPage> {
  
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text("widget.title"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("my photos")
          ]
        )
      )
    );
  }

}

