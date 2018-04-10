import 'package:flutter/material.dart';

class NextEvent extends StatefulWidget {
  @override
  State createState() => new NextEventState();
}


class NextEventState extends State<NextEvent> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.yellowAccent,
      child:  new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Center(
          child: new Text("Next event in ",
          style: new TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
          )
        )
      )
    );
  }
}