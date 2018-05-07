import 'package:flutter/material.dart';
import '../model/events.dart';
import '../model/consts.dart';

import '../pages/event_page.dart';


class EventEntryItem extends StatelessWidget {
  final Event entry;

  const EventEntryItem(this.entry);

  void eventSelected() {
    print("selected " + entry.name);
  }

  void gotoToEventPage(BuildContext context, Event event) {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) => new EventPage(event)
        )
    );
  }
  Widget _buildTiles(BuildContext context, Event root) {
    return Column(children: <Widget>[
      new ListTile(
        title:
            new FlatButton(onPressed: () => gotoToEventPage(context, root),
                child: new Text(root.name,
                   style: new TextStyle(
                      color: Colors.grey[555],
                      fontSize: Consts.EVENT_CLOSED_TITLE_FONT_SIZE,
                    ),
                  )
              ), //,
        subtitle: new Text("closed " + root.end),
      ),
      new ImagesRow(entry)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(context, entry);
  }
}

class ImagesRow extends StatelessWidget {
  final Event event;

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
  final Event event;

  NextEvent(this.event);

  @override
  State createState() => new NextEventState();
}

/// mostra widget con informazioni su prossimo evento
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
                          color: Colors.grey[555],
                          fontSize: 24.0
                        ))),
                new Text("inizia  tra ..." ),
                widget.event.isFuture()
                    ? new Text("")
                    : new ImagesRow(widget.event),
              ],
            )));
  }
}
