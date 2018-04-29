import 'package:flutter/material.dart';
import '../model/events.dart';

class EventPage extends StatelessWidget {

  final Event event;

  EventPage(this.event);

  @override
  Widget build(BuildContext context) {
    print("build");
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text("Event " + event.name),
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


