import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/apptoken_storage.dart';
import '../model/consts.dart';
import '../ui/event.dart';
import '../ui/bottom_bar.dart';
import '../model/appconfs.dart';
import '../model/events.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final AppConfs appConfs;
  final AppTokenStorage storage;

  MyHomePage({Key key, this.title, this.appConfs, this.storage}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/*
 * ================== STATE MANAGEMENT =========================================
 */
class _MyHomePageState extends State<MyHomePage> {
  Event futureEvent = new Event.empty();
  List<Event> closedEvents = [new Event.empty()]; // new List();

  Future<Map<String, dynamic>> _scaricaEventi(AppConfs appConfs) async {
    http.Response res = await http.get(
        Consts.API_BASE_URL + '/events/summary/list',
        headers: {'Authorization': appConfs.appToken});

    print("GET: '" + Consts.API_BASE_URL + '/events/summary/list' + "', statusCode: " + res.statusCode.toString());
    return json.decode(res.body);
  }

  @override
  void initState() {
    super.initState();
    var scaricaEventi = _scaricaEventi(widget.appConfs);
    scaricaEventi.then((onValue) {
      if (onValue['body']['futureEvents'] != null) {
        List<dynamic> eventiFuturi = onValue['body']['futureEvents'];
        dynamic eventoFuturo;
        if ( eventiFuturi != null && eventiFuturi.length > 0) {
          eventoFuturo = onValue['body']['futureEvents'][0];
        }
        List<Event> _closed = new List();
        var closedEventsJson = onValue['body']['closedEvents'];
        if (closedEventsJson != null) {
          for (var evn in closedEventsJson) {
            Event e = Event.fromJson(evn);
            _closed.add(e);
          }
        }
        setState(() {
          if (eventoFuturo != null) {
            futureEvent = new Event.fromJson(eventoFuturo);
          } else {
            futureEvent = new Event.named("No future event yet");
          }
          closedEvents = _closed;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child:new Column(
          children: <Widget>[
            new NextEvent(futureEvent),
            new Expanded(
              child:  ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                    new EventEntryItem(closedEvents[index]),
                  itemCount: closedEvents.length,
                ),
              ),
          ]),
      ),
      bottomNavigationBar: new BottomBar( widget.appConfs, widget.storage),
    );
  }
}
