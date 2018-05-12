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

  String thumbUrl(int index) {
    if (this.event.submissions != null && this.event.submissions.length > index) {
      return Consts.API_BASE_URL + '/' + this.event.submissions[index].thumbUrl;
    }
    // FIXME
    return "https://c1.staticflickr.com/9/8028/28941101031_e93b862b44_q.jpg";
  }
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Image.network( thumbUrl(0))
        ),
        new Expanded(
          child: new Image.network( thumbUrl(1))
        ),
        new Expanded(
          child: new Image.network( thumbUrl(2))
        ),
      ],
    );
  }
}

class NextEvent extends StatefulWidget {
  
  final Event event;

  NextEvent(this.event);

  @override
  State createState() => new NextEventState(this.event);
}

/// mostra widget con informazioni su prossimo evento
class NextEventState extends State<NextEvent> {

  String startingIn = '';

  Event event;

  NextEventState(this.event);

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
                new Row(children: <Widget>
                    [ 
                      
                      new Text( widget.event.counter() ),
                    ]
                ),
                widget.event.isFuture()
                    ? new Text('')
                    : new ImagesRow(event),
              ],
            )));
  }
}
