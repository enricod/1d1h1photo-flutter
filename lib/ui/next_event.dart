import 'package:flutter/material.dart';
import '../model/events.dart';

class NextEvent extends StatefulWidget {

  Event event;

  NextEvent(this.event);

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
      color: Colors.amber,
      child:  new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Center(
          child: new Text(widget.event.name,
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