import 'package:flutter/material.dart';

class MyPhotosPage extends StatefulWidget {

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
    
    return new Material(
      color:Colors.blueAccent,
      child: new Text("sono la pagina personale")
    );
  }

}

