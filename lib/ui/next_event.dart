import 'package:flutter/material.dart';
import '../model/events.dart';

class ImagesRow extends StatelessWidget {
  Event event;

  ImagesRow(this.event);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
       new Expanded(
          child: new Image.network(
              "https://c1.staticflickr.com/9/8028/28941101031_e93b862b44_q.jpg"),
        ),
        new Expanded(
          child: new Image.network(
              "https://c1.staticflickr.com/3/2665/32060536633_6c743b9f11_q.jpg"),
        ),
        new Expanded(
          child: new Image.network(
              "https://c1.staticflickr.com/5/4313/36075724132_2d3722d870_q.jpg"),
        ),
      ],
    );
  }
}

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
        color: Colors.amber[50],
        child: new Padding(
            padding: new EdgeInsets.all(5.0),
            child: new Column(
              children: <Widget>[
                new Center(
                    child: new Text(
                  widget.event.name,
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                )),
                new Text("inizia  tra ..."),
                widget.event.futuro ? new Text("") : new ImagesRow(widget.event)  ,

              ],
            )));
  }
}
